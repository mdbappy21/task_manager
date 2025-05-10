import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/data/model_class/login_model.dart';
import 'package:task_manager/data/model_class/network_response.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/ui/Screen/authentication/email_verification_screen.dart';
import 'package:task_manager/ui/Screen/authentication/sign_up_screen.dart';
import 'package:task_manager/ui/Screen/main_bottom_nav_screen.dart';
import 'package:task_manager/ui/controller/auth_controller.dart';
import 'package:task_manager/ui/controller/sign_in_controller.dart';
import 'package:task_manager/ui/utility/app_colors.dart';
import 'package:task_manager/ui/utility/app_constants.dart';
import 'package:task_manager/ui/widgets/background_widget.dart';
import 'package:task_manager/ui/widgets/snack_bar_massage.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailTEController=TextEditingController();
  final TextEditingController _passwordTEController=TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _showPassword = true;
  final SignInController _signInController = Get.find<SignInController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 100),
                    Text('Get Started With',style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 24),
                    _buildTextFormField(),
                    const SizedBox(height: 16),
                    GetBuilder<SignInController>(
                      builder: (signInController) {
                        return Visibility(
                          visible: !signInController.signInProgress,
                          replacement: Center(child: CircularProgressIndicator()),
                          child: ElevatedButton(
                            onPressed:_onTapNextButton, child: Icon(Icons.arrow_circle_right_outlined,color: Colors.white,),
                          ),
                        );
                      }
                    ),
                    const SizedBox(height: 40),
                    _buildSignUpAndForgotPasswordSection(),
                    // Text('Don\'t have account ? Sign up')
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField() {
    return Column(
      children: [
        TextFormField(
          controller: _emailTEController,
          keyboardType: TextInputType.emailAddress,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(hintText: 'Email'),
          validator: (String? value) {
            if (value?.trim().isEmpty ?? true) {
              return 'Enter your Email';
            } else if (AppConstants.emailRegExp.hasMatch(value!) == false) {
              return 'Enter a valid email address';
            }
            return null;
          },
        ),
        const SizedBox(height: 8),
        TextFormField(
          obscureText: _showPassword,
          controller: _passwordTEController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
              hintText: 'Password',
              suffixIcon: IconButton(
                  onPressed: () {
                    _showPassword = !_showPassword;
                    if (mounted) {
                      setState(() {});
                    }
                  },
                  icon: Icon(_showPassword ? Icons.visibility_off : Icons.visibility)
              ),
          ),
          validator: (String? value) {
            if (value?.trim().isEmpty ?? true) {
              return 'Enter your Password';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildSignUpAndForgotPasswordSection() {
    return Center(
      child: Column(
        children: [
          TextButton(
            onPressed: _onTapForgotEmail,
            child: Text('Forgot Password ?'),
          ),
          RichText(
            text: TextSpan(
              style: TextStyle(
                  color: Colors.black26,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.4,
                  fontSize: 16,
              ),
              text: "Don't Have an account ?",
              children: [
                TextSpan(
                    text: 'Sign up',
                    style: TextStyle(color: AppColors.themeColor),
                    recognizer: TapGestureRecognizer()..onTap = _onTapSignUpButton,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onTapNextButton() async{
    if (_formKey.currentState!.validate()) {
      bool result = await _signInController.signIn(
      _emailTEController.text, _passwordTEController.text);
      if(result){
        Get.off(MainBottomNavScreen());
      }else{
        if(mounted){
          showSnackBarMassage(context, 'Login Failed !try again');
        }
      }
    }
  }

  void _onTapSignUpButton() {
    Get.to(()=>SignUpScreen());
  }

  void _onTapForgotEmail() {
    Get.to(()=>EmailVerificationScreen());
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
