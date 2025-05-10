import 'package:get/get.dart';
import 'package:task_manager/data/model_class/login_model.dart';
import 'package:task_manager/data/model_class/network_response.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/ui/controller/auth_controller.dart';

class SignInController extends GetxController {
  bool _signInProgress = false;

  bool get signInProgress => _signInProgress;

  Future<bool> signIn(String email, String password) async {
    bool isSuccess = false;
    _signInProgress = true;
    update();
    Map<String, dynamic> requestData = {
      'email': email,
      'password': password,
    };
    final NetworkResponse response =
        await NetworkCaller.postRequest(Urls.logInUrl, body: requestData);
    _signInProgress = false;
    update();
    if (response.isSuccess) {
      isSuccess = true;
      LoginModel loginModel = LoginModel.fromJson(response.responseData);
      await AuthController.saveUserAccessToken(loginModel.token!);
      await AuthController.saveUserData(loginModel.userModel!);
    } else {
      isSuccess = false;
    }
    return isSuccess;
  }
}
