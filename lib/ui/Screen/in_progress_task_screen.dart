import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/controller/in_progress_task_controller.dart';
import 'package:task_manager/ui/widgets/center_progress_indicator.dart';
import 'package:task_manager/ui/widgets/task_item.dart';

class InProgressTaskScreen extends StatefulWidget {
  const InProgressTaskScreen({super.key});

  @override
  State<InProgressTaskScreen> createState() => _InProgressTaskScreenState();
}

class _InProgressTaskScreenState extends State<InProgressTaskScreen> {
final InProgressTaskController _inProgressTaskController=Get.find<InProgressTaskController>();
  @override
  void initState() {
    super.initState();
    _inProgressTaskController.getInProgressTask();
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async{
        _inProgressTaskController.getInProgressTask();
      },
      child: GetBuilder<InProgressTaskController>(
        builder: (inProgressTaskController) {
          return Visibility(
            visible: !inProgressTaskController.getInProgressTaskInProgress,
            replacement: CenterProgressIndicator(),
            child: Scaffold(
              body: ListView.builder(
                itemCount: inProgressTaskController.inProgressTaskList.length,
                itemBuilder: (context, index) {
                  return TaskItem(
                    taskModel: inProgressTaskController.inProgressTaskList[index],
                    onUpdateTask: () {
                      inProgressTaskController.getInProgressTask();
                    },
                  );
                },
              ),
            ),
          );
        }
      ),
    );
  }
}
