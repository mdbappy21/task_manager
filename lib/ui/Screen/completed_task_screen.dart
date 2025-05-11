import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/controller/complete_task_controller.dart';
import 'package:task_manager/ui/widgets/center_progress_indicator.dart';
import 'package:task_manager/ui/widgets/task_item.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  final CompleteTaskController _completeTaskController=Get.find<CompleteTaskController>();
  @override
  void initState() {
    super.initState();
    _completeTaskController.getCompletedTask();
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async{
        _completeTaskController.getCompletedTask();
      },
      child: GetBuilder<CompleteTaskController>(
        builder: (completeTaskController) {
          return Visibility(
            visible: !completeTaskController.getCompletedTaskInProgress,
            replacement: CenterProgressIndicator(),
            child: Scaffold(
              body: ListView.builder(
                itemCount: completeTaskController.completedTaskList.length,
                itemBuilder: (context, index) {
                  return TaskItem(taskModel: completeTaskController.completedTaskList[index], onUpdateTask: () {
                    completeTaskController.getCompletedTask();
                  },);
                },
              ),
            ),
          );
        }
      ),
    );
  }

}
