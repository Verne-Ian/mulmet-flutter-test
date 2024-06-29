import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final myCloudFire = FirebaseFirestore.instance;


void addToDB(BuildContext context, TextEditingController textEditingController, {required String name, required String email, required String uid, required Function setState}) async {
  double w = MediaQuery.of(context).size.width;
  double h = MediaQuery.of(context).size.height;
  if(name.isNotEmpty && email.isNotEmpty && uid.isNotEmpty){
    await myCloudFire.collection('users').doc(uid).set(
      {
        'ID': uid,
        'User name': name,
        'Email': email
      }
    ).then((result){
      showDialog(
          context: context, 
          builder: (context)=>const AlertDialog(
            title: Text("Success"),
            icon: Icon(Icons.done_all),
          ));
      setState((){
        textEditingController.text = '';
      });
    });
  }
}