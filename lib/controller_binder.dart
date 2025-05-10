import 'package:get/get.dart';
import 'package:task_manager/ui/controller/auth_controller.dart';
import 'package:task_manager/ui/controller/email_verification_controller.dart';
import 'package:task_manager/ui/controller/otp_verification_controller.dart';
import 'package:task_manager/ui/controller/reset_password_controller.dart';
import 'package:task_manager/ui/controller/sign_in_controller.dart';
import 'package:task_manager/ui/controller/sign_up_controller.dart';

import 'data/network_caller/network_caller.dart';

class ControllerBinder extends Bindings{
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.put(NetworkCaller());
    Get.put(SignInController());
    Get.put(SignUpController());
    Get.put(EmailVerificationController());
    Get.put(OtpVerificationController());
    Get.put(ResetPasswordController());
  }
}