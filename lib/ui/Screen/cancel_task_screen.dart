import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/controller/cancel_task_controller.dart';
import 'package:task_manager/ui/widgets/center_progress_indicator.dart';
import 'package:task_manager/ui/widgets/task_item.dart';

class CancelTaskScreen extends StatefulWidget {
  const CancelTaskScreen({super.key});

  @override
  State<CancelTaskScreen> createState() => _CancelTaskScreenState();
}

class _CancelTaskScreenState extends State<CancelTaskScreen> {
  final CancelTaskController _cancelTaskController=Get.find<CancelTaskController>();

  @override
  void initState() {
    super.initState();
    _cancelTaskController.getCancelledTask();
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async{
        _cancelTaskController.getCancelledTask();
      },
      child: GetBuilder<CancelTaskController>(
        builder: (cancelTaskController) {
          return Visibility(
            visible: !cancelTaskController.getCancelledTaskInProgress,
            replacement: CenterProgressIndicator(),
            child: Scaffold(
              body: ListView.builder(
                itemCount:cancelTaskController.cancelledTaskList.length,
                itemBuilder: (context, index) {
                  return TaskItem(
                    taskModel: cancelTaskController.cancelledTaskList[index],
                    onUpdateTask: () {
                      cancelTaskController.getCancelledTask();
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
