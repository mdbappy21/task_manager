import 'package:get/get.dart';
import 'package:task_manager/data/model_class/network_response.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/utility/urls.dart';

class DeleteTaskController extends GetxController {
  bool _deleteInProgress = false;

  bool get deleteInProgress => _deleteInProgress;

  Future<bool> deleteTask(String sId) async {
    bool isSuccess = false;
    _deleteInProgress = true;
    update();
    NetworkResponse response =
        await NetworkCaller.getRequest(Urls.deleteTask(sId));
    if (response.isSuccess) {
      isSuccess = true;
    } else {
      isSuccess = false;
    }
    _deleteInProgress = false;
    update();
    return isSuccess;
  }
}
