import 'package:flutter/material.dart';
import 'package:task_manager/data/model_class/network_response.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/utility/urls.dart';
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
  final TextEditingController _descriptionTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _addNewTaskInProgress=false;

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
                const SizedBox(
                  height: 50,
                ),
                Text(
                  'Add New Task',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                TextFormField(
                  controller: _subjectTEController,
                  decoration: const InputDecoration(hintText: 'Subject'),
                  validator: (String? value){
                    if(value?.trim().isEmpty??true){
                      return "Enter title";
                    }return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: _descriptionTEController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    hintText: 'Description',
                  ),
                  validator: (String? value){
                    if(value?.trim().isEmpty??true){
                      return "Enter Description";
                    }return null;
                  },
                ),
                Visibility(
                  visible: !_addNewTaskInProgress,
                  replacement: CenterProgressIndicator(),
                  child: ElevatedButton(
                      onPressed: () {
                       if(_formKey.currentState!.validate()){
                         _addNewTask();
                       }
                      },
                      child: Text('Add')),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }

  Future<void>_addNewTask()async{
    _addNewTaskInProgress=true;
    if(mounted){
      setState(() {});
      Map<String , dynamic>requestData={
        "title":_subjectTEController.text.trim(),
        "description":_descriptionTEController.text.trim(),
        "status":"New"
      };
      NetworkResponse response=await NetworkCaller.postRequest(Urls.createTask,body: requestData);
      _addNewTaskInProgress=false;
      if(mounted){
        setState(() {});
      }
      if(response.isSuccess){
        _clearTextFields();
        if(mounted){
          showSnackBarMassage(context, "New task added");
        }
      }else{
        if(mounted){
          showSnackBarMassage(context, "New task added failed! try again",true);
        }
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
