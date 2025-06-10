import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/di.dart';
import '../../../common/custom_button.dart';
import '../../../common/custom_text_field.dart';
import '../../../common/dialog_utils.dart';
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
            title: "Failed to Reset Password",
            posActionName: 'Ok',
          );
        } else if (state is SuccessState) {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
            context: context,
            message: 'Password Reset Successfully\n${state.response.message}',
            title: "Success",
            posActionName: 'Ok',
          );
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          centerTitle: true,
          title: Text("Forget Password", style: TextTheme.of(context).titleMedium),
          elevation: 0,
          forceMaterialTransparency: true,
          foregroundColor: Colors.transparent,
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
                    suffixIcon: hidePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    onSuffixPressed: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
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
