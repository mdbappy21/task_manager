import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/controller/add_new_task_controller.dart';
import 'package:task_manager/ui/widgets/background_widget.dart';
import 'package:task_manager/ui/widgets/center_progress_indicator.dart';
import 'package:task_manager/ui/widgets/profile_appbar.dart';
import 'package:task_manager/ui/widgets/snack_bar_massage.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _subjectTEController = TextEditingController();
  final TextEditingController _descriptionTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AddNewTaskController _addNewTaskController=Get.find<AddNewTaskController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar(context),
      body: BackgroundWidget(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  Text('Add New Task', style: Theme.of(context).textTheme.titleLarge),
                  _buildTextFormField(),
                  _buildAddTaskButton()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAddTaskButton() {
    return GetBuilder<AddNewTaskController>(builder: (addNewTaskController) {
      return Visibility(
        visible: !addNewTaskController.addNewTaskInProgress,
        replacement: CenterProgressIndicator(),
        child: ElevatedButton(
          onPressed: _onTapAddButton,
          child: Text('Add'),
        ),
      );
    });
  }

  Widget _buildTextFormField() {
    return Column(
      children: [
        TextFormField(
          controller: _subjectTEController,
          decoration: const InputDecoration(hintText: 'Subject'),
          validator: (String? value) {
            if (value?.trim().isEmpty ?? true) {
              return "Enter title";
            }
            return null;
          },
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _descriptionTEController,
          maxLines: 4,
          decoration: const InputDecoration(
            hintText: 'Description',
          ),
          validator: (String? value) {
            if (value?.trim().isEmpty ?? true) {
              return "Enter Description";
            }
            return null;
          },
        ),
      ],
    );
  }

  Future<void> _onTapAddButton() async {
      if(!_formKey.currentState!.validate()){
        return;
      }
      bool result = await _addNewTaskController.addNewTask(_subjectTEController.text, _descriptionTEController.text);
      if(result){
        _clearTextFields();
        if(mounted){
          showSnackBarMassage(context, "New task added");
        }
      }else{
        if(mounted){
          showSnackBarMassage(context, "Task Added Failed");
        }
      }
  }

  void _clearTextFields(){
    _subjectTEController.clear();
    _descriptionTEController.clear();
  }

  @override
  void dispose() {
    _subjectTEController.dispose();
    _descriptionTEController.dispose();
    super.dispose();
  }
}
