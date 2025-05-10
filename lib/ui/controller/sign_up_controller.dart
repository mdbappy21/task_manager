import 'package:get/get.dart';
import 'package:task_manager/data/model_class/network_response.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/utility/urls.dart';

class SignUpController extends GetxController{
  bool _signUpInProgress = false;

  bool get signUpInProgress => _signUpInProgress;

  Future<bool> registerUser(String email,String firstName,String lastName,String mobile,String password) async {
    bool isSuccess=false;
    _signUpInProgress = true;
    update();

    Map<String, dynamic> requestInput = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
      "password": password,
      "photo": ''
    };

    NetworkResponse response = await NetworkCaller.postRequest(
      Urls.registrationUrl,
      body: requestInput,
    );

    _signUpInProgress = false;
    update();
    if (response.isSuccess) {
      isSuccess=true;
    }
    else {
      isSuccess=false;
    }
    return isSuccess;
  }
}