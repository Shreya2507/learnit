import 'package:flutter/material.dart';
import 'package:learnit/screens/login.dart';

class RegisterSuccess extends StatefulWidget {
  const RegisterSuccess({super.key});

  @override
  State<RegisterSuccess> createState() => _RegisterSuccessState();
}

class _RegisterSuccessState extends State<RegisterSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Text(
                "Success!",
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(77, 120, 31, 1)),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Welcome aboard",
                style: TextStyle(fontSize: 25),
              ),
              SizedBox(
                height: 60,
              ),
              Image.asset(
                'assets/images/register.png',
                height: 250,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Just a few more steps",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "so we can get you settled in",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 40,
              ),
              SizedBox(
                width: 220,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: Text(
                    "Continue",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(131, 193, 60, 1),
                    shadowColor: Color.fromRGBO(124, 194, 49, 1),
                    elevation: 3,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
