import 'package:flutter/material.dart';
import 'package:task_manager/ui/Screen/authentication/splash_screen.dart';
import 'package:task_manager/ui/utility/app_colors.dart';

class TaskManager extends StatefulWidget {
  const TaskManager({super.key});
  static GlobalKey<NavigatorState>navigatorKey=GlobalKey<NavigatorState>();

  @override
  State<TaskManager> createState() => _TaskManagerState();
}

class _TaskManagerState extends State<TaskManager> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: TaskManager.navigatorKey,
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      theme:_lightTheme(),
    );
  }

  ThemeData _lightTheme() {
    return ThemeData(
      textTheme: TextTheme(
        titleLarge: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 28, color: Colors.black),
        titleSmall: TextStyle(
            fontWeight: FontWeight.w500, fontSize: 14, color: Colors.grey,letterSpacing: 0.4),
      ),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              foregroundColor: Colors.grey,
              textStyle: TextStyle(
                  fontWeight: FontWeight.w600
              )
          )
      ),
      inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.white,
          filled: true,
          hintStyle: TextStyle(
              color: Colors.grey.shade400
          ),
          border: OutlineInputBorder(
              borderSide: BorderSide.none
          )
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.themeColor,
              padding: EdgeInsets.symmetric(vertical: 12),
              foregroundColor: AppColors.white,
              fixedSize: Size.fromWidth(double.maxFinite),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)
              ),
            iconColor: Colors.white
          )
      ),
    );
  }
}