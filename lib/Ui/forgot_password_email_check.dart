import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:get/get.dart';
import 'package:untitled/Widget/backgroud_screen.dart';

class ForgotPasswordEmailCheck extends StatefulWidget {
  const ForgotPasswordEmailCheck({super.key});
  static String name = "/forgot_password_email_check";

  @override
  State<ForgotPasswordEmailCheck> createState() =>
      _ForgotPasswordEmailCheckState();
}

class _ForgotPasswordEmailCheckState extends State<ForgotPasswordEmailCheck> {
  final TextEditingController _forgotPasswordEmailTE = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _sendOtpInProgress = false;

  @override
  void dispose() {
    _forgotPasswordEmailTE.dispose();
    super.dispose();
  }

  // Future<void> _sendOtp() async {
  //   if (_formKey.currentState!.validate()) {
  //     setState(() {
  //       _sendOtpInProgress = true;
  //     });
  //
  //     final String email = _forgotPasswordEmailTE.text.trim();
  //
  //     NetworkResponse response = await NetworkCaller.postRequest(
  //       url: Urls.sendOtp,
  //       body: {
  //         "email": email,
  //       },
  //     );

      // setState(() {
      //   _sendOtpInProgress = false;
      // });

  //     if (response.isSuccess) {
  //       showSnackBarMessage(context, "OTP sent to $email");
  //
  //       // Navigate to PinVerificationScreen and pass the email
  //       Navigator.pushNamed(context, PinVerificationScreen.name);
  //     } else {
  //       showSnackBarMessage(context, "Failed to send OTP. Try again.");
  //     }
  //   }
  // }

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
                    "Your Email Address",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "A 6 digit verification pin will be sent to\nyour email address",
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(color: Colors.grey),
                  ),
                  const SizedBox(height: 21),
                  TextFormField(
                    controller: _forgotPasswordEmailTE,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                      hintText: "Email",
                    ),
                    validator: (String? value) {
                      String email = value ?? "";
                      if (!EmailValidator.validate(email)) {
                        return "Enter a valid email";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  _sendOtpInProgress
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                    onPressed: (){},
                    child: const Icon(Icons.arrow_circle_right_outlined),
                  ),
                  const SizedBox(height: 18),
                  Center(
                    child: RichText(
                      text: const TextSpan(
                        text: "Have an account? ",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          letterSpacing: 0.4,
                        ),
                        children: [
                          TextSpan(
                            text: "Sign In",
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
