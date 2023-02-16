import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stardias/data/user_model.dart';
import 'package:stardias/services/firestore_service.dart';
import 'task_tile.dart';

class TaskList extends StatelessWidget {
  const TaskList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final userUid = Provider.of<UserModel?>(context)!.uid;
    return Consumer<QuerySnapshot<Map<String, dynamic>>?>(
      builder: (context, taskData, child) => ListView.builder(
          // reverse: true,
          // shrinkWrap: true,
          itemCount: taskData!.docs.length,
          itemBuilder: (context, index) {
            final QueryDocumentSnapshot task = taskData.docs[index];
            // taskData.docs.length - 1 -
            // print(task.id);
            return TaskTile(
              taskName: task['ideaName'],
              isChecked: task['isDone'],
              toggleCheckbox: () {
                // taskData.updateTask(index);
                FirestoreService().updateTask(uid: userUid, task: task);
              },
              onDeleteTask: () {
                // taskData.deleteTask(index);
                FirestoreService().deleteTask(taskId: task.id, uid: userUid);
              },
            );
          }),
    );
  }
}
