import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/data/model_class/login_model.dart';
import 'package:task_manager/data/model_class/network_response.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/ui/Screen/authentication/email_verification_screen.dart';
import 'package:task_manager/ui/Screen/authentication/sign_up_screen.dart';
import 'package:task_manager/ui/Screen/main_bottom_nav_screen.dart';
import 'package:task_manager/ui/controller/auth_controller.dart';
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
  bool _signInProgress = false;

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

                    TextFormField(
                      controller: _emailTEController,
                      keyboardType: TextInputType.emailAddress,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(hintText: 'Email'),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter your Email';
                        } else if (AppConstants.emailRegExp.hasMatch(value!) ==
                            false) {
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
                      decoration: InputDecoration(hintText: 'Password',suffixIcon: IconButton(
                          onPressed: () {
                            _showPassword = !_showPassword;
                            if (mounted) {
                              setState(() {});
                            }
                          },
                          icon: Icon(_showPassword
                              ? Icons.visibility_off
                              : Icons.visibility))),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter your Password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),


                    Visibility(
                      visible: _signInProgress==false,
                      replacement: Center(child: CircularProgressIndicator()),
                      child: ElevatedButton(
                        onPressed:_onTapNextButton, child: Icon(Icons.arrow_circle_right_outlined,color: Colors.white,),
                      ),
                    ),
                    const SizedBox(height: 40,),

                    Center(
                      child: Column(
                        children: [
                          TextButton(onPressed:_onTapForgotEmail, child: Text('Forgot Password ?')),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                  color: Colors.black26,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.4,
                                  fontSize: 16),
                              text: "Don't Have an account ?",
                              children: [
                                TextSpan(
                                    text: 'Sign up',
                                    style: TextStyle(color: AppColors.themeColor),
                                    recognizer: TapGestureRecognizer()..onTap = _onTapSignUpButton

                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
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

  Future<void> _signIn() async {
    _signInProgress = true;
    if (mounted) {
      setState(() {});
    }

    Map<String, dynamic> requestData = {
      'email': _emailTEController.text.trim(),
      'password': _passwordTEController.text,
    };

    final NetworkResponse response =
        await NetworkCaller.postRequest(Urls.logInUrl, body: requestData);
    _signInProgress = false;
    if (mounted) {
      setState(() {});
    }

    if (mounted) {
      if (response.isSuccess) {
        LoginModel loginModel = LoginModel.fromJson(response.responseData);
        await AuthController.saveUserAccessToken(loginModel.token!);
        await AuthController.saveUserData(loginModel.userModel!);

        if (mounted) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => MainBottomNavScreen()));
        }
      } else {
        showSnackBarMassage(context,
            response.errorMassage ?? 'Email or password is not correct');
      }
    }
  }

  void _onTapNextButton(){
    if(_formKey.currentState!.validate()){
      _signIn();
    }
  }

  void _onTapSignUpButton() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SignUpScreen(),
      ),
    );
  }

  void _onTapForgotEmail() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => EmailVerificationScreen()));
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
