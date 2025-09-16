import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_app/Task_model.dart';

class FireBaseFunctions{
 static CollectionReference<TaskModel>getTasksCollection(){
    return FirebaseFirestore
        .instance
        .collection("Tasks")
        .withConverter(fromFirestore: (snapshot,_ ) {
      return TaskModel.fromJson(snapshot.data()!);
    },

      toFirestore: (TaskModel, _) {
        return TaskModel.toJson();
      },
    );
  }
  static Future<void> addtask(TaskModel model)async{
    var collection=getTasksCollection();
    var docref=collection.doc();
    model.id=docref.id;
    docref.set(model);
  }
  static Stream<QuerySnapshot<TaskModel>>gettask(){
   var collection=getTasksCollection();
   return collection.snapshots();
  }
}