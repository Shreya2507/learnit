import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email == '' || password == '') {
      log("Please fill all details");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Color.fromARGB(149, 25, 25, 25),
            content: Row(
              children: [
                Icon(
                  Icons.warning,
                  color: Colors.amberAccent,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Please fill email and password',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            )),
      );
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      log("Email is invalid");
    } else {
      try {
        //LOGIN
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);

        log("Logged in");
        CollectionReference user =
            FirebaseFirestore.instance.collection('learnitUsers');
        Stream abc = user.doc(email).snapshots();

        AudioPlayer().play(AssetSource('onLogin.mp3'));
        if (userCredential.user != null) {
          //removes all previous screens from stack
          Navigator.popUntil(context, (route) => route.isFirst);
          //keep only dashboard screen , we can't go back to login screen from this
          Navigator.pushReplacementNamed(context, '/dailyStreak');
        }
      } on FirebaseAuthException catch (e) {
        log(e.code.toString());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Color.fromARGB(149, 25, 25, 25),
              content: Row(
                children: [
                  Icon(
                    Icons.warning,
                    color: Colors.amberAccent,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Login failed. Please try again!',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              )),
        );
      }
    }
  }

  bool showPassword = true;

  void togglePassword() {
    showPassword = !showPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: Padding(
          //   padding: const EdgeInsets.only(left: 100.0),
          //   child: Text(
          //     "Sign In",
          //     style: TextStyle(color: Color.fromRGBO(77, 120, 31, 1)),
          //   ),
          // ),
          ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Image.asset(
                'assets/images/register.png',
                height: 180,
              ),
              SizedBox(
                height: 30,
              ),
              Form(
                  key: _loginKey,
                  child: Column(
                    children: [
                      SizedBox(
                        width: 360,
                        child: TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(25.0),
                              ),
                              borderSide: BorderSide(
                                width: 3,
                                color: Color.fromRGBO(131, 193, 60, 1),
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(25.0),
                              ),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            fillColor: Color.fromARGB(11, 22, 22, 22),
                            filled: true,
                            hintText: "Email",
                            hintStyle: TextStyle(
                              fontSize: 20,
                            ),
                            prefixIcon: IconButton(
                                onPressed: () {}, icon: Icon(Icons.email)),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                .hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 360,
                        child: TextFormField(
                          controller: passwordController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(25.0),
                                ),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(25.0),
                                ),
                                borderSide: BorderSide(
                                  width: 3,
                                  color: Color.fromRGBO(131, 193, 60, 1),
                                ),
                              ),
                              fillColor: Color.fromARGB(11, 22, 22, 22),
                              filled: true,
                              hintText: "Password",
                              hintStyle: TextStyle(
                                fontSize: 20,
                              ),
                              prefixIcon: IconButton(
                                  onPressed: () {}, icon: Icon(Icons.lock)),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      togglePassword();
                                    });
                                  },
                                  icon: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 20.0, left: 20.0),
                                    child: Icon(Icons.remove_red_eye),
                                  ))),
                          obscureText: showPassword,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      SizedBox(
                        width: 340,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_loginKey.currentState == null &&
                                _loginKey.currentState!.validate()) {}
                            login();
                          },
                          child: Text(
                            "LOG IN",
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
                      GestureDetector(
                        child: Text(
                          "Forgot the password?",
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: Colors.black54),
                        ),
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, '/forgotPassword');
                        },
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
