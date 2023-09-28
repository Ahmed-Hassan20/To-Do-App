import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/model/task.dart';

class firebaseutils {
  static CollectionReference<task> getTaskCollection() {
    return FirebaseFirestore.instance
        .collection(task.collectionName)
        .withConverter<task>(
            fromFirestore: (snapshot, options) =>
                task.fromFireStore(snapshot.data()!),
            toFirestore: (task, options) => task.toFireStore());
  }

  static Future<void> addtasktofirebase(task Task) {
    var taskCollection = getTaskCollection();
    DocumentReference<task> taskDocRef = taskCollection.doc();
    Task.id = taskDocRef.id;
    return taskDocRef.set(Task);
  }

  static Future<void> deletetaskfromfirebase(task Task) {
    return getTaskCollection().doc(Task.id).delete();
  }
}
