import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  const TaskTile(
      {required this.taskName,
      required this.isChecked,
      required this.toggleCheckbox,
      required this.onDeleteTask,
      Key? key})
      : super(key: key);
  final Function toggleCheckbox;
  final Function onDeleteTask;
  final String taskName;
  final bool isChecked;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: GestureDetector(
            onTap: () {
              onDeleteTask();
            },
            child: Icon(
              Icons.delete,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          trailing: Checkbox(
            activeColor: Theme.of(context).colorScheme.secondary,
            value: isChecked,
            onChanged: (newValue) {
              toggleCheckbox();
            },
          ),
          selected: false,
          // selectedTileColor: Colors.pink,
          tileColor: const Color(0xffebdadc),
          title: Text(
            taskName,
            style: TextStyle(
              decoration: isChecked ? TextDecoration.lineThrough : null,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
