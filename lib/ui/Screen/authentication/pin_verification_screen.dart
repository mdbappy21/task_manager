import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager/ui/Screen/authentication/reset_password_screen.dart';
import 'package:task_manager/ui/Screen/authentication/sign_in_screen.dart';
import 'package:task_manager/ui/controller/otp_verification_controller.dart';
import 'package:task_manager/ui/utility/app_colors.dart';
import 'package:task_manager/ui/widgets/background_widget.dart';
import 'package:task_manager/ui/widgets/center_progress_indicator.dart';
import 'package:task_manager/ui/widgets/sign_in_section.dart';
import 'package:task_manager/ui/widgets/snack_bar_massage.dart';

class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({super.key, required this.email});
  final String email;
  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  final TextEditingController _pinTEController=TextEditingController();
  final OtpVerificationController _otpVerificationController = Get.find<OtpVerificationController>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 100),
                  Text('PIN Verification', style: Theme.of(context).textTheme.titleLarge,),
                  Text('A 6 digits verification pin has been sent to your email address',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 24),
                  _buildPinCodeTextField(),
                  const SizedBox(height: 16),
                  _buildVerifyButton(),
                  const SizedBox(height: 40,),
                  SignInSection(onTap: _onTapSignInButton)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVerifyButton() {
    return GetBuilder<OtpVerificationController>(
      builder: (otpVerificationController) {
        return Visibility(
          visible: !otpVerificationController.otpVerificationInProgress,
          replacement: CenterProgressIndicator(),
          child: ElevatedButton(
              onPressed: _onTapVerifyOtpButton, child: Text('Verify')),
        );
      },
    );
  }

  Widget _buildPinCodeTextField() {
    return PinCodeTextField(
      length: 6,
      obscureText: false,
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 50,
        fieldWidth: 40,
        activeFillColor: Colors.white,
        selectedFillColor: Colors.white,
        inactiveFillColor: Colors.white,
        selectedColor: AppColors.themeColor,
      ),
      animationDuration: Duration(milliseconds: 300),
      backgroundColor: Colors.transparent,
      keyboardType: TextInputType.number,
      enableActiveFill: true,
      controller: _pinTEController,
      appContext: context,
    );
  }

  void _onTapSignInButton() {
    Get.offAll(SignInScreen());
  }

  Future<void> _onTapVerifyOtpButton() async {
    if (_pinTEController.text.length != 6) {
      showSnackBarMassage(context, "Write 6 digit OTP");
      return;
    }
    bool result = await _otpVerificationController.verifyOTP(widget.email,_pinTEController.text.trim());
    if (result) {
      Get.to(ResetPasswordScreen(email: widget.email, otp: _pinTEController.text));
    } else {
      if (mounted) {
        showSnackBarMassage(context,'Otp is not Correct yet.give Using correct OTP');
      }
    }
  }
}
