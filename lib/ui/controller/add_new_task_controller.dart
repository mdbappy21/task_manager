import 'package:get/get.dart';
import 'package:task_manager/data/model_class/network_response.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/utility/urls.dart';

class AddNewTaskController extends GetxController {
  bool _addNewTaskInProgress = false;

  bool get addNewTaskInProgress => _addNewTaskInProgress;

  Future<bool> addNewTask(String subject, String description) async {
    bool isSuccess = false;
    _addNewTaskInProgress = true;
    update();
    Map<String, dynamic> requestData = {
      "title": subject,
      "description": description,
      "status": "New"
    };
    NetworkResponse response =
        await NetworkCaller.postRequest(Urls.createTask, body: requestData);
    if (response.isSuccess) {
      isSuccess = true;
    } else {
      isSuccess = false;
    }
    _addNewTaskInProgress = false;
    update();
    return isSuccess;
  }
}
