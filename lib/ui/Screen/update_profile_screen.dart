import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager/ui/controller/auth_controller.dart';
import 'package:task_manager/ui/controller/update_profile_controller.dart';
import 'package:task_manager/ui/widgets/background_widget.dart';
import 'package:task_manager/ui/widgets/center_progress_indicator.dart';
import 'package:task_manager/ui/widgets/profile_appbar.dart';
import 'package:task_manager/ui/widgets/snack_bar_massage.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  XFile? _selectedImage;
  final UpdateProfileController _updateProfileController=Get.find<UpdateProfileController>();

  @override
  void initState() {
    super.initState();
    final userData= AuthController.userData!;
    _emailTEController.text=userData.email ?? '';
    _firstNameTEController.text=userData.firstName ?? '';
    _lastNameTEController.text=userData.lastName ?? '';
    _mobileTEController.text=userData.mobile ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar(context, true),
      body: BackgroundWidget(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 48),
                  Text('Update Profile', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 24),
                  _buildPhotoPickerWidget(),
                  const SizedBox(height: 8),
                  _buildTextFormField(),
                  const SizedBox(height: 8),
                  _buildUpdateProfileButton(),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUpdateProfileButton() {
    return GetBuilder<UpdateProfileController>(
      builder: (updateProfileController) {
        return Visibility(
          visible: !updateProfileController.updateProfileInProgress,
          replacement: CenterProgressIndicator(),
          child: ElevatedButton(
              onPressed: _onTapUpdateButton,
              child: Icon(Icons.arrow_forward_outlined)),
        );
      }
    );
  }

  Widget _buildTextFormField() {
    return Column(
      children: [
        TextFormField(
          controller: _emailTEController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(hintText: 'Email'),
          enabled: false,
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _firstNameTEController,
          decoration: InputDecoration(hintText: 'First Name'),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _lastNameTEController,
          decoration: InputDecoration(hintText: 'Last Name'),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _mobileTEController,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(hintText: 'Mobile'),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _passwordTEController,
          decoration: InputDecoration(hintText: 'Password'),
        ),
      ],
    );
  }

  Widget _buildPhotoPickerWidget() {
    return GestureDetector(
      onTap: _picProfileImage,
      child: Container(
        width: double.maxFinite,
        height: 48,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: Colors.white),
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Container(
              width: 100,
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
                color: Colors.grey,
              ),
              alignment: Alignment.center,
              child: Text('Photo',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                _selectedImage?.name ?? 'No image selected',
                maxLines: 1,
                style: TextStyle(overflow: TextOverflow.ellipsis),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void>_picProfileImage()async{
    final imagePicker =ImagePicker();
    final XFile? result = await imagePicker.pickImage(source: ImageSource.gallery);
    if(result!=null){
      _selectedImage=result;
      if(mounted){
        setState(() {});
      }
    }
  }

  Future<void> _onTapUpdateButton() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    bool result = await _updateProfileController.updateProfile(
      _emailTEController.text,
      _firstNameTEController.text.trim(),
      _lastNameTEController.text.trim(),
      _mobileTEController.text,
      _passwordTEController.text,
      _selectedImage,
    );
    if (result) {
      if (mounted) {
        showSnackBarMassage(context, "Profile Updated");
        Get.back();
      }
    } else {
      if (mounted) {
        showSnackBarMassage(context, "Profile Update failed!");
      }
    }
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
