import 'package:firebase_auth/firebase_auth.dart';

class FirebaseUtils{
  String emailAddress;
  String password;

  FirebaseUtils(this.emailAddress, this.password);

  createUserWithEmailAndPassword(String emailAddress , String password ) async{

    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      print(credential.user?.email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

}