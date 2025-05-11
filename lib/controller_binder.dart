import 'package:get/get.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/ui/controller/add_new_task_controller.dart';
import 'package:task_manager/ui/controller/auth_controller.dart';
import 'package:task_manager/ui/controller/cancel_task_controller.dart';
import 'package:task_manager/ui/controller/complete_task_controller.dart';
import 'package:task_manager/ui/controller/delete_task_controller.dart';
import 'package:task_manager/ui/controller/edit_task_controller.dart';
import 'package:task_manager/ui/controller/email_verification_controller.dart';
import 'package:task_manager/ui/controller/in_progress_task_controller.dart';
import 'package:task_manager/ui/controller/new_task_controller.dart';
import 'package:task_manager/ui/controller/otp_verification_controller.dart';
import 'package:task_manager/ui/controller/reset_password_controller.dart';
import 'package:task_manager/ui/controller/sign_in_controller.dart';
import 'package:task_manager/ui/controller/sign_up_controller.dart';
import 'package:task_manager/ui/controller/task_count_by_status_controller.dart';
import 'package:task_manager/ui/controller/update_profile_controller.dart';


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
    Get.put(UpdateProfileController());
    Get.put(AddNewTaskController());
    Get.put(NewTaskController());
    Get.put(TaskCountByStatusController());
    Get.put(CancelTaskController());
    Get.put(CompleteTaskController());
    Get.put(InProgressTaskController());
    Get.put(DeleteTaskController());
    Get.put(EditTaskController());
  }
}