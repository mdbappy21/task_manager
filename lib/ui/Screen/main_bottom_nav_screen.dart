import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/Screen/cancel_task_screen.dart';
import 'package:task_manager/ui/Screen/completed_task_screen.dart';
import 'package:task_manager/ui/Screen/in_progress_task_screen.dart';
import 'package:task_manager/ui/Screen/new_task_screen.dart';
import 'package:task_manager/ui/controller/update_profile_controller.dart';
import 'package:task_manager/ui/utility/app_colors.dart';
import 'package:task_manager/ui/widgets/profile_appbar.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  int _selectedIndex=0;
  final List<Widget> _screen = [
    NewTaskScreen(),
    CompletedTaskScreen(),
    InProgressTaskScreen(),
    CancelTaskScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: GetBuilder<UpdateProfileController>(
          builder: (_) {
            return profileAppBar(context);
          }
        ),
      ),

      body: _screen[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index){
          _selectedIndex=index;
          if (mounted) {
            setState(() {});
          }
        },
        selectedItemColor:AppColors.themeColor,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.add_task),label: 'New Task'),
          BottomNavigationBarItem(icon: Icon(Icons.done),label: 'Completed'),
          BottomNavigationBarItem(icon: Icon(Icons.incomplete_circle),label: 'In progress'),
          BottomNavigationBarItem(icon: Icon(Icons.cancel),label: 'Cancelled'),
        ],
      ),
    );
  }

}
