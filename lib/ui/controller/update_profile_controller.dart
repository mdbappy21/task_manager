import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager/data/model_class/network_response.dart';
import 'package:task_manager/data/model_class/user_model.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/ui/controller/auth_controller.dart';

class UpdateProfileController extends GetxController {
  bool _updateProfileInProgress = false;

  bool get updateProfileInProgress => _updateProfileInProgress;

  Future<bool> updateProfile(String email, String firstName, String lastName, String mobile, String? password, XFile? selectedImage) async {
    bool isSuccess = false;
    _updateProfileInProgress = true;
    update();
    String encodedPhoto = AuthController.userData?.photo ?? '';

    Map<String, dynamic> requestBody = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
    };
    if (password!=null || password!='') {
      requestBody['password'] = password;
    }

    if (selectedImage != null) {
      File file = File(selectedImage.path);
      encodedPhoto = base64Encode(file.readAsBytesSync());
      requestBody['photo'] = encodedPhoto;
    }
    final NetworkResponse response =
        await NetworkCaller.postRequest(Urls.profileUpdate, body: requestBody);
    if (response.isSuccess && response.responseData['status'] == 'success') {
      isSuccess = true;
      UserModel userModel = UserModel(
        email: email,
        photo: encodedPhoto,
        firstName: firstName,
        lastName: lastName,
        mobile: mobile,
      );
      await AuthController.saveUserData(userModel);
    } else {
      isSuccess = false;
    }
    _updateProfileInProgress = false;
    update();
    return isSuccess;
  }
}
