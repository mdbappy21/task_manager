import 'package:get/get.dart';
import 'package:task_manager/data/model_class/network_response.dart';
import 'package:task_manager/data/model_class/task_list_wrapper_model.dart';
import 'package:task_manager/data/model_class/task_model.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/utility/urls.dart';

class InProgressTaskController extends GetxController{
  bool _getInProgressTaskInProgress=false;
  bool get getInProgressTaskInProgress=>_getInProgressTaskInProgress;
  List<TaskModel>_inProgressTaskList=[];
  List<TaskModel>get inProgressTaskList=>_inProgressTaskList;

  Future<bool>getInProgressTask()async{
    bool isSuccess=false;
    _getInProgressTaskInProgress=true;
    update();
    NetworkResponse response = await NetworkCaller.getRequest(Urls.inProgressTaskStatus);
    if(response.isSuccess){
      isSuccess=true;
      TaskListWrapperModel taskListWrapperModel=TaskListWrapperModel.fromJson(response.responseData);
      _inProgressTaskList=taskListWrapperModel.taskList??[];
    }else{
      isSuccess=false;
    }
    _getInProgressTaskInProgress=false;
    update();
    return isSuccess;
  }
}
