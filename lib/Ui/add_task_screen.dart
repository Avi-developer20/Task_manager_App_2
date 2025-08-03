import 'package:flutter/material.dart';
import 'package:untitled/Data/service/network_caller.dart';
import 'package:untitled/Data/urls.dart';
import 'package:untitled/Widget/app_bar.dart';
import 'package:untitled/Widget/backgroud_screen.dart';
import 'package:untitled/Widget/snackbar_message.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  static String name = "/add_task_screen";

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  TextEditingController _titleTEcontroler = TextEditingController();
  TextEditingController _descriptionTEcontroler = TextEditingController();
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool _addNewTaskInProgess = false;


  void _TaptoSubmitButton(){
    if(_key.currentState!.validate()){
      _addNewTask();
    }
  }
  Future<void> _addNewTask() async{
    _addNewTaskInProgess = true;
    setState(() {});
    Map<String, String> requestBody = {
      "title" : _titleTEcontroler.text.trim(),
      "description" : _descriptionTEcontroler.text,
      "status" : "New",
    };
    NetworkResponse response = await NetworkCaller.postRequest(url: Urls.createTask, body: requestBody);
    _addNewTaskInProgess = false;
    setState(() {});

    if(response.isSuccess){
      _titleTEcontroler.clear();
      _descriptionTEcontroler.clear();
      showSnackBarMessage(context, 'Added new task');
    } else{
      showSnackBarMessage(context, response.errormessage!);
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: ScreenBackground(
          child: SingleChildScrollView(
            child: Padding(padding: EdgeInsets.all(16),
            child: Form(
              key: _key,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 100),
                  Text("Add New Task",
                    style: Theme.of(context).textTheme.titleLarge,),
                  const SizedBox(height: 25,),
                  TextFormField(
                    controller: _titleTEcontroler,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(hintText: "Title"),
                    validator: (String? value){
                      if(value?.trim().isEmpty ?? true){
                        return "Enter your title";
                      }
                      return null;
                    },
            
                  ),
                  const SizedBox(height: 12,),
                  TextFormField(
                    controller: _descriptionTEcontroler,
                    maxLines: 5,
                    decoration: InputDecoration(hintText: "Description"),
                  ),
                  const SizedBox(height: 25,),
                  ElevatedButton(onPressed: _TaptoSubmitButton, child: Icon(Icons.arrow_circle_right_outlined))
                ],
              ),
            
            ),),
          )
      ),
    );
  }
}


