import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:task_manager/app.dart';
import 'package:task_manager/data/model_class/network_response.dart';
import 'package:task_manager/ui/Screen/authentication/sign_in_screen.dart';
import 'package:task_manager/ui/controller/auth_controller.dart';

class NetworkCaller {
 static Future<NetworkResponse> getRequest(String url) async {
    try {
      Response response = await get(Uri.parse(url),headers: {
        'token':AuthController.accessToken
      });
      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          responseData: decodedData,
        );
      } else if(response.statusCode==401){
        redirectToLogin();
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
        );
      }else {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
        );
      }
    } catch (e) {
      return NetworkResponse(
          statusCode: -1, isSuccess: false, errorMassage: e.toString());
    }
  }

 static Future<NetworkResponse> postRequest(String url,{Map<String,dynamic>? body}) async {
    try {
      debugPrint(url);
      debugPrint(body.toString());

      Response response = await post(
        Uri.parse(url),
        body: jsonEncode(body),
        headers: {'Content-type':'Application/json','token':AuthController.accessToken},
      );

      debugPrint(response.statusCode.toString());
      debugPrint(response.body);

      if (response.statusCode == 200 || response.statusCode==201) {
        final decodedData = jsonDecode(response.body);
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          responseData: decodedData,
        );
      } else {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
        );
      }
    } catch (e) {
      return NetworkResponse(
          statusCode: -1, isSuccess: false, errorMassage: e.toString());
    }
  }

  static Future<void> redirectToLogin() async {
   await AuthController.clearAllData();
   Navigator.pushAndRemoveUntil(TaskManager.navigatorKey.currentContext!, MaterialPageRoute(builder: (context)=>SignInScreen()), (route)=>false);
  }

}
