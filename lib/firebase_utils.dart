import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

 class FirebaseUtils{

   CollectionReference<Map<String,dynamic>> getCollectionRef(){
     var db = FirebaseFirestore.instance;
     return db.collection("tasks");
   }
  addANewTask(){

    var collectionRef=getCollectionRef();
    var docRef = collectionRef.doc();
    print(docRef.id);
    docRef.set({
      "name" : " steve",
      "job" : "flutter dev",
    });

  }

  getDataFromFirestore(){
    var collectionRef = getCollectionRef();

  }

  deleteTask(){
    var collectionRef = getCollectionRef();
  }
  updateTask(){
    var collectionRef = getCollectionRef();
  }

  Future<bool>createUserWithEmailAndPassword(String emailAddress , String password ) async{
      EasyLoading.show();
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      print(credential.user?.email);
      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      }
      else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      };
      EasyLoading.dismiss();
      return Future.value(false);
    }

    catch (e) {
      print(e);
      EasyLoading.dismiss();
      return Future.value(false);
    }
  }

  Future<bool>loginUserAccount(String emailAddress,String password ) async{
    try {
      EasyLoading.show();
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailAddress,
          password: password
      );

      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        EasyLoading.dismiss();
      }
      else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        EasyLoading.dismiss();
      }
      return Future.value(false);
    }
  }

}