import 'package:get/get.dart';
import 'package:task_manager/data/model_class/network_response.dart';
import 'package:task_manager/data/model_class/task_by_status_count_wrapper_model.dart';
import 'package:task_manager/data/model_class/task_count_by_status_model.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/utility/urls.dart';

class TaskCountByStatusController extends GetxController{

  bool _getTaskCountByStatusInProgress = false;
  bool get getTaskCountByStatusInProgress=>_getTaskCountByStatusInProgress;
  List<TaskCountByStatusModel> _taskCountByStatusList = [];
  List<TaskCountByStatusModel>get taskCountByStatusList=>_taskCountByStatusList;

  Future<bool> getTaskCountByStatus() async {
    bool isSuccess=false;
    _getTaskCountByStatusInProgress = true;
   update();
    NetworkResponse response =
    await NetworkCaller.getRequest(Urls.taskCountStatus);
    if (response.isSuccess) {
      isSuccess=true;
      TaskCountByStatusWrapperModel taskCountByStatusWrapperModel =
      TaskCountByStatusWrapperModel.fromJson(response.responseData);
      _taskCountByStatusList =
          taskCountByStatusWrapperModel.taskCountByStatusList ?? [];
    } else {
      isSuccess=false;
    }
    _getTaskCountByStatusInProgress = false;
    update();
    return isSuccess;
  }
}