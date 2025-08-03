import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'Ui/login_screen.dart';
import 'Ui/splash_screen.dart';
import 'main.dart';
import 'package:untitled/Ui/forgot_password_email_check.dart';
import 'package:untitled/Ui/pin_verification_screen.dart';
import 'package:untitled/Ui/new_password_screen.dart';
import 'package:untitled/Ui/sign_up_screen.dart';
import 'package:untitled/Ui/add_task_screen.dart';
import 'package:untitled/Ui/main_navigation.dart';
import 'package:untitled/Ui/update_profile_screen.dart';



class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  static GlobalKey<NavigatorState> navigator = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      navigatorKey: navigator,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: TextTheme(
          titleLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.w700)
        ),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.white,
          filled: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          hintStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
          errorBorder: OutlineInputBorder(borderSide: BorderSide.none),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            fixedSize: Size.fromWidth(double.maxFinite),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.symmetric(vertical: 12),
            backgroundColor: Colors.greenAccent,
            foregroundColor: Colors.white
          )
        )
      ),
      initialRoute: "/",
      routes: {
        SplashScreen.name : (context) => SplashScreen(),
      SignInScreen.name : (context) => SignInScreen(),
        ForgotPasswordEmailCheck.name : (context) => ForgotPasswordEmailCheck(),
        PinVerificationScreen.name : (context) => PinVerificationScreen(),
        NewPasswordScreen.name : (context) => NewPasswordScreen(),
        SignUpScreen.name : (context) => SignUpScreen(),
        MainNavigation.name : (context) => MainNavigation(),
        AddTaskScreen.name : (context) => AddTaskScreen(),
        UpdateProfileScreen.name : (context) => UpdateProfileScreen()
      },


    );
  }
}
