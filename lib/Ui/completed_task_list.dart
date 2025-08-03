import 'package:flutter/material.dart';
import 'package:untitled/Data/Models/task_model.dart';
import 'package:untitled/Data/service/network_caller.dart';
import 'package:untitled/Data/urls.dart';
import 'package:untitled/Widget/app_bar.dart';
import 'package:untitled/Widget/snackbar_message.dart';
import 'package:untitled/Widget/task_card.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});
  static String name = "/completed_task_list_screen";

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskListState();
}

class _CompletedTaskListState extends State<CompletedTaskScreen> {
  bool _getCompletedTaskInProgress = false;
  List<TaskModel> _completedTaskList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      _getCompletedTaskList();


    });
  }

  Future<void> _getCompletedTaskList() async{
    _getCompletedTaskInProgress = true;
    setState(() {});

    NetworkResponse response = await NetworkCaller.getRequest(url: Urls.getProgressTask);
    if(response.isSuccess){
      List<TaskModel> list = [];
      for(Map<String ,dynamic> jsonData in response.body!["data"]) {
        list.add(TaskModel.fromJson(jsonData));
        _completedTaskList = list;
      }
    } else{
      showSnackBarMessage(context, response.errormessage!);
    }
    _getCompletedTaskInProgress = false;
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
                  itemCount: _completedTaskList.length,
                  itemBuilder: (context, index){
                    return TaskCard(
                      taskType: TaskType.cancelled,
                      taskModel: _completedTaskList[index],
                      onStatusUpdate: (){
                        _getCompletedTaskList();
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
