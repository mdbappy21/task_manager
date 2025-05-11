import 'package:get/get.dart';
import 'package:task_manager/data/model_class/network_response.dart';
import 'package:task_manager/data/model_class/task_list_wrapper_model.dart';
import 'package:task_manager/data/model_class/task_model.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/utility/urls.dart';

class NewTaskController extends GetxController {
  bool _newTaskInProgress = false;

  bool get newTaskInProgress => _newTaskInProgress;
  List<TaskModel> _newTaskList = [];

  List<TaskModel> get newTaskList => _newTaskList;

  Future<bool> getNewTask() async {
    bool isSuccess = false;
    _newTaskInProgress = true;
    update();
    NetworkResponse response =
        await NetworkCaller.getRequest(Urls.newTaskStatus);
    if (response.isSuccess) {
      isSuccess = true;
      TaskListWrapperModel taskListWrapperModel =
          TaskListWrapperModel.fromJson(response.responseData);
      _newTaskList = taskListWrapperModel.taskList ?? [];
    } else {
      isSuccess = false;
    }
    _newTaskInProgress = false;
    update();
    return isSuccess;
  }
}
