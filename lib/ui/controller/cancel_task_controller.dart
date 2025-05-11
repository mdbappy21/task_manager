import 'package:get/get.dart';
import 'package:task_manager/data/model_class/network_response.dart';
import 'package:task_manager/data/model_class/task_list_wrapper_model.dart';
import 'package:task_manager/data/model_class/task_model.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/utility/urls.dart';

class CancelTaskController extends GetxController{
  bool _getCancelledTaskInProgress=false;
  bool get getCancelledTaskInProgress=>_getCancelledTaskInProgress;
  List<TaskModel>_cancelledTaskList=[];
  List<TaskModel>get cancelledTaskList=>_cancelledTaskList;

  Future<bool>getCancelledTask()async{
    bool isSuccess=false;
    _getCancelledTaskInProgress=true;
    update();
    NetworkResponse response = await NetworkCaller.getRequest(Urls.cancelledTaskStatus);
    if(response.isSuccess){
      isSuccess=true;
      TaskListWrapperModel taskListWrapperModel=TaskListWrapperModel.fromJson(response.responseData);
      _cancelledTaskList=taskListWrapperModel.taskList??[];
    }else{
      isSuccess=false;
    }
    _getCancelledTaskInProgress=false;
    update();
    return isSuccess;
  }
}