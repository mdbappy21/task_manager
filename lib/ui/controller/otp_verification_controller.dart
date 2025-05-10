import 'package:get/get.dart';
import 'package:task_manager/data/model_class/network_response.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/utility/urls.dart';

class OtpVerificationController extends GetxController {
  bool _otpVerificationInProgress = false;

  bool get otpVerificationInProgress => _otpVerificationInProgress;

  Future<bool> verifyOTP(String email, String otp) async {
    bool isSuccess = false;
    _otpVerificationInProgress = true;
    update();
    final NetworkResponse response =
        await NetworkCaller.getRequest(Urls.recoveryOtp(email, otp));
    if (response.isSuccess && response.responseData['status'] == 'success') {
      isSuccess = true;
    } else {
      isSuccess = false;
    }
    _otpVerificationInProgress = false;
    update();
    return isSuccess;
  }
}
