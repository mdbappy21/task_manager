import 'package:flutter/material.dart';
import 'package:task_manager/data/model_class/network_response.dart';
import 'package:task_manager/data/model_class/task_model.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/ui/widgets/center_progress_indicator.dart';
import 'package:task_manager/ui/widgets/snack_bar_massage.dart';

class TaskItem extends StatefulWidget {
  const TaskItem({
    super.key, required this.taskModel, required this.onUpdateTask,
  });

  final TaskModel taskModel;
  final VoidCallback onUpdateTask;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool _deleteInProgress=false;
  bool _editInProgress=false;
  String dropdownValue='';
  List<String> statusList=[
    'New',
    'Progress',
    'Completed',
    'Cancelled'
  ];

  @override
  void initState() {
    super.initState();
    dropdownValue=widget.taskModel.status!;
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      child: ListTile(
        title: Text(widget.taskModel.title??'Empty'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.taskModel.description??'Empty'),
            Text(
              'Date : ${widget.taskModel.createdDate?.split('T').first}',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(widget.taskModel.status??'New'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: 8, vertical: 2),
                  // backgroundColor: Colors.teal,
                ),
                OverflowBar(
                  children: [
                    Visibility(
                      visible: !_deleteInProgress,
                      replacement: CircularProgressIndicator(),
                      child: IconButton(
                          onPressed: () {
                            _deleteTask();
                          },
                          icon: Icon(Icons.delete)),
                    ),
                    Visibility(
                      visible: !_editInProgress,
                      replacement: CenterProgressIndicator(),
                      child: PopupMenuButton<String>(
                        icon: Icon(Icons.edit),
                        onSelected: (String selectedValue) {
                          dropdownValue = selectedValue;
                          if (mounted) {
                            setState(() {});
                          }
                        },
                        itemBuilder: (BuildContext context) {
                          return statusList.map((String value) {
                            return PopupMenuItem<String>(
                              value: value,
                              child: ListTile(title: Text(value), trailing:dropdownValue==value?Icon(Icons.done):null,),
                            );
                          }).toList();
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
  Future<void> _deleteTask() async {
    _deleteInProgress = true;
    if (mounted) {
      setState(() {});
    }
    NetworkResponse response =
    await NetworkCaller.getRequest(Urls.deleteTask(widget.taskModel.sId!));
    if (response.isSuccess) {
      widget.onUpdateTask();
    } else {
      if (mounted) {
        showSnackBarMassage(context, response.errorMassage ?? 'Get Task count by status failed ! try again');
      }
    }
    _deleteInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }
}