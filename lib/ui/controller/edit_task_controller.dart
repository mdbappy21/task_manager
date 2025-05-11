import 'package:get/get.dart';
import 'package:task_manager/data/model_class/network_response.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/utility/urls.dart';

class EditTaskController extends GetxController{
  bool _editInProgress = false;
  bool get editInProgress =>_editInProgress;

  Future<bool>editTaskStatus(String sId,String status)async{
    bool isSuccess=false;
    _editInProgress=true;
    update();
    NetworkResponse response= await NetworkCaller.getRequest(Urls.updateTaskStatus(sId,status));
    if(response.isSuccess){
      isSuccess=true;
    }else{
      isSuccess=false;
    }
    _editInProgress=false;
    update();
    return isSuccess;
  }
}