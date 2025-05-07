import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/data/model_class/network_response.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/ui/Screen/authentication/pin_verification_screen.dart';
import 'package:task_manager/ui/utility/app_colors.dart';
import 'package:task_manager/ui/utility/app_constants.dart';
import 'package:task_manager/ui/widgets/background_widget.dart';
import 'package:task_manager/ui/widgets/center_progress_indicator.dart';
import 'package:task_manager/ui/widgets/snack_bar_massage.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final TextEditingController _emailTEController=TextEditingController();
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();
  bool _inProgress = false;
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
                    Text('Your Email Address',style: Theme.of(context).textTheme.titleLarge),
                    Text('A 6 digits verification pin will send to your email address',style: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _emailTEController,
                      keyboardType: TextInputType.emailAddress,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                          hintText: 'Email'
                      ),
                      validator: (String? value){
                        if(value?.trim().isEmpty==true){
                          return 'Enter Your Email';
                        }else if (AppConstants.emailRegExp.hasMatch(value!) ==
                            false) {
                          return 'Enter a valid email address';
                        }return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    Visibility(
                      visible: !_inProgress,
                      replacement: CenterProgressIndicator(),
                      child: ElevatedButton(
                        onPressed: _onTapNextButton,
                        child: Icon(
                          Icons.arrow_circle_right_outlined,
                          color: Colors.white,
                        ),
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
      ),
    );
  }

  Future<void> _onTapNextButton() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    bool result = await verifyEmail(_emailTEController.text.trim());
    if (result) {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>PinVerificationScreen(email: _emailTEController.text)));
    } else {
      if (mounted) {
        showSnackBarMassage(context,'Email has not register yet. Try login');
      }
    }
  }

  Future<bool> verifyEmail(String email) async {
    bool isSuccess = false;
    _inProgress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response = await NetworkCaller.getRequest(
        Urls.recoveryEmail(email));

    if (response.isSuccess) {
      isSuccess = true;
    } else {}

    _inProgress = false;
    if (mounted) {
      setState(() {});
    }
    return isSuccess;
  }

  void _onTapSignUpButton() {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    super.dispose();
  }
}
