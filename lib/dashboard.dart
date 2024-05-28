import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:audioplayers/audioplayers.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final _audioPlayer = AudioPlayer();

  void logout() async {
    await FirebaseAuth.instance.signOut();
    //removes all previous screens from stack
    Navigator.popUntil(context, (route) => route.isFirst);
    //keep only dashboard screen , we can't go back to login screen from this
    Navigator.pushReplacementNamed(context, '/login');
  }

  final Map<String, bool> score = {};

  final Map choices = {
    'tomato': 'Tomate',
    'egg': 'Ei',
    // 'pizza': 'Pizza',
    // 'cake': 'Kuchen',
    // 'pear': 'Birne',
    // 'carrot': 'Karotte',
    // 'pineapple': 'Ananas',
    // 'watermelon': 'Wassermelone',
    // 'mushroom': 'Pilz',
    // 'donut': 'Krapfen',
    // 'grapes': 'Trauben'
  };

  int seed = 0; //to shuffle

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Score ${score.length}'),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                score.clear();
                seed++;
              });
            }),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Text(
                  "DASHBOARD",
                  style: TextStyle(fontSize: 30),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              IconButton(
                onPressed: () {
                  logout();
                },
                icon: Icon(Icons.logout),
                iconSize: 40,
              ),
              SizedBox(
                height: 50,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: choices.keys.map((img) {
                      return Draggable<String>(
                        data: img,
                        child: LangImage(image: score[img] == true ? '✅' : img),
                        feedback: LangImage(image: img),
                        childWhenDragging: Container(
                          height: 50,
                          width: 50,
                        ),
                      );
                    }).toList(),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: choices.keys
                          .map((img) => _buildDragTarget(img))
                          .toList()
                        ..shuffle(Random(seed))),
                ],
              )
            ],
          ),
        ));
  }

  Widget _buildDragTarget(img) {
    return DragTarget<String>(
      builder: (BuildContext context, List candidateData, List rejectedData) {
        if (score[img] == true) {
          return Container(
            color: Colors.blue,
            child: Text("Correct"),
            height: 50,
            width: 50,
          );
        } else {
          return Container(
            child: Text('${choices[img]}'),
            height: 50,
            width: 50,
          );
        }
      },
      onWillAcceptWithDetails: (data) => data == img,
      onAcceptWithDetails: (data) {
        setState(() {
          score[img] = true;
        });

        _audioPlayer.play(AssetSource('assets/audios/success.mp3'));
      },
      onLeave: (data) {},
    );
  }
}

class LangImage extends StatelessWidget {
  const LangImage({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        alignment: Alignment.center,
        height: 50,
        width: 50,
        padding: EdgeInsets.all(10),
        child: Text(
          image,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
