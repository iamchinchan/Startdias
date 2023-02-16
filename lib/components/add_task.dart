import 'dart:io';

import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:stardias/data/user_model.dart';
import 'package:stardias/services/firestore_service.dart';

class AddTask extends StatefulWidget {
  const AddTask({required this.parentContext, Key? key}) : super(key: key);
  final BuildContext parentContext;
  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  String newTaskName = '';
  final _addTaskKey = GlobalKey<FormState>();
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    final userUid = Provider.of<UserModel?>(context)!.uid;
    return SingleChildScrollView(
      child: Container(
        color: const Color(0xff757575),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.0),
              topLeft: Radius.circular(20.0),
            ),
          ),
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 20.0,
            top: 20.0,
            left: 15.0,
            right: 15.0,
          ),
          child: Column(
            children: [
              Text(
                'Add new idea',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
              ),
              (showSpinner)
                  ? Column(
                      children: const <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: SizedBox(
                            width: 30,
                            height: 30,
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 32),
                          child: Text(
                            'Adding Idea...',
                            style:
                                TextStyle(color: Colors.black, fontSize: 24.0),
                          ),
                        ),
                      ],
                    )
                  : Form(
                      key: _addTaskKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            onChanged: (newValue) {
                              newTaskName = newValue;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some idea first';
                              }
                              return null;
                            },
                            style: const TextStyle(
                                color: Colors.black, fontSize: 24.0),
                            textAlign: TextAlign.center,
                            autofocus: true,
                          ),
                          const SizedBox(
                            height: 12.0,
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              fixedSize: const Size(double.infinity, 50.0),
                              foregroundColor: Colors.white,
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                            ),
                            onPressed: () async {
                              setState(() {
                                showSpinner = true;
                              });
                              if (_addTaskKey.currentState!.validate()) {
                                bool status = await FirestoreService().addTask(
                                    uid: userUid, taskName: newTaskName);
                                if (status == true) {
                                  print('task successfully added!');
                                  // sleep(Duration(seconds: 5));
                                  Navigator.pop(context);
                                } else {
                                  print('adding task failed, please retry!');
                                }
                              }
                              setState(() {
                                showSpinner = false;
                              });
                              // Provider.of<TaskData>(widget.parentContext, listen: false)
                              //     .addTask(newTaskName);
                            },
                            child: const Center(
                              child: Text(
                                'Add task',
                                style: TextStyle(fontSize: 18.0),
                              ),
                            ),
                          ),
                        ],
                      )),
            ],
          ),
        ),
      ),
    );
  }
}
