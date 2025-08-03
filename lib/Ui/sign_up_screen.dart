import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:untitled/Data/service/network_caller.dart';
import 'package:untitled/Data/urls.dart';
import 'package:untitled/Widget/backgroud_screen.dart';
import 'package:untitled/Widget/center_circular_indicator.dart';
import 'package:untitled/Widget/snackbar_message.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
static String name = "/sign_up_screen";

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  GlobalKey<FormState> _signUpkey = GlobalKey<FormState>();
  TextEditingController _signUpEmailTE = TextEditingController();
  TextEditingController _signUpFirstNameTE = TextEditingController();
  TextEditingController _signUpLastNameTE = TextEditingController();
  TextEditingController _signUpPhoneTE = TextEditingController();
  TextEditingController _signUpPassTE = TextEditingController();
  bool _signupINProgress = false;

  void _onTapToSignUpButton(){
    if (_signUpkey.currentState!.validate()) {
      _signup();
    }
  }
  Future<void> _signup() async {
    _signupINProgress = true;
    setState(() {});

    Map<String, String> requestBody = {
      'email': _signUpEmailTE.text.trim(),
      "firstName": _signUpFirstNameTE.text.trim(),
      "lastName": _signUpLastNameTE.text.trim(),
      "mobile": _signUpPhoneTE.text.trim(),
      "password": _signUpPassTE.text
    };
    NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.Registration,
        body: requestBody
    );
    _signupINProgress = false;
    setState(() {});
    void _TapToSignUp(){
      Navigator.pushNamed(context, SignUpScreen.name);
    }
    if (response.isSuccess) {
      _clearTextField();
      showSnackBarMessage(
          context, 'Registration has been success. Please login');
    } else {
      showSnackBarMessage(context, response.errormessage!);
    }
  }
    void _clearTextField() {
      _signUpEmailTE.clear();
      _signUpFirstNameTE.clear();
      _signUpLastNameTE.clear();
      _signUpPhoneTE.clear();
      _signUpPassTE.clear();
    }
    void _onTapToSignInScreen() {
      Navigator.pushNamed(context, SignUpScreen.name);
    }
    @override
    void dispose() {
      _signUpEmailTE.dispose();
      _signUpFirstNameTE.dispose();
      _signUpLastNameTE.dispose();
      _signUpPhoneTE.dispose();
      _signUpPassTE.dispose();
      super.dispose();
    }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
          child: SingleChildScrollView(
               child: Padding(padding: EdgeInsets.all(16),
                 child: Form(
                  key: _signUpkey,
                   autovalidateMode: AutovalidateMode.onUserInteraction,
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       const SizedBox(height: 150,),
                       Text("Join With Us", style: Theme.of(context).textTheme.titleLarge,),
                       const SizedBox(height: 25),
                       TextFormField(
                         controller: _signUpEmailTE,
                         textInputAction: TextInputAction.next,
                         decoration: InputDecoration(hintText: "Email"),
                         validator: (String? value){
                           String email = value ?? "";
                           if(EmailValidator.validate(email) == false){
                             return "Enter a valid email";
                           }
                           return null;
                         },
                       ),
                       const SizedBox(height: 10,),
                       TextFormField(
                         controller: _signUpFirstNameTE,
                         textInputAction: TextInputAction.next,
                         decoration: InputDecoration(hintText: "First Name"),
                         validator: (String? value){
                           if(value?.trim().isEmpty ?? true){
                             return "Enter your First name";
                           } return null;
                         },

                       ),
                       const SizedBox(height: 10,),
                       TextFormField(
                         controller: _signUpLastNameTE,
                         textInputAction: TextInputAction.next,
                         decoration: InputDecoration(hintText: "Last Name"),
                         validator: (String? value){
                           if(value?.trim().isEmpty ?? true){
                             return "Enter your Last name";
                           } return null;
                         },

                       ),
                       const SizedBox(height: 10,),
                       TextFormField(
                         controller: _signUpPhoneTE,
                         textInputAction: TextInputAction.next,
                         keyboardType: TextInputType.number,
                         decoration: InputDecoration(hintText: "Mobile",),
                         validator: (String? value){
                           if(value?.trim().isEmpty ?? true){
                             return "Enter your Mobile number";
                           } return null;
                         },

                       ),
                       const SizedBox(height: 10,),
                       TextFormField(
                         controller: _signUpPassTE,
                         obscureText: true,
                         decoration: InputDecoration(hintText: "Password"),
                         validator: (String? value){
                           if((value?.length ?? 0) <= 6){
                             return " Enter a valid password";
                           }
                           return null;
                         },

                       ),
                       const SizedBox(height: 20,),
                       Visibility(
                         visible: _signupINProgress == false,
                         replacement: CenterCircularIndicatorWidget(),
                         child: ElevatedButton(onPressed: _onTapToSignUpButton,
                             child: Icon(Icons.arrow_circle_right_outlined)),
                       ),
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
                                 ),
                               recognizer:
                               TapGestureRecognizer()
                                 ..onTap = _onTapToSignInScreen,
                             )
                           ]
                         )),

                       )


                     ],
                   ),
                 ),
               ),
          )
      ),
    );
  }
}





