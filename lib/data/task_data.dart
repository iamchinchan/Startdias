import 'dart:collection';

import '../data_classes/task.dart';
import 'package:flutter/foundation.dart';

class TaskData extends ChangeNotifier {
  final List<Task> _tasks = <Task>[
    Task(name: 'Buy Milk'),
    Task(name: 'Buy Potato'),
    Task(name: 'Buy Tomato'),
  ];
  UnmodifiableListView get tasks {
    return UnmodifiableListView(_tasks);
  }

  void addTask(String newTaskName) {
    Task newTask = Task(name: newTaskName);
    _tasks.add(newTask);
    notifyListeners();
  }

  void updateTask(int index) {
    _tasks[index].toggleDone();
    notifyListeners();
  }

  void deleteTask(int index) {
    _tasks.removeAt(index);
    notifyListeners();
  }

  int get taskLength {
    return _tasks.length;
  }
}
