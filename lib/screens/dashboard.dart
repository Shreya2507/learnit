import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learnit/screens/daily_streak.dart';
import 'package:learnit/screens/dash.dart';

import 'package:learnit/screens/menuDrawer.dart';
import 'package:learnit/screens/personal-info.dart';
import 'package:learnit/screens/settings.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    Dash(),
    DailyStreak(),
    ProfileInfoPage(),
    SettingsPage(),
  ];

  void _onNavBarTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(131, 193, 60, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
        iconTheme: IconThemeData(color: Color.fromARGB(255, 2, 1, 1)),
        title: const Text(' ',
            style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
        actions: [
          // Padding(
          //     padding: const EdgeInsets.all(5.0),
          //     child: IconButton(
          //         onPressed: () {
          //           logout();
          //         },
          //         icon: Icon(
          //           Icons.logout,
          //           color: Color.fromARGB(255, 0, 0, 0),
          //         )))
        ],
      ),
      // drawer: const MenuDrawer(),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onNavBarTap,
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Progress',
            icon: Icon(Icons.beenhere),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon(Icons.person),
          ),
          BottomNavigationBarItem(
            label: 'Settings',
            icon: Icon(Icons.settings),
          ),
        ],
        fixedColor: Colors.indigo[200],
        //backgroundColor: Color.fromARGB(255, 27, 1, 42),
        backgroundColor: Colors.yellow[600],
        unselectedItemColor: const Color.fromARGB(255, 2, 1, 1),
        selectedIconTheme: IconThemeData(
            color: Color.fromRGBO(
                131, 193, 60, 1)), // Change the color of selected icon
      ),
    );
  }
}
