import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/Task_model.dart';

class FireBaseFunctions {
  static CollectionReference<TaskModel> getTasksCollection() {
    return FirebaseFirestore.instance
        .collection("Tasks")
        .withConverter<TaskModel>(
      fromFirestore: (snapshot, _) {
        return TaskModel.fromJson(snapshot.data()!);
      },
      toFirestore: (task, _) {
        return task.toJson();
      },
    );
  }

  static Future<void> addtask(TaskModel model) async {
    var collection = getTasksCollection();
    var docref = collection.doc();
    model.id = docref.id;
    await docref.set(model);
  }

  static Stream<QuerySnapshot<TaskModel>> gettask(DateTime date) {
    var collection = getTasksCollection();
    return collection
        .where("Date",
        isEqualTo: DateUtils.dateOnly(date).millisecondsSinceEpoch)
        .snapshots();
  }

  static Future<void> deleteTask(String id) async {
    return getTasksCollection().doc(id).delete();
  }

  static Future<void> updateTask(TaskModel model) async  {
    return getTasksCollection().doc(model.id).update(model.toJson());
  }
}