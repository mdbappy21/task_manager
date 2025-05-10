import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/Screen/authentication/pin_verification_screen.dart';
import 'package:task_manager/ui/controller/email_verification_controller.dart';
import 'package:task_manager/ui/utility/app_constants.dart';
import 'package:task_manager/ui/widgets/background_widget.dart';
import 'package:task_manager/ui/widgets/center_progress_indicator.dart';
import 'package:task_manager/ui/widgets/sign_in_section.dart';
import 'package:task_manager/ui/widgets/snack_bar_massage.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final TextEditingController _emailTEController=TextEditingController();
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();
  final EmailVerificationController _emailVerificationController = Get.find<EmailVerificationController>();

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
                    Text('Your Email Address', style: Theme.of(context).textTheme.titleLarge,),
                    Text('A 6 digits verification pin will send to your email address', style: Theme.of(context).textTheme.titleSmall,),
                    const SizedBox(height: 24),
                    _buildTextFormField(),
                    const SizedBox(height: 16),
                    _buildNextButton(),
                    const SizedBox(
                      height: 40,
                    ),
                    SignInSection(onTap: _onTapSignInButton)
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

  Widget _buildNextButton() {
    return GetBuilder<EmailVerificationController>(
      builder: (emailVerificationController) {
        return Visibility(
          visible: !emailVerificationController.emailVerificationInProgress,
          replacement: CenterProgressIndicator(),
          child: ElevatedButton(
            onPressed: _onTapNextButton,
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
    return TextFormField(
      controller: _emailTEController,
      keyboardType: TextInputType.emailAddress,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(hintText: 'Email'),
      validator: (String? value) {
        if (value?.trim().isEmpty == true) {
          return 'Enter Your Email';
        } else if (AppConstants.emailRegExp.hasMatch(value!) == false) {
          return 'Enter a valid email address';
        }
        return null;
      },
    );
  }

  Future<void> _onTapNextButton() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    bool result = await _emailVerificationController.verifyEmail(_emailTEController.text.trim());
    if (result) {
      Get.to(PinVerificationScreen(email: _emailTEController.text));
    } else {
      if (mounted) {
        showSnackBarMassage(context,'Email has not register yet. Try signup');
      }
    }
  }

  void _onTapSignInButton() {
    Get.back();
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    super.dispose();
  }
}
