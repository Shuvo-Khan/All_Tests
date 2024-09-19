import 'package:first_project/controller_binder.dart';
import 'package:first_project/ui/screens/add_new_task_screen.dart';
import 'package:first_project/ui/screens/cancelled_task_screen.dart';
import 'package:first_project/ui/screens/completed_task_screen.dart';
import 'package:first_project/ui/screens/forgot_password_email_screen.dart';
import 'package:first_project/ui/screens/forgot_password_otp_screen.dart';
import 'package:first_project/ui/screens/main_bottom_nav_bar_screen.dart';
import 'package:first_project/ui/screens/new_task_screen.dart';
import 'package:first_project/ui/screens/profile_screen.dart';
import 'package:first_project/ui/screens/progress_task_screen.dart';
import 'package:first_project/ui/screens/reset_password_screen.dart';
import 'package:first_project/ui/screens/sign_in_screen.dart';
import 'package:first_project/ui/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:first_project/ui/screens/splash_screen.dart';
import 'package:first_project/ui/utils/app_colors.dart';
import 'package:get/get.dart';

class TaskManagerApp extends StatefulWidget {
  const TaskManagerApp({super.key});

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<TaskManagerApp> createState() => _TaskManagerAppState();
}

class _TaskManagerAppState extends State<TaskManagerApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: TaskManagerApp.navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: AppColors.themeColor,
        textTheme: const TextTheme(),
        inputDecorationTheme: _inputDecorationTheme(),
        elevatedButtonTheme: _elevatedButtonThemeData(),
      ),
      initialBinding: ControllerBinder(),
      initialRoute: '/',
      routes: {
        SplashScreen.name: (context) => const SplashScreen(),
        SignUpScreen.name: (context) => const SignUpScreen(),
        SignInScreen.name: (context) => const SignInScreen(),
        ProgressTaskScreen.name: (context) => const ProgressTaskScreen(),
        ProfileScreen.name: (context) => const ProfileScreen(),
        NewTaskScreen.name: (context) => const NewTaskScreen(),
        MainBottomNavBarScreen.name: (context) =>
            const MainBottomNavBarScreen(),
        CompletedTaskScreen.name: (context) => const CompletedTaskScreen(),
        CancelledTaskScreen.name: (context) => const CancelledTaskScreen(),
        AddNewTaskScreen.name: (context) => const AddNewTaskScreen(),
        ForgotPasswordEmailScreen.name: (context) =>
            const ForgotPasswordEmailScreen(),
      },
    );
  }

  ElevatedButtonThemeData _elevatedButtonThemeData() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.themeColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        fixedSize: const Size.fromWidth(double.maxFinite),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  InputDecorationTheme _inputDecorationTheme() {
    return InputDecorationTheme(
      fillColor: Colors.white,
      filled: true,
      hintStyle: const TextStyle(fontWeight: FontWeight.w300),
      border: _inputBorder(),
      enabledBorder: _inputBorder(),
      errorBorder: _inputBorder(),
      focusedBorder: _inputBorder(),
    );
  }

  OutlineInputBorder _inputBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(8),
    );
  }
}
