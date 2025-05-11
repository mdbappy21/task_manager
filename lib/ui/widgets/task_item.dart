import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/data/model_class/task_model.dart';
import 'package:task_manager/ui/controller/delete_task_controller.dart';
import 'package:task_manager/ui/controller/edit_task_controller.dart';
import 'package:task_manager/ui/widgets/center_progress_indicator.dart';
import 'package:task_manager/ui/widgets/snack_bar_massage.dart';

class TaskItem extends StatefulWidget {
  const TaskItem({
    super.key,
    required this.taskModel,
    required this.onUpdateTask,
  });

  final TaskModel taskModel;
  final VoidCallback onUpdateTask;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  final DeleteTaskController _deleteTaskController =
      Get.find<DeleteTaskController>();
  String dropdownValue = '';
  List<String> statusList = ['New', 'Progress', 'Completed', 'Cancelled'];

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.taskModel.status!;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      child: ListTile(
        title: Text(widget.taskModel.title ?? 'Empty'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.taskModel.description ?? 'Empty'),
            Text(
              'Created Date : ${widget.taskModel.createdDate?.split('T').first}',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600,),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTaskStatusLabel(),
                OverflowBar(
                  children: [
                    _buildDeleteIconButton(),
                    _buildPopUpMenuButton(),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskStatusLabel() {
    return Chip(
      label: Text(widget.taskModel.status ?? 'New'),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      // backgroundColor: Colors.teal,
    );
  }

  Widget _buildDeleteIconButton() {
    return GetBuilder<DeleteTaskController>(
      builder: (deleteTaskController) {
        return Visibility(
          visible: !deleteTaskController.deleteInProgress,
          replacement: CircularProgressIndicator(),
          child: IconButton(
            onPressed: () {
              _onTabDeleteButton();
            },
            icon: Icon(Icons.delete),
          ),
        );
      },
    );
  }

  Widget _buildPopUpMenuButton() {
    return GetBuilder<EditTaskController>(builder: (editTaskController) {
      return Visibility(
        visible: !editTaskController.editInProgress,
        replacement: CenterProgressIndicator(),
        child: PopupMenuButton<String>(
          icon: Icon(Icons.edit),
          onSelected: (String selectedValue) async {
            dropdownValue = selectedValue;
            bool result = await editTaskController.editTaskStatus(
                widget.taskModel.sId!, selectedValue);
            if (result) {
              widget.onUpdateTask();
            }
          },
          itemBuilder: (BuildContext context) {
            return statusList.map((String value) {
              return PopupMenuItem<String>(
                value: value,
                child: SizedBox(
                  width: 100,
                  child: ListTile(
                    title: Text(value),
                    trailing: dropdownValue == value
                        ? Icon(
                            Icons.done,
                            color: Colors.black,
                          )
                        : null,
                  ),
                ),
              );
            }).toList();
          },
        ),
      );
    });
  }

  Future<void> _onTabDeleteButton() async {
    bool result = await _deleteTaskController.deleteTask(widget.taskModel.sId!);
    if (result) {
      widget.onUpdateTask();
      if (mounted) {
        showSnackBarMassage(context, "Delete Successful");
      }
    } else {
      if (mounted) {
        showSnackBarMassage(context, 'Delete Task Failed');
      }
    }
  }
}
