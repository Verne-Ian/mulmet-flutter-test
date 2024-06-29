import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:mulmet_flutter_test/widgets/custom_widgets.dart';

class WordGame extends StatefulWidget {
  const WordGame({super.key});

  @override
  State<WordGame> createState() => _WordGameState();
}

class _WordGameState extends State<WordGame> {
  TextEditingController wordController = TextEditingController();
  final cloudFirestore = FirebaseFirestore.instance;
  int currentScore = 0;
  int gamesWon = 0;
  int gamesLost = 0;

  // This function is being used to check the entered word.
  Future<void> checkWord() async {
    final String wordToCheck = wordController.text;
    if (wordToCheck.isNotEmpty) {
      try {
        final doc = await cloudFirestore.collection('game').doc('game_words').get();
        final List<dynamic> wordsArray = doc['words'];

        // Check if the word is in the array
        if (wordsArray.contains(wordToCheck)) {
          setState(() {
            currentScore = currentScore + 1;
            gamesWon = gamesWon + 1;
            wordController.text = '';
          });
          showDialog(context: context, builder: (context){
            return const AlertDialog(
              title: Text('+1 Hooray! You won'),
              icon: Icon(Icons.tag_faces_sharp, color: Colors.green,),
            );
          });
        } else {
          setState(() {
            gamesLost = gamesLost + 1;
            wordController.text = 'Try again';
          });
          showDialog(context: context, builder: (context){
            return const AlertDialog(
              title: Text('Sorry! You Lost'),
              icon: Icon(Icons.highlight_remove_outlined, color: Colors.red,),
            );
          });
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error checking word: $e');
        }
      }
    } else {
      setState(() {
        wordController.text = 'Enter a word';
        wordController.text = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Word Game'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Current Score: $currentScore'),
              const SizedBox(height: 10.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Games won: $gamesWon'),
                  Text('Games lost: $gamesLost')
                ],
              ),
              defaultField('Guess the word', Icons.type_specimen_outlined, false, wordController, ''),
              const SizedBox(height: 10.0,),
              TextButton(onPressed: checkWord, child: const Text('Check')),
            ],
          ),
        ),
      ),
    );
  }
}
