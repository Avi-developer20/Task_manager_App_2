import 'package:flutter/material.dart';

import 'package:untitled/Data/Models/task_model.dart';
import 'package:untitled/Data/service/network_caller.dart';
import 'package:untitled/Data/urls.dart';
import 'package:untitled/Widget/app_bar.dart';
import 'package:untitled/Widget/snackbar_message.dart';
import 'package:untitled/Widget/task_card.dart';

class ProgressTaskListScreen extends StatefulWidget {
  const ProgressTaskListScreen({super.key});
  static String name = "/progress_task_screen ";

  @override
  State<ProgressTaskListScreen> createState() => _ProgressTaskListScreenState();
}

class _ProgressTaskListScreenState extends State<ProgressTaskListScreen> {
  bool _getProgressTaskInProgress = false;
  List<TaskModel> _progressTaskList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      _getProgressTaskList();

    });
  }

  Future<void> _getProgressTaskList() async{
    _getProgressTaskInProgress = true;
    setState(() {});
    
    NetworkResponse response = await NetworkCaller.getRequest(url: Urls.getProgressTask);
    if(response.isSuccess){
      List<TaskModel> list = [];
      for(Map<String ,dynamic> jsonData in response.body!["data"]){
        list.add(TaskModel.fromJson(jsonData));
      }
      _progressTaskList = list;
    } else{
    showSnackBarMessage(context, response.errormessage!);
    }
    _getProgressTaskInProgress = false;
    setState(() {});

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Padding(padding: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            const SizedBox(height: 30,),
            Expanded(
              child: ListView.builder(
                  itemCount: _progressTaskList.length,
                  itemBuilder: (context, index){
                    return TaskCard(
                      taskType: TaskType.progress,
                      taskModel: _progressTaskList[index],
                      onStatusUpdate:  () {
                      _getProgressTaskList();
                    },

                    );
                  }),
            )
          ],
        ),

      ),
    );
  }
}
