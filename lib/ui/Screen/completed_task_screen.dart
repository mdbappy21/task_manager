import 'package:flutter/material.dart';
import 'package:task_manager/data/model_class/network_response.dart';
import 'package:task_manager/data/model_class/task_list_wrapper_model.dart';
import 'package:task_manager/data/model_class/task_model.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/ui/widgets/center_progress_indicator.dart';
import 'package:task_manager/ui/widgets/snack_bar_massage.dart';
import 'package:task_manager/ui/widgets/task_item.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  bool _getCompletedTaskInProgress=false;
  List<TaskModel>completedTaskList=[];
  @override
  void initState() {
    super.initState();
    _getCompletedTask();
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async{
        _getCompletedTask();
      },
      child: Visibility(
        visible: !_getCompletedTaskInProgress,
        replacement: CenterProgressIndicator(),
        child: Scaffold(
          body: ListView.builder(
            itemCount: completedTaskList.length,
            itemBuilder: (context, index) {
              return TaskItem(taskModel: completedTaskList[index], onUpdateTask: () {
                _getCompletedTask();
              },);
            },
          ),
        ),
      ),
    );
  }
  Future<void>_getCompletedTask()async{
    _getCompletedTaskInProgress=true;
    if(mounted){
      setState(() {});
    }
    NetworkResponse response = await NetworkCaller.getRequest(Urls.completedTaskStatus);
    if(response.isSuccess){
      TaskListWrapperModel taskListWrapperModel=TaskListWrapperModel.fromJson(response.responseData);
      completedTaskList=taskListWrapperModel.taskList??[];
    }else{
      if(mounted){
        showSnackBarMassage(context, response.errorMassage??'Get New Task failed ! try again');
      }
    }
    _getCompletedTaskInProgress=false;
    if(mounted){
      setState(() {});
    }
  }
}
