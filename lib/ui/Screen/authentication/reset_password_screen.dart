import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/Screen/authentication/sign_in_screen.dart';
import 'package:task_manager/ui/controller/reset_password_controller.dart';
import 'package:task_manager/ui/widgets/background_widget.dart';
import 'package:task_manager/ui/widgets/center_progress_indicator.dart';
import 'package:task_manager/ui/widgets/sign_in_section.dart';
import 'package:task_manager/ui/widgets/snack_bar_massage.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key, required this.email, required this.otp});

  final String email;
  final String otp;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _passwordTEController=TextEditingController();
  final TextEditingController _confirmPasswordTEController=TextEditingController();
  final ResetPasswordController _resetPasswordController = Get.find<ResetPasswordController>();

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
                  Text('Set Password',style: Theme.of(context).textTheme.titleLarge),
                  Text(
                    'Minimum length of password should be more than 6 letters and combination of numbers and letters',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 24),
                  _buildTextFormFiled(),
                  const SizedBox(height: 16),
                  _buildConfirmButton(),
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

  Widget _buildTextFormFiled() {
    return Column(
      children: [
        TextFormField(
          controller: _passwordTEController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(hintText: 'Password'),
        ),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          controller: _confirmPasswordTEController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(hintText: 'Confirm Password'),
        ),
      ],
    );
  }

  Widget _buildConfirmButton() {
    return GetBuilder<ResetPasswordController>(
      builder: (resetPasswordController) {
        return Visibility(
          visible: !resetPasswordController.resetPasswordInProgress,
          replacement: CenterProgressIndicator(),
          child: ElevatedButton(
            onPressed: _onTapConfirmPassword,
            child: Text('Confirm Password'),
          ),
        );
      },
    );
  }

  Future<void> _onTapConfirmPassword() async {
    if(_passwordTEController!=_confirmPasswordTEController){
      showSnackBarMassage(context, 'Miss match confirm password');
      return;
    }
    bool result = await _resetPasswordController.resetCurrentPassword(widget.email,widget.otp,_confirmPasswordTEController.text);
    if (result) {
      if(mounted){
        showSnackBarMassage(context, 'Password Reset successfully. you can login');
      }
      Get.offAll(SignInScreen());
    } else {
      if (mounted) {
        showSnackBarMassage(context,'password change failed. Try again');
      }
    }
  }

  void _onTapSignInButton() {
    Get.offAll(SignInScreen());
  }

  @override
  void dispose() {
    _passwordTEController.dispose();
    _confirmPasswordTEController.dispose();
    super.dispose();
  }
}
