import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:mulmet_flutter_test/services/firebase_crud.dart';
import 'package:mulmet_flutter_test/widgets/custom_widgets.dart';

class FirebaseCrud extends StatefulWidget {
  final String opType;
  const FirebaseCrud({super.key, required this.opType});

  @override
  State<FirebaseCrud> createState() => _FirebaseCrudState();
}

class _FirebaseCrudState extends State<FirebaseCrud> {
  TextEditingController nameController = TextEditingController();
  TextEditingController updateController = TextEditingController();
  final cloudDB = FirebaseFirestore.instance.collection('users');
  final userId = FirebaseAuth.instance.currentUser!.uid;
  bool editing = false;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    if(widget.opType == 'create'){
      return Scaffold(
        appBar: AppBar(
          title: Text('Sample Firebase ${widget.opType}'),
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  defaultField('Input your name', Icons.person, false, nameController, ''),
                  const SizedBox(height: 10.0,),
                  SizedBox(
                    height: 40.0,
                    child: ElevatedButton(
                        onPressed: (){
                          if(nameController.text.isNotEmpty){
                            addToDB(
                                context, nameController, name: nameController.text,
                                email: FirebaseAuth.instance.currentUser!.email!,
                                uid: userId,setState: setState);
                          }
                        }, child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.save_outlined),
                        Text('Create User'),
                      ],)),
                  )
                ],
              )),
        ),
      );
    }
    if(widget.opType == 'read'){
      return Scaffold(
        appBar: AppBar(
          title: Text('Sample Firebase ${widget.opType}'),
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: StreamBuilder(
            stream: cloudDB.where('ID', isEqualTo: userId).snapshots(),
            builder: (context, snap){
              if(snap.hasData){
                final newData = snap.data!.docs;
                if(newData.isNotEmpty){

                  return ListView.builder(
                    itemCount: newData.length,
                      itemBuilder: (context, index){
                        final userData = newData[index].data();
                        final userName = userData['User name'];
                        final userEmail = userData['Email'];
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: const Icon(Icons.person, size: 40.0,),
                              title: Text(userName),
                              subtitle: Text(userEmail),
                            ),
                          )
                        );
                      });
                }
              }
              if(snap.connectionState == ConnectionState.waiting){
                return const Center(
                  child: SpinKitFoldingCube(
                    color: Colors.orangeAccent,
                    size: 30.0,
                  ),
                );
              }
              if(snap.connectionState == ConnectionState.none){
                return const Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('No internet')
                    ],
                  ),
                );
              }
              return const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('No data found')
                  ],
                ),
              );
        }),
      );
    }
    if(widget.opType == 'delete'){
      return Scaffold(
        appBar: AppBar(
          title: Text('Sample Firebase ${widget.opType}'),
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: StreamBuilder(
            stream: cloudDB.where('ID', isEqualTo: userId).snapshots(),
            builder: (context, snap){
              if(snap.hasData){
                final newData = snap.data!.docs;
                if(newData.isNotEmpty){

                  return ListView.builder(
                      itemCount: newData.length,
                      itemBuilder: (context, index){
                        final userData = newData[index].data();
                        final userName = userData['User name'];
                        final userEmail = userData['Email'];
                        return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                leading: const Icon(Icons.person, size: 40.0,),
                                title: Text(userName),
                                subtitle: Text(userEmail),
                                trailing: IconButton(
                                  tooltip: 'Delete Record',
                                    onPressed: (){
                                      deleteRecord(context, userId: userId);
                                    }, icon: const Icon(Icons.delete_forever, color: Colors.red,)),
                              ),
                            )
                        );
                      });
                }
              }
              if(snap.connectionState == ConnectionState.waiting){
                return const Center(
                  child: SpinKitFoldingCube(
                    color: Colors.orangeAccent,
                    size: 30.0,
                  ),
                );
              }
              if(snap.connectionState == ConnectionState.none){
                return const Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('No internet')
                    ],
                  ),
                );
              }
              return const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('No data found')
                  ],
                ),
              );
            }),
      );
    }else{
      return Scaffold(
        appBar: AppBar(
          title: Text('Sample Firebase ${widget.opType}'),
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: StreamBuilder(
            stream: cloudDB.where('ID', isEqualTo: userId).snapshots(),
            builder: (context, snap){
              if(snap.hasData){
                final newData = snap.data!.docs;
                if(newData.isNotEmpty){

                  return ListView.builder(
                      itemCount: newData.length,
                      itemBuilder: (context, index){
                        final userData = newData[index].data();
                        final userName = userData['User name'];
                        final userEmail = userData['Email'];
                        return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    leading: const Icon(Icons.person, size: 40.0,),
                                    title: Text(userName),
                                    subtitle: Text(userEmail),
                                    trailing: IconButton(
                                        tooltip: 'Update Record',
                                        onPressed: (){
                                          setState(() {
                                            editing = true;
                                          });
                                        }, icon: const Icon(Icons.update, color: Colors.red,)),
                                  ),
                                  editing ? defaultField('New name', Icons.person_add_alt_outlined, false, updateController, '') : const SizedBox(),
                                  editing ? Container(
                                    width: w * 0.4,
                                    height: 60.0,
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevatedButton(onPressed: (){
                                      if(updateController.text.isNotEmpty){
                                        updateRecord(context, updateController, newName: updateController.text, userId: userId, setState: setState);
                                        setState(() {
                                          editing = false;
                                        });
                                      }
                                    }, child: const Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.save_outlined),
                                        SizedBox(width: 8.0,),
                                        Text('Save'),
                                      ],
                                    )),
                                  ) : const SizedBox()
                                ],
                              ),
                            )
                        );
                      });
                }
              }
              if(snap.connectionState == ConnectionState.waiting){
                return const Center(
                  child: SpinKitFoldingCube(
                    color: Colors.orangeAccent,
                    size: 30.0,
                  ),
                );
              }
              if(snap.connectionState == ConnectionState.none){
                return const Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('No internet')
                    ],
                  ),
                );
              }
              return const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('No data found')
                  ],
                ),
              );
            }),
      );
    }
  }
}
