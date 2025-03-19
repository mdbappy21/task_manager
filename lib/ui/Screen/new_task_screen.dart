import 'package:flutter/material.dart';
import 'package:task_manager/ui/Screen/add_new_task_screen.dart';
import 'package:task_manager/ui/utility/app_Colors.dart';
import 'package:task_manager/ui/widgets/task_item.dart';
import 'package:task_manager/ui/widgets/task_summary_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 8,right: 8,top: 8),
        child: Column(
          children: [
            _buildSummarySection(),
            const SizedBox(height: 12,),
            Expanded(
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return TaskItem();
                  }),
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

  void _onTapAddButton(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>AddNewTaskScreen()));
  }

  Widget _buildSummarySection() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          TaskSummaryCard(
            title: 'New Task',
            count: '15',
          ),
          TaskSummaryCard(
            title: 'Completed',
            count: '15',
          ),
          TaskSummaryCard(
            title: 'In progress',
            count: '15',
          ),
          TaskSummaryCard(
            title: 'Cancelled',
            count: '15',
          ),
        ],
      ),
    );
  }
}


