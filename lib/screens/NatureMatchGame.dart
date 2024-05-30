import 'dart:developer';
import 'dart:math' hide log;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:audioplayers/audioplayers.dart';

class NatureMatchGameAnimals extends StatefulWidget {
  const NatureMatchGameAnimals({super.key});

  @override
  State<NatureMatchGameAnimals> createState() => _NatureMatchGameAnimalsState();
}

class _NatureMatchGameAnimalsState extends State<NatureMatchGameAnimals> {
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
    Image.asset(
      'assets/dragGame/Tomato.png',
      height: 80,
      width: 80,
    ): 'Tomate',
    // Image.asset(
    //   'assets/dragGame/Fried Eggs.png',
    //   height: 80,
    //   width: 80,
    // ): 'Ei',
    // Image.asset(
    //   'assets/dragGame/Pizza.png',
    //   height: 100,
    //   width: 100,
    // ): 'Pizza',
    // Image.asset('assets/dragGame/Cake.png'): 'Kuchen',
    Image.asset(
      'assets/dragGame/Pear.png',
      height: 80,
      width: 80,
    ): 'Birne',
    Image.asset(
      'assets/dragGame/Carrot.png',
      height: 80,
      width: 80,
    ): 'Karotte',
    // Image.asset('assets/dragGame/Pineapple.png'): 'Ananas',
    // Image.asset('assets/dragGame/Watermelon.png'): 'Wassermelone',
    Image.asset(
      'assets/dragGame/Mushroom.png',
      height: 80,
      width: 80,
    ): 'Pilz',
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
              "Put the objects in the correct boxes !",
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
                    return Draggable<Image>(
                        data: emoji,
                        child: LangImage(
                            emoji: score[choices[emoji]] == true
                                ? Image.asset(
                                    'assets/dragGame/correct.png',
                                    width: 60,
                                  )
                                : emoji),
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
                onPressed: () {
                  // levelOneComplete = true;
                  showDataAlert();
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
    return DragTarget<Image>(
      builder: (BuildContext context, List candidateData, List rejectedData) {
        if (score[choices[emoji]] == true) {
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
                Text('${choices[emoji]}'),
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
          score[choices[emoji]] = true;
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

  final Image emoji;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
          alignment: Alignment.center,
          height: 180,
          width: 180,
          padding: EdgeInsets.all(10),
          child: emoji),
    );
  }
}
