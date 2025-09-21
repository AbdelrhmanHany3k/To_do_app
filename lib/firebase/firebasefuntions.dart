import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/models/Task_model.dart';
import 'package:to_do_app/models/user_model.dart';

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

  static CollectionReference<Usermodel> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection("Users")
        .withConverter<Usermodel>(
      fromFirestore: (snapshot, _) {
        return Usermodel.fromJson(snapshot.data()!);
      },
      toFirestore: (user, _) {
        return user.toJson();
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
         .where("userId",isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .where("Date",
        isEqualTo: DateUtils.dateOnly(date).millisecondsSinceEpoch)
        .snapshots();
  }

  static Future<void> deleteTask(String id) async {
    return getTasksCollection().doc(id).delete();
  }

  static Future<void> updateTask(TaskModel model) async {
    return getTasksCollection().doc(model.id).update(model.toJson());
  }

  static Future<void> addUser(Usermodel model) async {
    var collection = getUsersCollection();
    var docref = collection.doc(model.id);
    await docref.set(model);
  }

  static Future<Usermodel?> readuser()async{
    DocumentSnapshot<Usermodel> docref =await getUsersCollection().doc(FirebaseAuth.instance.currentUser!.uid).get();
    return docref.data();
  }

  static createaccountauth(
      String emailAddress,
      String password, {
        required String name,
        required String number,
        required Function onSuccess,
        required Function onError,
      }) async {
    try {
      final credential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      await credential.user?.sendEmailVerification();

      // حفظ بيانات المستخدم في Firestore
      var userModel = Usermodel(
        id: credential.user!.uid,
        email: emailAddress,
        name: name,
        password: password,
        number: number,
      );
      await addUser(userModel);

      onSuccess(credential.user?.email ?? "");
    } on FirebaseAuthException catch (e) {
      onError(e.message ?? "Signup failed");
    } catch (e) {
      onError(e.toString());
    }
  }

  static signin(
      String emailAddress,
      String password, {
        required Function onSuccess,
        required Function onError,
      }) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);

      onSuccess(credential.user?.displayName ?? "");
    } on FirebaseAuthException catch (e) {
      onError(e.message);
    } catch (e) {
      onError(e.toString());
    }
  }
}
