import 'package:get/get.dart';
import 'package:task_manager/data/model_class/network_response.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/utility/urls.dart';

class ResetPasswordController extends GetxController{
  bool _resetPasswordInProgress=false;
  bool get resetPasswordInProgress=>_resetPasswordInProgress;

  Future<bool> resetCurrentPassword(String email,String otp,String password) async {
    bool isSuccess = false;
    _resetPasswordInProgress = true;
    update();
    Map<String , dynamic> inputParams={
      "email":email,
      "OTP": otp,
      "password":password
    };
    final NetworkResponse response = await NetworkCaller.postRequest(Urls.resetPassword,body: inputParams);
    if (response.isSuccess) {
      isSuccess = true;
    } else {
      isSuccess=false;
    }
    _resetPasswordInProgress = false;
    update();
    return isSuccess;
  }
}