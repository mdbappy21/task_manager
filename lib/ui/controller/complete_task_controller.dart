import 'package:get/get.dart';
import 'package:task_manager/data/model_class/network_response.dart';
import 'package:task_manager/data/model_class/task_list_wrapper_model.dart';
import 'package:task_manager/data/model_class/task_model.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/utility/urls.dart';

class CompleteTaskController extends GetxController{
  bool _getCompletedTaskInProgress=false;
  bool get getCompletedTaskInProgress=>_getCompletedTaskInProgress;
  List<TaskModel>_completedTaskList=[];
  List<TaskModel>get completedTaskList=>_completedTaskList;

  Future<bool>getCompletedTask()async{
    bool isSuccess=false;
    _getCompletedTaskInProgress=true;
    update();
    NetworkResponse response = await NetworkCaller.getRequest(Urls.completedTaskStatus);
    if(response.isSuccess){
      isSuccess=true;
      TaskListWrapperModel taskListWrapperModel=TaskListWrapperModel.fromJson(response.responseData);
      _completedTaskList=taskListWrapperModel.taskList??[];
    }else{
     isSuccess=false;
    }
    _getCompletedTaskInProgress=false;
    update();
    return isSuccess;
  }
}
