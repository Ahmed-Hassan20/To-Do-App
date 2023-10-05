import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/model/my_user.dart';
import 'package:todo/model/task.dart';

class firebaseutils {
  static CollectionReference<task> getTaskCollection(String uId) {
    return getUsersCollection()
        .doc(uId)
        .collection(task.collectionName)
        .withConverter<task>(
            fromFirestore: (snapshot, options) =>
                task.fromFireStore(snapshot.data()!),
            toFirestore: (task, options) => task.toFireStore());
  }

  static Future<void> addtasktofirebase(task Task,String uId) {
    var taskCollection = getTaskCollection(uId);
    DocumentReference<task> taskDocRef = taskCollection.doc();
    Task.id = taskDocRef.id;
    return taskDocRef.set(Task);
  }

  static Future<void> deletetaskfromfirebase(task Task,String uId) {
    return getTaskCollection(uId).doc(Task.id).delete();
  }

  static Future<void> updatetaskDone(task Task,String uId) async {
    DocumentReference<task> taskDocRef =
        await firebaseutils.getTaskCollection( uId).doc(Task.id);
    taskDocRef.update({'isDone': true});
  }

  static Future<void> updatetaskedit(task Task,String uId) async {
    DocumentReference<task> taskDocRef =
        await firebaseutils.getTaskCollection(uId).doc(Task.id);
    taskDocRef.update({
      'title': Task.title,
      'description': Task.description,
      'dateTime': Task.dateTime?.millisecondsSinceEpoch,
    });
  }

  static CollectionReference<MyUser> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
            fromFirestore: (snapshot, options) =>
                MyUser.fromFireStore(snapshot.data()),
            toFirestore: (user, options) => user.toFireStore());
  }

  static Future<void> addUsertofirebase(MyUser myUser) {
    return getUsersCollection().doc(myUser.id).set(myUser);
  }

  static Future<MyUser?> reafUserFromFirestore(String uId) async {
    var querySnapshot = await getUsersCollection().doc(uId).get();
    return querySnapshot.data();
  }
}
