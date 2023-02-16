import 'package:cloud_firestore/cloud_firestore.dart';

import '../data_classes/task.dart';

class FirestoreService {
  final _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>?>? getTasks(String uid) {
    try {
      return _firestore
          .collection('users')
          .doc(uid)
          .collection('ideas')
          .orderBy('timestamp')
          .snapshots();
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool> addTask({required String uid, required String taskName}) async {
    try {
      dynamic result = await _firestore
          .collection('users')
          .doc(uid)
          .collection('ideas')
          .add({
        'timestamp': FieldValue.serverTimestamp(),
        'isDone': false,
        'ideaName': taskName,
      });
      print('added data: ${result}');
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteTask({required String taskId, required String uid}) async {
    try {
      void status = await _firestore
          .collection('users')
          .doc(uid)
          .collection('ideas')
          .doc(taskId)
          .delete();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> updateTask(
      {required String uid, required QueryDocumentSnapshot task}) async {
    try {
      void status = await _firestore
          .collection('users')
          .doc(uid)
          .collection('ideas')
          .doc(task.id)
          .update({
        'isDone': !task['isDone'],
        'ideaName': task['ideaName'],
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}

// tempPrint(String uid) async {
//   dynamic result =
//       await _firestore.collection('users').doc(uid).collection('ideas').get();
//   // .collection('ideas').get();
//   print(result.docs);
//   for (final task in result.docs) {
//     print(task);
//   }
// }
