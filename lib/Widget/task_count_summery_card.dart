import 'package:flutter/material.dart';


class TaskCountSummeryCard extends StatefulWidget {
  const TaskCountSummeryCard({super.key, required this.title, required this.count});
  final String title;
  final int count;

  @override
  State<TaskCountSummeryCard> createState() => _TaskCountSummeryCardState();
}

class _TaskCountSummeryCardState extends State<TaskCountSummeryCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      child: Padding(padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("5", style: Theme.of(context).textTheme.titleLarge,),
            Text("New", maxLines: 1,)
          ],
        ),

      ),
    );
  }
}
