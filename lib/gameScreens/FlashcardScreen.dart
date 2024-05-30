import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:learnit/gameScreens/QuizScreen.dart';
import 'package:learnit/gameScreens/data.dart';

class FlashcardScreen extends StatefulWidget {
  final String category;
  const FlashcardScreen({required this.category});

  @override
  State<FlashcardScreen> createState() =>
      _FlashcardScreenState(category: category);
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  final String category;
  _FlashcardScreenState({required this.category});

  var _currItem = 0;
  late List<Map<String, String>> jsonData;
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  TextStyle textStyle = TextStyle(
      color: Colors.green.shade900, fontSize: 20, fontWeight: FontWeight.w600);

  @override
  void initState() {
    super.initState();
    jsonData = (data[this.category] as List).cast<Map<String, String>>();
  }

  void _nextCard() {
    setState(() {
      if (_currItem < jsonData.length - 1) {
        _currItem++;
        cardKey.currentState?.toggleCardWithoutAnimation();
      } else {
        // Navigate to the next exercise
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Quizscreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Color(0xffA7D397),
        appBar: AppBar(
          centerTitle: true,
          // title: Text("Learning Made Easy"),
          backgroundColor: Color.fromRGBO(131, 193, 60, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15),
            ),
          ),
          elevation: 5,
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              Text(
                "Guess the Word and Flip!",
                style: TextStyle(fontSize: 30, color: Colors.green.shade900),
              ),
              SizedBox(height: 20),
              SizedBox(height: 25),
              SizedBox(
                width: 300,
                height: 300,
                child: FlipCard(
                  key: cardKey,
                  side: CardSide.FRONT,
                  direction: FlipDirection.HORIZONTAL,
                  front: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    elevation: 7,
                    shadowColor: Colors.grey,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: Text(jsonData[_currItem]["word"] ?? "",
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.black, fontSize: 30)),
                      ),
                    ),
                  ),
                  back: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    elevation: 7,
                    shadowColor: Colors.grey,
                    color: const Color.fromARGB(255, 187, 187, 187),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: Text(jsonData[_currItem]["result"] ?? "",
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.white, fontSize: 30)),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _nextCard,
                child: Text(
                  "Next",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(131, 193, 60, 1),
                  shadowColor: Color.fromRGBO(124, 194, 49, 1),
                  elevation: 3,
                ),
              ),
            ])));
  }
}

class NextExerciseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Next Exercise'),
      ),
      body: Center(
        child: Text('This is the next exercise screen.'),
      ),
    );
  }
}
