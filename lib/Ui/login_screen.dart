import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:get/get.dart';
import 'package:untitled/Data/Models/user_model.dart';
import 'package:untitled/Data/service/network_caller.dart';
import 'package:untitled/Data/urls.dart';
import 'package:untitled/Ui/controler/auth_controler.dart';
import 'package:untitled/Ui/forgot_password_email_check.dart';
import 'package:untitled/Ui/main_navigation.dart';
import 'package:untitled/Ui/sign_up_screen.dart';
import 'package:untitled/Widget/backgroud_screen.dart';
import 'package:untitled/Widget/center_circular_indicator.dart';
import 'package:untitled/Widget/snackbar_message.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});
  static const name = "/sign_in";

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailTE = TextEditingController();
  final TextEditingController _passwordTE = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _signInProgress = false;

  @override
  void dispose() {
    _emailTE.dispose();
    _passwordTE.dispose();
    super.dispose();
  }

  void _onTapSignInButton() {
    if (_formKey.currentState!.validate()) {
      _signIn();
    }
  }

  Future<void> _signIn() async {
    setState(() {
      _signInProgress = true;
    });

    Map<String, String> requestBody = {
      "email": _emailTE.text.trim(),
      "password": _passwordTE.text,
    };

    NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.Login,
      body: requestBody,
      isFormLogin: true,
    );

    if (response.isSuccess) {
      UserModel userModel = UserModel.fromJson(response.body!['data']);
      String token = response.body!['token'];

      await AuthController.saveUserData(userModel, token);

      Navigator.pushNamed(context, MainNavigation.name);
    } else {
      showSnackBarMessage(context, "Login failed");
    }

    setState(() {
      _signInProgress = false;
    });
  }

  void _onTapForgotPasswordButton() {
    Get.toNamed(ForgotPasswordEmailCheck.name);
  }

  void _onTapSignUpButton() {
    Get.toNamed(SignUpScreen.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 150),
                  Text(
                    "Get Started With",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 25),
                  TextFormField(
                    controller: _emailTE,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      hintText: "Email",
                    ),
                    validator: (String? value) {
                      String email = value ?? "";
                      if (!EmailValidator.validate(email)) {
                        return "Enter a valid Email";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _passwordTE,
                    textInputAction: TextInputAction.done,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: "Password",
                    ),
                    validator: (String? value) {
                      if ((value?.length ?? 0) <= 6) {
                        return "Enter a valid password";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Visibility(
                    visible: _signInProgress == false,
                    replacement: CenterCircularIndicatorWidget(),
                    child: ElevatedButton(
                      onPressed: _onTapSignInButton,
                      child: const Icon(
                        Icons.arrow_circle_right_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Center(
                    child: Column(
                      children: [
                        TextButton(
                          onPressed: _onTapForgotPasswordButton,
                          child: const Text(
                            "Forgot password?",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: "Don't have an account? ",
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              letterSpacing: 0.4,
                            ),
                            children: [
                              TextSpan(
                                text: "Sign up",
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w700,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = _onTapSignUpButton,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
