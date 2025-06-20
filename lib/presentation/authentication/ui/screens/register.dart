import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/custom_button.dart';
import '../../../../core/common/custom_text_button.dart';
import '../../../../core/common/custom_text_field.dart';
import '../../../../core/common/dialog_utils.dart';
import '../../../../core/di/di.dart';
import '../../../../core/routes/route_names.dart';
import '../../../../core/utils/validators.dart';

import '../cubit/authentication/auth_states.dart';
import '../cubit/authentication/auth_view_model.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthViewModel authViewModel = getIt<AuthViewModel>();
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return BlocListener<AuthViewModel, AuthStates>(
      bloc: authViewModel,
      listener: (context, state) {
        if (state is ShowLoading) {
          DialogUtils.showLoading(context: context);
        } else if (state is ErrorState) {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
            context: context,
            message: state.errorMessage,
            title: "Error",
            posActionName: 'Ok',
          );
        } else if (state is SuccessState) {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
            context: context,
            message: 'Account Created Successfully',
            title: "Welcome ${state.response.userData.name}",
            posActionName: 'Ok',
            posAction: (){
              Navigator.pushReplacementNamed(context, RouteNames.login);
            }
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Theme.of(context).cardColor,
          backgroundColor: Theme.of(context).cardColor,
          elevation: 6,
          shadowColor: Colors.black.withOpacity(0.1),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(24),
            ),
          ),
          title: Text('Register', style: Theme.of(context).textTheme.titleMedium),
          centerTitle: true,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: authViewModel.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),

                  /// Name
                  CustomTextField(
                    label: "Name",
                    controller: authViewModel.nameController,
                    prefixIcon: Icons.person_outline,
                    keyboardType: TextInputType.text,
                    inputColor: Theme.of(context).primaryColor,
                    validator: (p0) => AppValidators.validateUsername(p0),
                  ),

                  SizedBox(height: height * 0.02),

                  /// Email
                  CustomTextField(
                    label: "Email",
                    controller: authViewModel.emailController,
                    prefixIcon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    validator: AppValidators.validateEmail,
                    inputColor: Theme.of(context).primaryColor,
                  ),

                  SizedBox(height: height * 0.02),

                  /// Password
                  CustomTextField(
                    label: "Password",
                    controller: authViewModel.passwordController,
                    prefixIcon: Icons.lock_outline,
                    obscureText: hidePassword,
                    maxLines: 1,
                    validator: AppValidators.validatePassword,
                    inputColor: Theme.of(context).primaryColor,
                    suffixIcon: hidePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    onSuffixPressed: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                  ),

                  SizedBox(height: height * 0.02),

                  /// Confirm Password
                  CustomTextField(
                    label: "Confirm Password",
                    controller: authViewModel.rePasswordController,
                    prefixIcon: Icons.lock_outline,
                    obscureText: hidePassword,
                    maxLines: 1,
                    validator: (p0) => AppValidators.validateConfirmPassword(
                      p0,
                      authViewModel.passwordController.text,
                    ),
                    inputColor: Theme.of(context).primaryColor,
                    suffixIcon: hidePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    onSuffixPressed: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                  ),

                  SizedBox(height: height * 0.02),

                  /// Phone
                  CustomTextField(
                    label: "Phone",
                    controller: authViewModel.phoneController,
                    prefixIcon: Icons.phone,
                    keyboardType: TextInputType.phone,
                    inputColor: Theme.of(context).primaryColor,
                    validator: (p0) => AppValidators.validatePhoneNumber(p0),
                  ),

                  SizedBox(height: height * 0.03),

                  /// Register Button
                  CustomButton(
                    body: Text(
                      "Create Account",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                    color: Colors.transparent,
                    onPressed: () async {
                      await authViewModel.register();
                    },
                  ),

                  const SizedBox(height: 20),

                  /// Login Redirect
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      CustomTextButton(
                        txt: "Login",
                        onPressed: () {
                          Navigator.pushNamed(context, RouteNames.login);
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
