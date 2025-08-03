import 'package:flutter/material.dart';

import 'package:untitled/Ui/cancelled_task_list_screen.dart';
import 'package:untitled/Ui/completed_task_list.dart';
import 'package:untitled/Ui/new_task_list_screen.dart';
import 'package:untitled/Ui/progress_task_list_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});
  static String name = "/main_navigation_screen";
  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentpage = 0;
  final List<Widget> _screen = [
    NewTaskScreen(),
    CompletedTaskScreen(),
    CancelledTaskListScreen(),
    ProgressTaskListScreen()
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screen[_currentpage],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentpage,
          onTap: (index){
          setState(() {
            _currentpage = index;
          });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.new_label), label: "New"),
            BottomNavigationBarItem(icon: Icon(Icons.cloud_done_rounded), label: "Completed"),
            BottomNavigationBarItem(icon: Icon(Icons.cancel_rounded), label: "Cancelled"),
            BottomNavigationBarItem(icon: Icon(Icons.incomplete_circle), label: "Progress")
          ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
