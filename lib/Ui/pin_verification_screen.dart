import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:get/get.dart';
import 'package:untitled/Ui/new_password_screen.dart';
import 'package:untitled/Widget/backgroud_screen.dart';

class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({super.key});
  static String name = "/pin_verification_screen";

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}
TextEditingController _otpTE = TextEditingController();
GlobalKey<FormState> _otpkey = GlobalKey<FormState>();

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(child: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(16),
        child: Form(
            key: _otpkey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 150,),
                Text("Pin Verification", style: TextTheme.of(context).titleLarge,),
                const SizedBox(height: 4,),
                Text("A 6 digits OTP has been sent to \n "
                    "your email address", style: Theme.of(context).textTheme.
                titleSmall?.copyWith(color: Colors.grey),),
                const SizedBox(height: 24,),
                PinCodeTextField(
                    length: 6,
                  animationType: AnimationType.fade,
                  keyboardType: TextInputType.number,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 50,
                    activeFillColor: Colors.white,
                    selectedColor: Colors.green,
                    inactiveColor: Colors.grey
                  ),
                  animationDuration: Duration(milliseconds: 300),
                  backgroundColor: Colors.transparent,
                  controller: _otpTE,
                  appContext: context,
                ), const SizedBox(height: 16,),
                ElevatedButton(onPressed: _TapToNewPasswordScreen,
                    child: Icon(Icons.arrow_circle_right_outlined)),
                const SizedBox(height: 18,),
                Center(
                  child: RichText(text: TextSpan(
                      text: "Have account?",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        letterSpacing: 0.4,
                      ),
                      children: [
                        TextSpan(
                            text: "Sign In", style:
                        TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.w700
                        )
                        )
                      ]
                  )),

                )

              ],
            )),),
      )),
    );
  }
}
 void _TapToNewPasswordScreen(){
  Get.toNamed(NewPasswordScreen.name);
 }