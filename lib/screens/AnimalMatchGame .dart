import 'dart:developer';
import 'dart:math' hide log;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:learnit/screens/animals.dart';

class AnimalMatchGame extends StatefulWidget {
  const AnimalMatchGame({super.key});

  @override
  State<AnimalMatchGame> createState() => _AnimalMatchGameState();
}

class _AnimalMatchGameState extends State<AnimalMatchGame> {
  // final _audioPlayer = AudioPlayer();
  // AudioCache _audioPlayer = AudioCache();

  // void logout() async {
  //   await FirebaseAuth.instance.signOut();
  //   //removes all previous screens from stack
  //   Navigator.popUntil(context, (route) => route.isFirst);
  //   //keep only dashboard screen , we can't go back to login screen from this
  //   Navigator.pushReplacementNamed(context, '/');
  // }

  final Map<String, bool> score = {};

  final Map choices = {
    '🐮': 'Kuh',
    '🐈': 'Katze',
    '🐒': 'Affe',
    '🐕': 'Hund',
    // Image.asset(
    //   'assets/dragGame/Pizza.png',
    //   height: 100,
    //   width: 100,
    // ): 'Pizza',
    // Image.asset('assets/dragGame/Cake.png'): 'Kuchen',

    // Image.asset('assets/dragGame/Pineapple.png'): 'Ananas',
    // Image.asset('assets/dragGame/Watermelon.png'): 'Wassermelone',
    // Image.asset('assets/dragGame/Mushroom.png'): 'Pilz',
    // Image.asset('assets/dragGame/Donut.png'): 'Krapfen',
    // Image.asset('assets/dragGame/Carrot.png'): 'Trauben'
  };

  int seed = 0; //to shuffle

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Score ${score.length}/4'),
          backgroundColor: Color.fromRGBO(131, 193, 60, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15),
            ),
          ),
          actions: [
            Padding(
                padding: const EdgeInsets.all(5.0),
                child: IconButton(
                    onPressed: () {
                      setState(() {
                        score.clear();
                        seed++;
                      });
                    },
                    icon: Padding(
                      padding: const EdgeInsets.only(right: 18.0),
                      child: Icon(
                        Icons.refresh,
                        size: 27,
                        color: Colors.black,
                      ),
                    )))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            // IconButton(
            //   onPressed: () {
            //     // logout();
            //   },
            //   icon: Icon(Icons.logout),
            //   iconSize: 40,
            // ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Put the animals in the correct boxes !",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: choices.keys.map((emoji) {
                    return Draggable<String>(
                        data: emoji,
                        child: LangImage(
                            emoji: score[emoji] == true ? "✅" : emoji),
                        feedback: LangImage(emoji: emoji),
                        childWhenDragging: LangImage(emoji: emoji)
                        // Container(
                        //   height: 100,
                        //   width: 100,
                        //   // child: Text("?"),
                        // ),
                        );
                  }).toList(),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: choices.keys
                      .map((emoji) => _buildDragTarget(emoji))
                      .toList()
                    ..shuffle(Random(seed)),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 200,
              height: 55,
              child: ElevatedButton(
                onPressed: () async {
                  // levelOneComplete = true;
                  showDataAlert();
                  await Future.delayed(Duration(seconds: 2));
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AnimalChallengePage()),
                  );
                },
                child: Text(
                  "Done",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(131, 193, 60, 1),
                  shadowColor: Color.fromRGBO(124, 194, 49, 1),
                  elevation: 3,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ]),
        ));
  }

  showDataAlert() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  20.0,
                ),
              ),
            ),
            contentPadding: EdgeInsets.only(
              top: 10.0,
            ),
            title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                "Well Done!",
                style: TextStyle(
                    fontSize: 24.0, color: Color.fromRGBO(49, 90, 1, 1)),
              ),
            ]),
          );
        });
  }

  Widget _buildDragTarget(emoji) {
    return DragTarget<String>(
      builder: (BuildContext context, List candidateData, List rejectedData) {
        if (score[emoji] == true) {
          return Container(
            margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            decoration: BoxDecoration(
              border: Border.all(
                width: 5,
                color: Color.fromRGBO(102, 193, 60, 1),
              ),
            ),
            // color: Colors.blue,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${choices[emoji]}',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                    height: 100, width: 100, child: LangImage(emoji: emoji)),
              ],
            ),
            height: 160,
            width: 160,
          );
        } else {
          return Container(
            margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            decoration: BoxDecoration(
              border: Border.all(
                width: 3,
                color: Colors.black,
              ),
            ),
            child: Center(
              child: Text(
                '${choices[emoji]}',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            height: 160,
            width: 160,
          );
        }
      },
      onWillAcceptWithDetails: (data) => data.data == emoji,
      onAcceptWithDetails: (data) {
        // if (data == img) {
        setState(() {
          score[emoji] = true;
          log("dropped correctly");
          AudioPlayer().play(AssetSource('success.mp3'));
          // _audioPlayer.load('assets/audios/success.mp3');
        });

        // }
      },
      onLeave: (data) {},
    );
  }
}

class LangImage extends StatelessWidget {
  const LangImage({super.key, required this.emoji});

  final String emoji;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
          alignment: Alignment.center,
          height: 180,
          width: 180,
          padding: EdgeInsets.all(10),
          child: Text(
            emoji,
            style: TextStyle(fontSize: 60),
          )),
    );
  }
}
