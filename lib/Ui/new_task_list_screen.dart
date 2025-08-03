import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/Data/Models/task_model.dart';
import 'package:untitled/Data/Models/task_status_count_model.dart';
import 'package:untitled/Data/service/network_caller.dart';
import 'package:untitled/Data/urls.dart';
import 'package:untitled/Ui/add_task_screen.dart';
import 'package:untitled/Widget/app_bar.dart';
import 'package:untitled/Widget/center_circular_indicator.dart';
import 'package:untitled/Widget/snackbar_message.dart';
import 'package:untitled/Widget/task_card.dart';
import 'package:untitled/Widget/task_count_summery_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});
  static String name = "/new_task_screen";

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool _getNewTaskINProgess = false;
  bool _getTaskStatusCOuntInProgess = false;
  List<TaskModel> _newTaskList = [];
  List<TaskStatusCountModel> _taskStatusCountList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      _getNewTaskList();
      _getNewTaskCountList();

    });
  }

  Future<void> _getNewTaskList() async{
    _getNewTaskINProgess = true;
    setState(() {});
    
    NetworkResponse response = await NetworkCaller.getRequest(url: Urls.getNewTask );
    if(response.isSuccess){
      List<TaskModel> list = [];
      for(Map<String, dynamic> jsonData in response.body!["data"]){
        list.add(TaskModel.fromJson(jsonData));
      }
      _newTaskList = list;
    }else{
      if(mounted){
        showSnackBarMessage(context, response.errormessage!);
      }
    }
    _getNewTaskINProgess = false;
    setState(() {});
    if(mounted){
      setState(() {});
    }
  }
  Future<void> _getNewTaskCountList() async{
    _getTaskStatusCOuntInProgess = true;
    setState(() {});
    
    NetworkResponse response = await NetworkCaller.getRequest(url: Urls.getProgressTask);
    if(response.isSuccess){
      List<TaskStatusCountModel> list = [];
      for(Map<String, dynamic> jsonData in response.body!['data']){
        list.add(TaskStatusCountModel.fromJson(jsonData));
      }
      _taskStatusCountList =list;
    }else{
      if(mounted){
        showSnackBarMessage(context, response.errormessage!);
      }
    }
    _getTaskStatusCOuntInProgess = false;
    if(mounted){
      setState(() {});
    }
  }
  void _OnTapToNewTaskButton(){
    Navigator.pushNamed(context, AddTaskScreen.name);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            SizedBox(
              height: 100,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _taskStatusCountList.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: (MediaQuery.of(context).size.width - 8 * 2 - 8 * 3) /
                        4,
                    child: TaskCountSummeryCard(
                      title: _taskStatusCountList[index].id,
                      count: _taskStatusCountList[index].count,
                    ),
                  );
                },
                separatorBuilder: (context, index) =>
                const SizedBox(width: 8),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Visibility(
                visible: _getNewTaskINProgess == false,
                replacement: CenterCircularIndicatorWidget(),
                child: ListView.builder(
                  itemCount: _newTaskList.length,
                  itemBuilder: (context, index) {
                    return TaskCard(
                      taskType: TaskType.tNew,
                        taskModel: _newTaskList[index],
                      onStatusUpdate: () {
                        _getNewTaskList();
                        _getNewTaskCountList();
                      },

                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _OnTapToNewTaskButton,
        child: const Icon(Icons.add),
      ),
    );
  }
}

