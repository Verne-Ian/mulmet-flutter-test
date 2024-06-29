import 'package:flutter/material.dart';
import 'package:mulmet_flutter_test/interface/firebase_crud.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    return Container(
      width: w * 0.7,
      constraints: const BoxConstraints(maxWidth: 480),
      child: Scaffold(
        body: SafeArea(
          child: Drawer(
            width: w * 0.7,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  tileColor: Colors.orangeAccent.shade100,
                  selectedTileColor: Colors.orangeAccent,
                  title: const Text('Firebase Create Sample'),
                  leading: const Icon(Icons.create, color: Colors.green,),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const FirebaseCrud(opType: 'create')));
                  },
                ),
                ListTile(
                  tileColor: Colors.orangeAccent.shade100,
                  selectedTileColor: Colors.orangeAccent,
                  title: const Text('Firebase Read Sample'),
                  leading: const Icon(Icons.read_more, color: Colors.blue,),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const FirebaseCrud(opType: 'read')));
                    }
                ),
                ListTile(
                  tileColor: Colors.orangeAccent.shade100,
                  selectedTileColor: Colors.orangeAccent,
                  title: const Text('Firebase Update Sample'),
                  leading: const Icon(Icons.update, color: Colors.yellow,),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const FirebaseCrud(opType: 'update')));
                    }
                ),
                ListTile(
                  tileColor: Colors.orangeAccent.shade100,
                  selectedTileColor: Colors.orangeAccent,
                  title: const Text('Firebase Delete Sample'),
                  leading: const Icon(Icons.delete_forever, color: Colors.red,),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const FirebaseCrud(opType: 'delete')));
                    }
                ),
              ],
            ),
          ),
        ),
        bottomSheet: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: ElevatedButton(onPressed: (){}, child: const Text("Sign Out")))
                ],
              ),
              const SizedBox(height: 10.0,),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: ElevatedButton(onPressed: (){}, child: const Text("Exit App")))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
