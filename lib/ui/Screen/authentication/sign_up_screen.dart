import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/data/model_class/network_response.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/ui/utility/app_colors.dart';
import 'package:task_manager/ui/utility/app_constants.dart';
import 'package:task_manager/ui/widgets/background_widget.dart';
import 'package:task_manager/ui/widgets/snack_bar_massage.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _showPassword = true;
  bool _registrationInProgress = false;

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
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 100),
                    Text('Join With Us',
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _firstNameTEController,
                      decoration: InputDecoration(hintText: 'First Name'),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter your First Name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),

                    TextFormField(
                      controller: _lastNameTEController,
                      decoration: InputDecoration(hintText: 'Last Name'),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter your last Name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),

                    TextFormField(
                      controller: _mobileTEController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(hintText: 'Mobile No'),
                      validator: (String? value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Enter your mobile Number';
                        } else if (!AppConstants.numberRegExp
                            .hasMatch(value.trim())) {
                          return 'Enter valid mobile Number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),

                    TextFormField(
                      controller: _emailTEController,
                      keyboardType: TextInputType.emailAddress,
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
                      decoration: InputDecoration(
                          hintText: 'Password',
                          suffixIcon: IconButton(
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
                      visible: _registrationInProgress==false,
                      replacement: Center(
                        child: CircularProgressIndicator(),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _registerUser();
                          }
                        },
                        child: Icon(
                          Icons.arrow_circle_right_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),

                    _buildBackToSignInSection(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _registerUser() async {
    _registrationInProgress = true;
    if (mounted) {
      setState(() {});
    }
    Map<String, dynamic> requestInput = {
      "email": _emailTEController.text,
      "firstName": _firstNameTEController.text.trim(),
      "lastName": _lastNameTEController.text.trim(),
      "mobile": _mobileTEController.text,
      "password": _passwordTEController.text,
      "photo": ''
    };

    NetworkResponse response = await NetworkCaller.postRequest(
        Urls.registrationUrl,
        body: requestInput,
    );

    _registrationInProgress = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      _clearTextField();
      if (mounted) {
        showSnackBarMassage(context, 'Registration Success');
      }
    }
    else {
      if (mounted) {
        showSnackBarMassage(context,
            response.errorMassage ?? 'Registration Failed ! try again');
      }
    }
  }

  void _clearTextField() {
    _emailTEController.clear();
    _firstNameTEController.clear();
    _lastNameTEController.clear();
    _mobileTEController.clear();
    _passwordTEController.clear();
  }

  Widget _buildBackToSignInSection() {
    return Center(
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
                text: 'Sign In',
                style: TextStyle(color: AppColors.themeColor),
                recognizer: TapGestureRecognizer()..onTap = _onTapSignInButton)
          ],
        ),
      ),
    );
  }

  void _onTapSignInButton() {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    super.dispose();
  }
}
