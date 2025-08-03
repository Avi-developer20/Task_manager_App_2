import 'package:flutter/material.dart';
import 'package:untitled/Data/urls.dart/';
import 'package:untitled/Widget/center_circular_indicator.dart';
import 'package:untitled/Data/Models/task_model.dart';
import 'package:untitled/Data/service/network_caller.dart';
import 'package:untitled/Widget/snackbar_message.dart';

enum TaskType { tNew, progress, completed, cancelled }

class TaskCard extends StatefulWidget {
  const TaskCard({super.key, required this.taskType,
    required this.taskModel, required this.onStatusUpdate});
  final TaskType taskType;
  final TaskModel taskModel;
  final VoidCallback onStatusUpdate;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
           elevation: 0,
      color: Colors.white,
      child: Padding(padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("DPP solve + Home work", style: Theme.of(context).textTheme.titleMedium,),
            Text("Allen kota Nation Topper batch's DPP and Home work",
              style: TextStyle(color:Colors.black54 ),),
            Text("25-07-2029"),
            const SizedBox(height: 8,),
            Row(
              children: [
                Chip(
                    label: Text("New", style: TextStyle(color: Colors.white),),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  backgroundColor: Colors.lightBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide.none
                  ),
                ),
                Spacer(),
                IconButton(onPressed: (){}, icon: Icon(Icons.delete)),
                IconButton(onPressed: (){}, icon: Icon(Icons.edit))



              ],
            )
          ],
        ),
      ),
    );
  }
}
