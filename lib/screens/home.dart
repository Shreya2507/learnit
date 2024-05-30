import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/cactus.png',
                height: 300,
              ),
              Text(
                "LearnIt",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              Text(
                "Your language learning buddy",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 60,
              ),
              SizedBox(
                width: 340,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed((context), '/register');
                  },
                  child: Text(
                    "GET STARTED",
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
              SizedBox(
                width: 340,
                height: 55,
                child: OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed((context), '/login');
                    },
                    child: Text(
                      "LOG IN",
                      style: TextStyle(
                        color: Color.fromRGBO(131, 193, 60, 1),
                        fontSize: 20,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                          width: 2.0, color: Color.fromRGBO(131, 193, 60, 1)),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
