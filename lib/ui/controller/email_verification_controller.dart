import 'package:get/get.dart';
import 'package:task_manager/data/model_class/network_response.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/utility/urls.dart';

class EmailVerificationController extends GetxController{
  bool _emailVerificationInProgress=false;
  bool get emailVerificationInProgress=>_emailVerificationInProgress;

  Future<bool> verifyEmail(String email) async {
    bool isSuccess = false;
    _emailVerificationInProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller.getRequest(
        Urls.recoveryEmail(email));

    if (response.isSuccess&& response.responseData['status']=='success') {
      isSuccess = true;
    } else {
      isSuccess=false;
    }

    _emailVerificationInProgress = false;
    update();
    return isSuccess;
  }
}