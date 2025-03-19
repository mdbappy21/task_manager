import 'package:task_manager/data/model_class/user_model.dart';

class LoginModel {
  String? status;
  UserModel? userModel;
  String? token;

  LoginModel({this.status, this.userModel, this.token});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    userModel = json['data'] != null ? UserModel.fromJson(json['data']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['token'] = token;
    if (userModel != null) {
      data['data'] = userModel!.toJson();
    }
    return data;
  }
}