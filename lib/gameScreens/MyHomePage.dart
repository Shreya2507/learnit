import 'package:flutter/material.dart';
import 'package:learnit/gameScreens/FlashcardScreen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  // final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // centerTitle: true,
          // title: Text(widget.title),
          ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 20),
              Text(
                "What you want to learn today? ????????",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
              SizedBox(height: 20),
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 1.0,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  padding: EdgeInsets.all(10.0),
                  children: <Widget>[
                    _buildCard("Food"),
                    _buildCard("Basics"),
                    _buildCard("Travel"),
                    _buildCard("School"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(String text) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => FlashcardScreen(category: text),
        ));
      },
      child: Container(
        height: 200,
        width: 200,
        decoration: BoxDecoration(
            color: Color(0xffA7D397),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
