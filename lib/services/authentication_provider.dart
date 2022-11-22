import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future? signInAno() async {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInAnonymously();
  }

  Future? signInEmailAndPassword(email, password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future? register(email, password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email');
      }
    } catch (e) {
      print(e);
    }
  }

  Future? signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Stream<User> get user {
    var _auth;
    return _auth.authStateChanges();
  }
}
