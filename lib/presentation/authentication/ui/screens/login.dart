import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/di.dart';
import '../../../../core/routes/route_names.dart';
import '../../../../core/theme/color.dart';
import '../../../common/custom_button.dart';
import '../../../common/custom_text_button.dart';
import '../../../common/custom_text_field.dart';
import '../../../common/dialog_utils.dart';
import '../cubit/authentication/auth_states.dart';
import '../cubit/authentication/auth_view_model.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthViewModel authViewModel = getIt<AuthViewModel>();
  bool _obscurePassword = true;

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
            title: "Login Failed",
            message: state.errorMessage,
            posActionName: 'OK',
          );
        } else if (state is SuccessState) {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
            context: context,
            title: "Success",
            message: 'Logged in successfully\nToken: ${state.response.token}',
            posActionName: 'OK',
          );
          Navigator.pushReplacementNamed(context, RouteNames.homeScreen);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Login", style: TextTheme.of(context).titleMedium),
          elevation: 0,
          forceMaterialTransparency: true,
          foregroundColor: Colors.transparent,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: authViewModel.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 60),

                  /// Logo
                  Center(
                    child: Image.asset(
                      "assets/images/globe icon.png",
                      color: Theme.of(context).primaryColor,
                    ),
                  ),

                  const SizedBox(height: 60),

                  /// Email
                  CustomTextField(
                    controller: authViewModel.emailController,
                    label: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    inputColor: Theme.of(context).primaryColor,
                    prefixIcon: Icons.email_outlined,
                  ),

                  const SizedBox(height: 15),

                  /// Password
                  CustomTextField(
                    controller: authViewModel.loginPasswordController,
                    label: 'Password',
                    obscureText: _obscurePassword,
                    inputColor: Theme.of(context).primaryColor,
                    maxLines: 1,
                    prefixIcon: Icons.lock_outline,
                    suffixIcon:
                        _obscurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                    onSuffixPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),

                  const SizedBox(height: 10),

                  /// Forget Password Button
                  Align(
                    alignment: Alignment.centerRight,
                    child: CustomTextButton(
                      txt: "Forget Password?",
                      onPressed: () {
                        Navigator.pushNamed(context, RouteNames.forgetPassword);
                      },
                      color: appbarLightColor,
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// Login Button
                  CustomButton(
                    body: Text(
                      'Login',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                    color: Colors.transparent,
                    onPressed: () {
                      authViewModel.login();
                    },
                  ),

                  const SizedBox(height: 20),

                  /// Register Navigation
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      CustomTextButton(
                        txt: "Create Account",
                        onPressed: () {
                          Navigator.pushNamed(context, RouteNames.register);
                        },
                        color: appbarLightColor,
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
