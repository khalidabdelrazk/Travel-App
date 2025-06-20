import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel/core/utils/validators.dart';

import '../../../../core/common/custom_button.dart';
import '../../../../core/common/custom_text_field.dart';
import '../../../../core/common/dialog_utils.dart';
import '../../../../core/di/di.dart';

import '../../../../core/routes/route_names.dart';
import '../cubit/authentication/auth_states.dart';
import '../cubit/authentication/auth_view_model.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final AuthViewModel authViewModel = getIt<AuthViewModel>();

  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
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
            title: state.errorMessage,
            posActionName: 'Ok',
          );
        } else if (state is SuccessState) {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
            context: context,
            message: 'Password Reset Successfully',
            title: "Success",
            posActionName: 'Ok',
            posAction: () {
              Navigator.pushReplacementNamed(context, RouteNames.login);
            },
          );
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          surfaceTintColor: Theme.of(context).cardColor,
          backgroundColor: Theme.of(context).cardColor,
          elevation: 6,
          shadowColor: Colors.black.withOpacity(0.1),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
          ),
          centerTitle: true,
          title: Text(
            "Forget Password",
            style: TextTheme.of(context).titleMedium,
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
            child: Form(
              key: authViewModel.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Email
                  CustomTextField(
                    label: "Email",
                    controller: authViewModel.emailController,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icons.email_outlined,
                    inputColor: Theme.of(context).primaryColor,
                    labelColor: Theme.of(context).primaryColor,
                    validator: (p0) => AppValidators.validateEmail(p0),
                  ),
                  const SizedBox(height: 25),

                  /// New Password
                  CustomTextField(
                    label: "New Password",
                    controller: authViewModel.resetPasswordController,
                    obscureText: hidePassword,
                    maxLines: 1,
                    keyboardType: TextInputType.visiblePassword,
                    prefixIcon: Icons.lock_outline,
                    suffixIcon:
                        hidePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                    onSuffixPressed: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                    validator: (p0) => AppValidators.validatePassword(p0),
                    inputColor: Theme.of(context).primaryColor,
                    labelColor: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(height: 30),

                  /// Reset Button
                  CustomButton(
                    body: Text(
                      "Reset Password",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    color: Theme.of(context).scaffoldBackgroundColor,
                    backgroundColor: Theme.of(context).primaryColor,
                    onPressed: () async {
                      await authViewModel.resetPassword();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
