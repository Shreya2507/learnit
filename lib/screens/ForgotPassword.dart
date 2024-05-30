import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
              ),
              Text(
                "Enter your email and we will send a verification link !",
                style: TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                width: 360,
                child: TextFormField(
                  controller: emailController,
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
                height: 40,
              ),
              SizedBox(
                width: 340,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          backgroundColor: Color.fromARGB(149, 25, 25, 25),
                          content: Row(
                            children: [
                              Icon(
                                Icons.done,
                                color: Colors.green[300],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Link sent. Check your email!',
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          )),
                    );
                  },
                  child: Text(
                    "Send verification link",
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
