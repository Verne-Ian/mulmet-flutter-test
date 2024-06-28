import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mulmet_flutter_test/interface/home.dart';
import 'package:mulmet_flutter_test/interface/login.dart';

class AppStart extends StatelessWidget {
  const AppStart({super.key});

  @override
  Widget build(BuildContext context) {
    if(FirebaseAuth.instance.currentUser != null){
      return const MyHomePage(title: 'Home');
    }
    return const Login();
  }
}
