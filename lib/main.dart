import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learnit/screens/ForgotPassword.dart';
import 'package:learnit/screens/dashboard.dart';
import 'package:learnit/screens/home.dart';
import 'package:learnit/screens/login.dart';
import 'package:learnit/screens/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:learnit/screens/register_success.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey:
          "AIzaSyAOcU7bgaiww1ZifLuSepEw2G0xYNgt25s", // paste your api key here
      appId:
          "1:376713061512:android:3c74b5c93a8627afbeeb3d", //paste your app id here
      messagingSenderId: "376713061512", //paste your messagingSenderId here
      projectId: "learnit-2f459", //paste your project id here
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        // '/': (context) => HomePage(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/registerSuccess': (context) => RegisterSuccess(),
        '/dashboard': (context) => Dashboard(),
        '/forgotPassword': (context) => ForgotPassword(),
      },
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      // home: HomePage(),

      // IF USER LOGGED IN
      home: (FirebaseAuth.instance.currentUser != null)
          ? Dashboard()
          : HomePage(),
    );
  }
}
