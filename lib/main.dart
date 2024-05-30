import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learnit/gameScreens/FlashcardScreen.dart';
import 'package:learnit/gameScreens/MyHomePage.dart';
import 'package:learnit/gameScreens/QuizProvider.dart';
import 'package:learnit/gameScreens/word_match_provider.dart';
import 'package:learnit/screens/AnimalMatchGame%20.dart';
import 'package:learnit/screens/ForgotPassword.dart';
import 'package:learnit/screens/daily_streak.dart';
import 'package:learnit/screens/dashboard.dart';

import 'package:learnit/screens/getStarted.dart';
import 'package:learnit/screens/login.dart';
import 'package:learnit/screens/NatureMatchGame.dart';
import 'package:learnit/screens/native-language-selector.dart';
import 'package:learnit/screens/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:learnit/screens/register_success.dart';
import 'package:provider/provider.dart';

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
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WordMatchProvider()),
        ChangeNotifierProvider(create: (_) => QuizProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/getStarted': (context) => GetStarted(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/registerSuccess': (context) => RegisterSuccess(),
        '/dashboard': (context) => Dashboard(),
        '/forgotPassword': (context) => ForgotPassword(),

        '/languageSelector': (context) => LanguageSelector(),
        '/dailyStreak': (context) => DailyStreak(),

        '/myHomePage': (context) => MyHomePage(),
        '/natureMatchGame': (context) => NatureMatchGameAnimals(),
        '/animalMatchGameAnimals': (context) => AnimalMatchGame(),
        // '/cityMatchGameAnimals': (context) => CityMatchGameAnimals(),
        '/natureGames': (context) => FlashcardScreen(category: 'Basics'),
        '/animalGames': (context) => FlashcardScreen(category: 'Food'),

        // WelcomeScreen(),
      },
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      // home: HomePage(),

      // IF USER LOGGED IN
      home: (FirebaseAuth.instance.currentUser != null)
          ? Dashboard()
          : GetStarted(),
    );
  }
}
