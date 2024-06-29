import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mulmet_flutter_test/interface/home.dart';

final myAuth = FirebaseAuth.instance;

emailLogin( TextEditingController emailControl, TextEditingController passControl,
    String email, String password, BuildContext context) async {
  try {
    showDialog(
        context: context,
        builder: (context) {
          return Scaffold(
            backgroundColor: Colors.black.withOpacity(0.2),
            body: const Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Logging in...',
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  SpinKitDualRing(
                    color: Colors.green,
                    size: 25.0,
                  ),
                ],
              ),
            ),
          );
        });
    await myAuth.signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context)=> const MyHomePage(title: 'Home')), (Route<dynamic> route) => false);
    });
  } on FirebaseAuthException catch (e) {
    Navigator.pop(context);

    if (e.code == 'user-not-found') {
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              title: Text('User Not Found'),
            );
          });
      emailControl.text = '';
    } else if (e.code == 'wrong-password') {
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              title: Text('Wrong Password'),
            );
          });
      passControl.text = '';
    }
  }
}