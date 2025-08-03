import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/Ui/login_screen.dart';
import 'package:untitled/Widget/backgroud_screen.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  static String name = '/new_password_screen';
  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {

  TextEditingController _newpasswordTE = TextEditingController();
  TextEditingController _confirmpasswordTE = TextEditingController();
  GlobalKey<FormState> _newpasswordkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(child: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(16),
        child: Form(
            key: _newpasswordkey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 150,),
                Text("Set Password", style: Theme.of(context).textTheme.titleLarge,),
                const SizedBox(height: 4,),
                Text("Password should be more than 6 letters.", style: Theme.of(context)
                    .textTheme.titleSmall?.copyWith(color: Colors.grey)
                  ,),
                const SizedBox(height: 24,),
                TextFormField(
                  controller: _newpasswordTE,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: "New password",
                  ),
                  validator: (String? value){
                    String email = value ?? "";
                    if((value?.length ?? 0) <= 6){
                      return "Enter a valid password";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12,),
                TextFormField(
                  controller: _confirmpasswordTE,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: "confirm password",
                  ),
                  validator: (String? value){
                    String email = value ?? "";
                    if(_newpasswordTE.text != _confirmpasswordTE.text){
                      return "Enter a valid password";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16,),
                ElevatedButton(onPressed: _TapToLoginScreen,
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
            )
        ),),
      )),
    );
  }
}


 void _TapToLoginScreen(){
  Get.toNamed(SignInScreen.name);
 }