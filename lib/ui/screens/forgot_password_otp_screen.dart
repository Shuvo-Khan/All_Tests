import 'package:first_project/ui/controllers/verify_otp_controller.dart';
import 'package:first_project/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:first_project/ui/screens/reset_password_screen.dart';
import 'package:first_project/ui/screens/sign_in_screen.dart';
import 'package:first_project/ui/utils/app_colors.dart';
import 'package:first_project/ui/widgets/screen_background.dart';
import '../widgets/snack_bar_message.dart';

class ForgotPasswordOtpScreen extends StatefulWidget {
  ForgotPasswordOtpScreen({super.key, required this.email});

  static const name = '/forgot_password_otp_screen';
  final String email;

  @override
  State<ForgotPasswordOtpScreen> createState() =>
      _ForgotPasswordOtpScreenState();
}

class _ForgotPasswordOtpScreenState extends State<ForgotPasswordOtpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _pinCodeTEController = TextEditingController();
  final VerifyOtpController _verifyOtpController =
      Get.find<VerifyOtpController>();

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
                  'Pin Verification',
                  style: textTheme.displaySmall
                      ?.copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                Text(
                  'Put 6 digits verification otp to verify it.',
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
          PinCodeTextField(
            controller: _pinCodeTEController,
            length: 6,
            animationType: AnimationType.fade,
            keyboardType: TextInputType.number,
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(5),
              fieldHeight: 50,
              fieldWidth: 40,
              activeFillColor: Colors.white,
              inactiveFillColor: Colors.white,
              selectedFillColor: Colors.white,
            ),
            animationDuration: const Duration(milliseconds: 300),
            backgroundColor: Colors.transparent,
            enableActiveFill: true,
            appContext: context,
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter yor pin';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          GetBuilder<VerifyOtpController>(builder: (controller) {
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
      _recoverVerifyOtp();
      Get.to(() => ResetPasswordScreen(
            email: widget.email,
            otp: _pinCodeTEController.text,
          ));
    }
  }

  void _onTapSignIn() {
    Navigator.pushNamedAndRemoveUntil(context, SignInScreen.name, (_) => false);
  }

  Future<void> _recoverVerifyOtp() async {
    final bool result = await _verifyOtpController.recoverVerifyOtp(
        widget.email, _pinCodeTEController.text);

    if (result) {
      showSnackBarMessage(
          context, 'Congrats your otp verification successfull');
    } else {
      showSnackBarMessage(context, _verifyOtpController.errorMessage!, true);
    }
  }
}
