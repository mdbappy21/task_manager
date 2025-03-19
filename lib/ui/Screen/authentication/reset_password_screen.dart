import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/Screen/authentication/sign_in_screen.dart';
import 'package:task_manager/ui/utility/app_colors.dart';
import 'package:task_manager/ui/widgets/background_widget.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _passwordTEController=TextEditingController();
  final TextEditingController _confirmPasswordTEController=TextEditingController();

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
                  ElevatedButton(
                      onPressed: _onTapConfirmPassword,
                      child: Text('Confirm Password')
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

  void _onTapConfirmPassword() {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>SignInScreen()), (route)=>false);
  }

  void _onTapSignUpButton() {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>SignInScreen()), (route)=>false);
  }

  @override
  void dispose() {
    _passwordTEController.dispose();
    _confirmPasswordTEController.dispose();
    super.dispose();
  }
}
