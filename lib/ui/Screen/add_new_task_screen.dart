import 'package:flutter/material.dart';
import 'package:task_manager/ui/widgets/background_widget.dart';
import 'package:task_manager/ui/widgets/profile_appbar.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {

  final TextEditingController _subjectTEController=TextEditingController();
  final TextEditingController _descriptionTEController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar(context),
      body: BackgroundWidget(
          child: SingleChildScrollView(
            child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50,),
              Text('Add New Task', style: Theme.of(context).textTheme.titleLarge,),
              TextFormField(
                controller: _subjectTEController,
                decoration: const InputDecoration(
                  hintText: 'Subject'
                ),
              ),
              const SizedBox(height: 8,),
              TextFormField(
                controller: _descriptionTEController,
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText: 'Description',
                ),
              ),
              ElevatedButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text('Add'))
            ],
                    ),
                  ),
          )),
    );
  }

  @override
  void dispose() {
    _subjectTEController.dispose();
    _descriptionTEController.dispose();
    super.dispose();
  }
}
