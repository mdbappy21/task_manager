import 'package:flutter/material.dart';
import 'package:task_manager/data/model_class/network_response.dart';
import 'package:task_manager/data/model_class/task_list_wrapper_model.dart';
import 'package:task_manager/data/model_class/task_model.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/ui/widgets/center_progress_indicator.dart';
import 'package:task_manager/ui/widgets/snack_bar_massage.dart';
import 'package:task_manager/ui/widgets/task_item.dart';

class InProgressTaskScreen extends StatefulWidget {
  const InProgressTaskScreen({super.key});

  @override
  State<InProgressTaskScreen> createState() => _InProgressTaskScreenState();
}

class _InProgressTaskScreenState extends State<InProgressTaskScreen> {
  bool _getInProgressTaskInProgress=false;
  List<TaskModel>inProgressTaskList=[];
  @override
  void initState() {
    super.initState();
    _getInProgressTask();
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async{
        _getInProgressTask();
      },
      child: Visibility(
        visible: !_getInProgressTaskInProgress,
        replacement: CenterProgressIndicator(),
        child: Scaffold(
          body: ListView.builder(
            itemCount: inProgressTaskList.length,
            itemBuilder: (context, index) {
              return TaskItem(
                taskModel: inProgressTaskList[index],
                onUpdateTask: () {
                  _getInProgressTask();
                },
              );
            },
          ),
        ),
      ),
    );
  }
  Future<void>_getInProgressTask()async{
    _getInProgressTaskInProgress=true;
    if(mounted){
      setState(() {});
    }
    NetworkResponse response = await NetworkCaller.getRequest(Urls.inProgressTaskStatus);
    if(response.isSuccess){
      TaskListWrapperModel taskListWrapperModel=TaskListWrapperModel.fromJson(response.responseData);
      inProgressTaskList=taskListWrapperModel.taskList??[];
    }else{
      if(mounted){
        showSnackBarMassage(context, response.errorMassage??'Get inProgress Task failed ! try again');
      }
    }
    _getInProgressTaskInProgress=false;
    if(mounted){
      setState(() {});
    }
  }
}
