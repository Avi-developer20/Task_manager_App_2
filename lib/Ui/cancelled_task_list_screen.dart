import 'package:flutter/material.dart';
import 'package:untitled/Data/Models/task_model.dart';
import 'package:untitled/Data/service/network_caller.dart';
import 'package:untitled/Data/urls.dart';
import 'package:untitled/Widget/app_bar.dart';
import 'package:untitled/Widget/snackbar_message.dart';
import 'package:untitled/Widget/task_card.dart';

class CancelledTaskListScreen extends StatefulWidget {
  const CancelledTaskListScreen({super.key});
static String name = "/cancelled_task_screen";
  @override
  State<CancelledTaskListScreen> createState() => _CancelledTaskListScreenState();
}

class _CancelledTaskListScreenState extends State<CancelledTaskListScreen> {
  bool _getCancelledTaskInProgress = false;
  List<TaskModel> _cancelledTaskList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      _getCancelledTaskList();


    });
  }

  Future<void> _getCancelledTaskList() async{
    _getCancelledTaskInProgress = true;
    setState(() {});

    NetworkResponse response = await NetworkCaller.getRequest(url: Urls.getProgressTask);
    if(response.isSuccess){
      List<TaskModel> list = [];
      for(Map<String ,dynamic> jsonData in response.body!["data"]) {
        list.add(TaskModel.fromJson(jsonData));
        _cancelledTaskList = list;
      }
    } else{
      showSnackBarMessage(context, response.errormessage!);
    }
    _getCancelledTaskInProgress = false;
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
                  itemCount: _cancelledTaskList.length,
                  itemBuilder: (context, index){
                    return TaskCard(
                      taskType: TaskType.cancelled,
                      taskModel: _cancelledTaskList[index],
                      onStatusUpdate: (){
                        _getCancelledTaskList();
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
