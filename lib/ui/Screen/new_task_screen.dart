import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/data/model_class/task_count_by_status_model.dart';
import 'package:task_manager/ui/Screen/add_new_task_screen.dart';
import 'package:task_manager/ui/controller/new_task_controller.dart';
import 'package:task_manager/ui/controller/task_count_by_status_controller.dart';
import 'package:task_manager/ui/utility/app_Colors.dart';
import 'package:task_manager/ui/widgets/center_progress_indicator.dart';
import 'package:task_manager/ui/widgets/task_item.dart';
import 'package:task_manager/ui/widgets/task_summary_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  final NewTaskController _newTaskController = Get.find<NewTaskController>();
  final TaskCountByStatusController _taskCountByStatusController =
      Get.find<TaskCountByStatusController>();

  @override
  void initState() {
    super.initState();
    _initial();
  }

  void _initial() {
    _newTaskController.getNewTask();
    _taskCountByStatusController.getTaskCountByStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
        child: Column(
          children: [
            _buildSummarySection(),
            const SizedBox(height: 12),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  _initial();
                },
                child: GetBuilder<NewTaskController>(builder: (newTaskController) {
                  return Visibility(
                    visible: !newTaskController.newTaskInProgress,
                    replacement: CenterProgressIndicator(),
                    child: ListView.builder(
                      itemCount: newTaskController.newTaskList.length + 1,
                      itemBuilder: (context, index) {
                        if (index == newTaskController.newTaskList.length) {
                          return SizedBox(height: 54);
                        } else {
                          return TaskItem(
                            taskModel: newTaskController.newTaskList[index],
                            onUpdateTask: () {
                              _initial();
                            },
                          );
                        }
                      },
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onTapAddButton,
        backgroundColor: AppColors.themeColor,
        foregroundColor: Colors.white,
        shape: CircleBorder(),
        child: Icon(Icons.add),
      ),
    );
  }

  void _onTapAddButton() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddNewTaskScreen()));
  }

  Widget _buildSummarySection() {
    const List<String> fixedStatusOrder = [
      'New',
      'Completed',
      'Progress',
      'Cancelled'
    ];

    return GetBuilder<TaskCountByStatusController>(
      builder: (taskCountByStatusController) {
        List<TaskCountByStatusModel> orderedList = [];
        for (final status in fixedStatusOrder) {
          final matchedItem =
              _taskCountByStatusController.taskCountByStatusList.firstWhere(
            (item) => item.sId?.toLowerCase() == status.toLowerCase(),
            orElse: () => TaskCountByStatusModel(sId: status, sum: 0),
          );
          orderedList.add(matchedItem);
        }
        return Visibility(
          visible: !taskCountByStatusController.getTaskCountByStatusInProgress,
          replacement: CenterProgressIndicator(),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: orderedList.map((e) {
                return ConstrainedBox(
                  constraints: BoxConstraints(minWidth: 80),
                  child: TaskSummaryCard(
                    title: e.sId ?? 'Unknown',
                    count: e.sum.toString(),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
