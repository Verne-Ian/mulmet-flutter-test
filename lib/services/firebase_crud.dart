import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
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

void deleteRecord(BuildContext context, {required String userId}) async {
  try{
    await myCloudFire.collection('users').doc(userId).delete().then((result){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Deleted'),
          backgroundColor: Colors.red,
        ),
      );
    });
  }catch(e){
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('An error occurred', style: TextStyle(color: Colors.yellow),),
        backgroundColor: Colors.black,
      ),
    );
  }
}

void updateRecord(BuildContext context, TextEditingController controller, {required String newName, required String userId, required Function setState}) async {
  await myCloudFire.collection('users').doc(userId).update({'User name': newName}).then((result){
    setState((){
      controller.text = '';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Name updated', style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.green,
      ),
    );
  });
}