import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:todo/core/utils/extract_data.dart';
import 'package:todo/models/task_model.dart';

class FirebaseUtils {

  CollectionReference<TaskModel> getCollectionRef() {
    var db = FirebaseFirestore.instance;
    return db.collection("tasks").withConverter<TaskModel>(
          fromFirestore: (snapshot, _) =>
              TaskModel.fromFirestore(snapshot.data()!),
          toFirestore: (taskmodel, _) => taskmodel.toFirestore(),
        );
  }

  Future<void> addANewTask(TaskModel data) {
    var collectionRef = getCollectionRef();
    var docRef = collectionRef.doc();
    data.id = docRef.id;
    return docRef.set(data);
  }

  Future<List<TaskModel>> getDataFromFirestore(DateTime dateTime) async {
    var collectionRef = getCollectionRef().where("date",
        isEqualTo: extractDateTime(dateTime).millisecondsSinceEpoch);

    var data = await collectionRef.get();

    return data.docs.map((e) => e.data()).toList();
  }

  Stream<QuerySnapshot<TaskModel>> getStreamDataFromFirestore(
      DateTime dateTime) {
    var collectionRef = getCollectionRef().where("date",
        isEqualTo: extractDateTime(dateTime).millisecondsSinceEpoch);

    return collectionRef.snapshots();
  }

  Future<void> deleteTask(TaskModel taskModel) {
    var collectionRef = getCollectionRef();
    return collectionRef.doc(taskModel.id).delete() ;

  }

  Future<void> updateTask(TaskModel taskModel) {
    var collectionRef = getCollectionRef();
    var docRef =  collectionRef.doc(taskModel.id);
    return docRef.update(taskModel.toFirestore());
  }

  Future<bool> createUserWithEmailAndPassword(
      String emailAddress, String password) async {
    EasyLoading.show();
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      print(credential.user?.email);
      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      ;
      EasyLoading.dismiss();
      return Future.value(false);
    } catch (e) {
      print(e);
      EasyLoading.dismiss();
      return Future.value(false);
    }
  }

  Future<bool> loginUserAccount(String emailAddress, String password) async {
    try {
      EasyLoading.show();
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);

      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        EasyLoading.dismiss();
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        EasyLoading.dismiss();
      }
      return Future.value(false);
    }
  }
}
