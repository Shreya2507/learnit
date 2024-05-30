import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:learnit/screens/animals.dart';
import 'package:learnit/screens/city.dart';
import 'package:learnit/screens/nature.dart';
import 'package:learnit/screens/settings.dart';

class Dash extends StatefulWidget {
  const Dash({super.key});

  @override
  State<Dash> createState() => _DashState();
}

class _DashState extends State<Dash> {
  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hi Julia",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Today is a good day\nto learn something new!",
                            style: TextStyle(
                              color: Colors.black54,
                              wordSpacing: 2.5,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Column(
                      children: [
                        Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            color: Colors.purple[300],
                            borderRadius: BorderRadius.circular(35.0),
                          ),
                          child: Image.asset(
                            "assets/dashboard/profile.png",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Categories",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        "See All",
                        style: TextStyle(
                            fontSize: 16,
                            color: const Color.fromARGB(255, 51, 103, 146)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                _buildDashboardCard(
                  title: 'Animals',
                  subtitle: '15/15',
                  image: Icons.pets,
                  color: const Color.fromARGB(255, 142, 210, 241),
                  status: 'View',
                  locked: false,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AnimalChallengePage()),
                    );
                  },
                ),
                _buildDashboardCard(
                  title: 'Fruits and Veggies',
                  subtitle: '0/95',
                  image: Icons.restaurant,
                  color: const Color.fromARGB(255, 240, 141, 134),
                  status: 'Start',
                  locked: false,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NatureChallengePage()),
                    );
                  },
                ),
                _buildDashboardCard(
                  title: 'In the City',
                  subtitle: '9/35',
                  image: Icons.location_city,
                  color: const Color.fromARGB(255, 111, 213, 114),
                  status: 'locked',
                  locked: true,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CityChallengePage()),
                    );
                  },
                ),
                _buildDashboardCard(
                  title: 'Nature',
                  subtitle: '0/15',
                  image: Icons.nature,
                  color: Color.fromARGB(255, 249, 211, 105),
                  status: 'locked',
                  locked: true,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CityChallengePage()),
                    );
                  },
                ),
                _buildDashboardCard(
                  title: 'Vocabulary',
                  subtitle: '0/15',
                  image: Icons.pets,
                  color: const Color.fromARGB(255, 142, 210, 241),
                  status: 'View',
                  locked: false,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AnimalChallengePage()),
                    );
                  },
                ),
                _buildDashboardCard(
                  title: 'Grammar',
                  subtitle: '0/95',
                  image: Icons.restaurant,
                  color: const Color.fromARGB(255, 240, 141, 134),
                  status: 'Start',
                  locked: false,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NatureChallengePage()),
                    );
                  },
                ),
                _buildDashboardCard(
                  title: 'Pronounciation',
                  subtitle: '0/35',
                  image: Icons.location_city,
                  color: const Color.fromARGB(255, 111, 213, 114),
                  status: 'locked',
                  locked: true,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CityChallengePage()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardCard({
    required String title,
    required String subtitle,
    required IconData image,
    required Color color,
    required String status,
    required bool locked,
    required Function() onTap,
  }) {
    bool isSelected = false;
    return GestureDetector(
      onTap: () {
        if (!locked) {
          setState(() {
            isSelected = !isSelected;
          });
          onTap(); //onTap function
        }
      },
      child: Container(
        height: 120,
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
              color:
                  Color.fromARGB(255, 154, 154, 154)), // Set border color here
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4.0,
              spreadRadius: 5.0,
              offset: Offset(2.0, 2.0),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Icon(image, size: 60, color: Colors.white),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      subtitle,
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                  ],
                ),
              ),
              locked
                  ? Icon(Icons.lock, color: Colors.white)
                  : Text(
                      status,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
