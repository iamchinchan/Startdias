import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stardias/data/user_model.dart';
import 'package:stardias/services/auth_service.dart';
import 'package:stardias/services/firestore_service.dart';
import '../components/task_list.dart';
import '../components/add_task.dart';

class IdeaScreen extends StatelessWidget {
  static const id = 'idea_screen';
  const IdeaScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final userUid = Provider.of<UserModel>(context).uid;
    return StreamProvider<QuerySnapshot<Map<String, dynamic>>?>.value(
      value: FirestoreService().getTasks(userUid),
      initialData: null,
      builder: (context, snapshot) => Builder(
        builder: (context) {
          final int? taskLength =
              Provider.of<QuerySnapshot<Map<String, dynamic>>?>(context)
                  ?.docs
                  .length;
          return Scaffold(
            appBar: AppBar(
              title: const Text('Stardias'),
              backgroundColor: Theme.of(context).colorScheme.secondary,
              elevation: 0.0,
              actions: <Widget>[
                TextButton.icon(
                  icon: const Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'Sign out',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    dynamic logOutstatus = await AuthService().signOut();
                  },
                )
              ],
            ),
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (newContext) {
                    return AddTask(
                      parentContext: context,
                    );
                  },
                );
              },
            ),
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircleAvatar(
                            radius: 28,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.list,
                              color: Theme.of(context).colorScheme.secondary,
                              size: 35.0,
                            ),
                          ),
                          Text(
                            'Stardias',
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          Text(
                            '${taskLength ?? 0} tasks',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 15.0),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                        ),
                      ),
                      // child: Container(),
                      child: (taskLength == null || taskLength == 0)
                          ? Center(
                              child: Text(
                                'No Ideas yet!!',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineLarge!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                              ),
                            )
                          : const TaskList(),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
