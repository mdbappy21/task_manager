import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/data/model_class/network_response.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/ui/Screen/authentication/sign_in_screen.dart';
import 'package:task_manager/ui/utility/app_colors.dart';
import 'package:task_manager/ui/widgets/background_widget.dart';
import 'package:task_manager/ui/widgets/center_progress_indicator.dart';
import 'package:task_manager/ui/widgets/snack_bar_massage.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key, required this.Email, required this.Otp});

  final String Email;
  final String Otp;
  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _passwordTEController=TextEditingController();
  final TextEditingController _confirmPasswordTEController=TextEditingController();
  bool _inProgress=false;

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
                  Text('Minimum length of password should be more than 6 letters and combination of numbers and letters',style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _passwordTEController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        hintText: 'Password'
                    ),
                  ),
                  const SizedBox(height: 8,),
                  TextFormField(
                    controller: _confirmPasswordTEController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        hintText: 'Confirm Password'
                    ),
                  ),
                  const SizedBox(height: 16),
                  Visibility(
                    visible: !_inProgress,
                    replacement: CenterProgressIndicator(),
                    child: ElevatedButton(
                        onPressed: _onTapConfirmPassword,
                        child: Text('Confirm Password')
                    ),
                  ),
                  const SizedBox(height: 40,),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.6),
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.4,
                            fontSize: 16),
                        text: "Have an account ?",
                        children: [
                          TextSpan(
                              text: 'Sign in',
                              style: TextStyle(color: AppColors.themeColor),
                              recognizer: TapGestureRecognizer()..onTap = _onTapSignUpButton

                          )
                        ],
                      ),
                    ),
                  ),
                  // Text('Don\'t have account ? Sign up')
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onTapConfirmPassword() async {
    bool result = await resetCurrentPassword(_confirmPasswordTEController.text);
    if (result) {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>SignInScreen()), (route)=>false);
    } else {
      if (mounted) {
        showSnackBarMassage(context,'password change failed. Try again');
      }
    }
    //
  }

  void _onTapSignUpButton() {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>SignInScreen()), (route)=>false);
  }

  Future<bool> resetCurrentPassword(String password) async {
    bool isSuccess = false;
    _inProgress = true;
    if (mounted) {
      setState(() {});
    }
    Map<String , dynamic> inputParams={
      "email":widget.Email,
      "OTP": widget.Otp,
      "password":password
    };
    final NetworkResponse response = await NetworkCaller.postRequest(Urls.resetPassword,body: inputParams);
    if (response.isSuccess) {
      isSuccess = true;
    } else {
      isSuccess=false;
      if(mounted){
        showSnackBarMassage(context, 'Email Varification Failed! give write OTP');
      }
    }

    _inProgress = false;
    if (mounted) {
      setState(() {});
    }
    return isSuccess;
  }

  @override
  void dispose() {
    _passwordTEController.dispose();
    _confirmPasswordTEController.dispose();
    super.dispose();
  }
}
