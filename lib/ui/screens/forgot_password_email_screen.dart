import 'package:first_project/ui/controllers/forgot_password_email_controller.dart';
import 'package:first_project/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:first_project/ui/screens/forgot_password_otp_screen.dart';
import 'package:first_project/ui/utils/app_colors.dart';
import 'package:first_project/ui/widgets/screen_background.dart';
import '../widgets/snack_bar_message.dart';
import 'package:get/get.dart';

class ForgotPasswordEmailScreen extends StatefulWidget {
  const ForgotPasswordEmailScreen({super.key});

  static const name = '/forgot_password_email_screen';

  @override
  State<ForgotPasswordEmailScreen> createState() =>
      _ForgotPasswordEmailScreenState();
}

class _ForgotPasswordEmailScreenState extends State<ForgotPasswordEmailScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailTEController = TextEditingController();
  final ForgotPasswordEmailController _forgotPasswordEmailController =
      Get.find<ForgotPasswordEmailController>();

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
                  'Your Email Address',
                  style: textTheme.displaySmall
                      ?.copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                Text(
                  'A 6 digits verification otp will be sent to your email address',
                  style: textTheme.titleSmall?.copyWith(color: Colors.grey),
                ),
                const SizedBox(height: 24),
                _buildVerifyEmailForm(),
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

  Widget _buildVerifyEmailForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailTEController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: 'Email'),
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter an email';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          GetBuilder<ForgotPasswordEmailController>(builder: (controller) {
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
      _forgotEmailSent();
      Get.to(() => ForgotPasswordOtpScreen(email: _emailTEController.text));
    }
  }

  void _onTapSignIn() {
    Get.back();
  }

  Future<void> _forgotEmailSent() async {
    final bool result = await _forgotPasswordEmailController
        .forgotEmailSent(_emailTEController.text);

    if (result) {
      showSnackBarMessage(context, '6 digit otp has sent to your email.');
    } else {
      showSnackBarMessage(
          context, _forgotPasswordEmailController.errorMessage!, true);
    }
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    super.dispose();
  }
}
