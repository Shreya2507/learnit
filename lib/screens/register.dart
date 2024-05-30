import 'dart:developer';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _registerKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void createAccount() async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (name == '' || email == '' || password == '' || confirmPassword == '') {
      log("Please fill all details");
    } else if (password != confirmPassword) {
      log("Passwords do not match");
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      log("Email is invalid");
    } else if (name.length < 4) {
      log("Name should be more than 4 characters");
    } else {
      try {
        //CREATE NEW ACCOUNT
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        log("User created");
        if (userCredential.user != null) {
          Navigator.pushNamed(context, '/registerSuccess');
          AudioPlayer().play(AssetSource('onLogin.mp3'));
          userCredential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password);

          log("Logged in");
        }
      } on FirebaseAuthException catch (e) {
        log(e.code.toString());
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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
                  'Email is already registered',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            )));
      }
    }
  }

  bool showPass = true;
  bool showConfirmPass = true;

  void togglePass() {
    showPass = !showPass;
  }

  void toggleConfirmPass() {
    showConfirmPass = !showConfirmPass;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 60.0),
          child: Text(
            "Create a Profile",
            style: TextStyle(color: Color.fromRGBO(77, 120, 31, 1)),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Image.asset(
                'assets/images/register.png',
                height: 180,
              ),
              SizedBox(
                height: 10,
              ),
              Form(
                key: _registerKey,
                child: SizedBox(
                  width: 360,
                  child: TextFormField(
                    controller: nameController,
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
                      hintText: "Name",
                      hintStyle: TextStyle(
                        fontSize: 20,
                      ),
                      prefixIcon: IconButton(
                          onPressed: () {}, icon: Icon(Icons.person)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      if (value.length < 4) {
                        return 'Name should be at least 4 characters long';
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
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
                    prefixIcon:
                        IconButton(onPressed: () {}, icon: Icon(Icons.email)),
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
                  obscureText: showPass,
                  controller: passwordController,
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
                      hintText: "Password",
                      hintStyle: TextStyle(
                        fontSize: 20,
                      ),
                      prefixIcon:
                          IconButton(onPressed: () {}, icon: Icon(Icons.lock)),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              togglePass();
                            });
                          },
                          icon: Padding(
                            padding:
                                const EdgeInsets.only(right: 20.0, left: 20.0),
                            child: Icon(Icons.remove_red_eye),
                          ))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (!RegExp(
                            r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$')
                        .hasMatch(value)) {
                      //Minimum eight characters, at least one uppercase letter, one lowercase letter, one number and one special character
                      return 'Password should be atleast 8 characters';
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
                  obscureText: showConfirmPass,
                  controller: confirmPasswordController,
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
                      hintText: "Confirm Password",
                      hintStyle: TextStyle(
                        fontSize: 20,
                      ),
                      prefixIcon:
                          IconButton(onPressed: () {}, icon: Icon(Icons.lock)),
                      suffixIcon: IconButton(
                          onPressed: () {
                            toggleConfirmPass();
                          },
                          icon: Padding(
                            padding:
                                const EdgeInsets.only(right: 20.0, left: 20.0),
                            child: Icon(Icons.remove_red_eye),
                          ))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != passwordController.text) {
                      //Minimum eight characters, at least one uppercase letter, one lowercase letter, one number and one special character
                      return 'Passwords do not match';
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
                    _registerKey.currentState == null ||
                            !_registerKey.currentState!.validate()
                        ? null
                        : createAccount();
                  },
                  child: Text(
                    "SIGN UP",
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
