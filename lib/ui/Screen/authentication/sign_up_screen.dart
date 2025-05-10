import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/Screen/authentication/sign_in_screen.dart';
import 'package:task_manager/ui/controller/sign_up_controller.dart';
import 'package:task_manager/ui/utility/app_constants.dart';
import 'package:task_manager/ui/widgets/background_widget.dart';
import 'package:task_manager/ui/widgets/sign_in_section.dart';
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
  final SignUpController _signUpController = Get.find<SignUpController>();

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
                    Text('Join With Us', style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 24),
                    _buildTextFormField(),
                    const SizedBox(height: 16),
                    _buildSignUpButton(),
                    const SizedBox(height: 40),
                    SignInSection(onTap: _onTapSignInButton)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpButton() {
    return GetBuilder<SignUpController>(
      builder: (signUpController) {
        return Visibility(
          visible: !signUpController.signUpInProgress,
          replacement: Center(
            child: CircularProgressIndicator(),
          ),
          child: ElevatedButton(
            onPressed:_onTabSignUpButton,
            child: Icon(
              Icons.arrow_circle_right_outlined,
              color: Colors.white,
            ),
          ),
        );
      }
    );
  }

  Widget _buildTextFormField() {
    return Column(
      children: [
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
            } else if (!AppConstants.numberRegExp.hasMatch(value.trim())) {
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
          decoration: InputDecoration(
            hintText: 'Password',
            suffixIcon: IconButton(
              onPressed: () {
                _showPassword = !_showPassword;
                if (mounted) {
                  setState(() {});
                }
              },
              icon:
                  Icon(_showPassword ? Icons.visibility_off : Icons.visibility),
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

  void _onTabSignUpButton() async{
    if (_formKey.currentState!.validate()) {
      bool result = await _signUpController.registerUser(
          _emailTEController.text,
          _passwordTEController.text,
          _firstNameTEController.text,
          _lastNameTEController.text,
          _mobileTEController.text);
      if(result){
        Get.off(SignInScreen());
        if(mounted){
          showSnackBarMassage(context, 'Registration Complete. You Can login');
        }
      }else{
        if(mounted){
          showSnackBarMassage(context, 'Registration Failed !try again');
        }
      }
    }else{
      return;
    }
  }

  void _onTapSignInButton() {
    Get.back();
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
