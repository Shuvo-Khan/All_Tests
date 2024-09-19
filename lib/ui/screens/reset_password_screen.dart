import 'package:first_project/ui/controllers/reset_password_controller.dart';
import 'package:first_project/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:first_project/ui/widgets/snack_bar_message.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:first_project/ui/screens/sign_in_screen.dart';
import 'package:first_project/ui/utils/app_colors.dart';
import 'package:first_project/ui/widgets/screen_background.dart';
import 'package:get/get.dart';

import '../../app.dart';

class ResetPasswordScreen extends StatefulWidget {
  ResetPasswordScreen({super.key, required this.email, required this.otp});

  static const name = '/reset_password_screen';
  final String email;
  final String otp;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _confirmPasswordTEController =
      TextEditingController();
  final ResetPasswordController _resetPasswordController =
      Get.find<ResetPasswordController>();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 82),
                Text(
                  'Set Password',
                  style: textTheme.displaySmall
                      ?.copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                Text(
                  'Minimum number of password should be 7 letters',
                  style: textTheme.titleSmall?.copyWith(color: Colors.grey),
                ),
                const SizedBox(height: 24),
                _buildResetPasswordForm(),
                const SizedBox(height: 48),
                Center(
                  child: _buildHaveAccountSection(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResetPasswordForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _passwordTEController,
            decoration: const InputDecoration(hintText: 'Password'),
            obscureText: true,
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter a password';
              }
              return null;
            },
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _confirmPasswordTEController,
            decoration: const InputDecoration(hintText: 'Confirm Password'),
            obscureText: true,
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter a confirm password';
              }
              if (value != _passwordTEController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          GetBuilder<ResetPasswordController>(builder: (controller) {
            return Visibility(
              visible: !controller.inProgress,
              replacement: const CenteredCircularProgressIndicator(),
              child: ElevatedButton(
                onPressed: _onTapNextButton,
                child: const Icon(Icons.arrow_circle_right_outlined),
              ),
            );
          })
        ],
      ),
    );
  }

  Widget _buildHaveAccountSection() {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 14,
            letterSpacing: 0.5),
        text: "Have account? ",
        children: [
          TextSpan(
              text: 'Sign In',
              style: const TextStyle(color: AppColors.themeColor),
              recognizer: TapGestureRecognizer()..onTap = _onTapSignIn),
        ],
      ),
    );
  }

  void _onTapNextButton() {
    if (_formKey.currentState!.validate()) {
      _resetPassword();
      Navigator.pushNamedAndRemoveUntil(
          context, SignInScreen.name, (_) => false);
    }
  }

  void _onTapSignIn() {
    Navigator.pushNamedAndRemoveUntil(context, SignInScreen.name, (_) => false);
  }

  Future<void> _resetPassword() async {
    final bool result = await _resetPasswordController.resetPassword(
        widget.email, widget.otp, _passwordTEController.text);

    if (result) {
      showSnackBarMessage(TaskManagerApp.navigatorKey.currentContext!, 'Password reset successful !');
    } else {
      showSnackBarMessage(TaskManagerApp.navigatorKey.currentContext!, _resetPasswordController.errorMessage!, true);
    }
  }
}
