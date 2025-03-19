import 'package:flutter/material.dart';
import 'package:task_manager/ui/Screen/authentication/sign_in_screen.dart';
import 'package:task_manager/ui/Screen/update_profile_screen.dart';
import 'package:task_manager/ui/controller/auth_controller.dart';
import 'package:task_manager/ui/utility/app_colors.dart';

AppBar profileAppBar(BuildContext context,[bool fromUpdateProfile =false]) {
  return AppBar(
    backgroundColor: AppColors.themeColor,
    leading: GestureDetector(
      onTap: ()=> _onTapProfile(fromUpdateProfile, context),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          radius: 10,
          backgroundImage:
              NetworkImage('https://mdbappy21.github.io/portfolio/img/bappy.jpg'),
          // child: Image.network('https://mdbappy21.github.io/portfolio/img/bappy.jpg'),
          // child: ClipOval(
          //   child: NetworkCachedImage(
          //     imageUrl: 'https://mdbappy21.github.io/portfolio/img/bappy.jpg',
          //     fit: BoxFit.cover,
          //   ),
          // ),
        ),
      ),
    ),
    title: GestureDetector(
      onTap: ()=> _onTapProfile(fromUpdateProfile, context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AuthController.userData?.fullName??'',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
          ),
          Text(
          AuthController.userData?.email??'',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white)),
        ],
      ),
    ),
    actions: [
      IconButton(
          onPressed: () => _logoutToSignIn(context), icon: Icon(Icons.logout))
    ],
  );
}

void _onTapProfile(bool fromUpdateProfile, BuildContext context) {
   if(!fromUpdateProfile){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateProfileScreen(),
      ),
    );
  }
}

void _logoutToSignIn(BuildContext context) async {
  await AuthController.clearAllData();
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => SignInScreen(),
    ),
    (route) => false,
  );
}
