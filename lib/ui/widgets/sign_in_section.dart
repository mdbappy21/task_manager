import 'package:flutter/material.dart';
import 'package:task_manager/ui/utility/app_Colors.dart';
import 'package:flutter/gestures.dart';

class SignInSection extends StatelessWidget {
  final VoidCallback onTap;

  const SignInSection({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            color: Colors.black.withOpacity(0.6),
            fontWeight: FontWeight.w600,
            letterSpacing: 0.4,
            fontSize: 16,
          ),
          text: "Have an account ? ",
          children: [
            TextSpan(
              text: 'Sign in',
              style: TextStyle(color: AppColors.themeColor),
              recognizer: TapGestureRecognizer()..onTap = onTap,
            ),
          ],
        ),
      ),
    );
  }
}