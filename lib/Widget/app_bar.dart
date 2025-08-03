import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:untitled/Ui/login_screen.dart';
import 'package:untitled/Ui/update_profile_screen.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  State<MyAppBar> createState() => _MyAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.green,
      title: GestureDetector(
        onTap: _TapToUpdateProfileScreen,
        child: Row(
          children: [
            CircleAvatar(),
            const SizedBox(width: 16,),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Avi chakroborty", style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white
                ),),
                Text("avijeetchakroborty@gmail.com", style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.white
                ),)
              ],
            )),
            IconButton(onPressed: _TapToLoginScreen, icon: Icon(Icons.logout))
          ],
        ),
      ),
    );
  }
}

void _TapToLoginScreen(){
  Get.offAndToNamed(SignInScreen.name);
}

void _TapToUpdateProfileScreen(){
  Get.toNamed(UpdateProfileScreen.name);
}
