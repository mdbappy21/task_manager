import 'package:flutter/material.dart';
import 'package:task_manager/data/model_class/network_response.dart';
import 'package:task_manager/data/model_class/task_list_wrapper_model.dart';
import 'package:task_manager/data/model_class/task_model.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/ui/widgets/center_progress_indicator.dart';
import 'package:task_manager/ui/widgets/snack_bar_massage.dart';
import 'package:task_manager/ui/widgets/task_item.dart';

class CancelTaskScreen extends StatefulWidget {
  const CancelTaskScreen({super.key});

  @override
  State<CancelTaskScreen> createState() => _CancelTaskScreenState();
}

class _CancelTaskScreenState extends State<CancelTaskScreen> {
  bool _getCancelledTaskInProgress=false;
  List<TaskModel>cancelledTaskList=[];
  @override
  void initState() {
    super.initState();
    _getCancelledTask();
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async{
        _getCancelledTask();
      },
      child: Visibility(
        visible: !_getCancelledTaskInProgress,
        replacement: CenterProgressIndicator(),
        child: Scaffold(
          body: ListView.builder(
            itemCount:cancelledTaskList.length,
            itemBuilder: (context, index) {
              return TaskItem(
                taskModel: cancelledTaskList[index],
                onUpdateTask: () {
                  _getCancelledTask();
                },
              );
            },
          ),
        ),
      ),
    );
  }
  Future<void>_getCancelledTask()async{
    _getCancelledTaskInProgress=true;
    if(mounted){
      setState(() {});
    }
    NetworkResponse response = await NetworkCaller.getRequest(Urls.cancelledTaskStatus);
    if(response.isSuccess){
      TaskListWrapperModel taskListWrapperModel=TaskListWrapperModel.fromJson(response.responseData);
      cancelledTaskList=taskListWrapperModel.taskList??[];
    }else{
      if(mounted){
        showSnackBarMassage(context, response.errorMassage??'Get Cancelled Task failed ! try again');
      }
    }
    _getCancelledTaskInProgress=false;
    if(mounted){
      setState(() {});
    }
  }
}
