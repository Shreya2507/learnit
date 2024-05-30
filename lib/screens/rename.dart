import 'package:flutter/material.dart';
import 'package:learnit/gameScreens/MyHomePage.dart';

class AnimalChallengePage extends StatefulWidget {
  const AnimalChallengePage({Key? key}) : super(key: key);

  @override
  State<AnimalChallengePage> createState() => _AnimalChallengePageState();
}

class _AnimalChallengePageState extends State<AnimalChallengePage> {
  Color borderColor = Colors.transparent;

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
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Challenges",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Conquer and Master challenges\nacross different levels.",
                          style: TextStyle(
                            color: Colors.black54,
                            wordSpacing: 2.5,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Spacer(
                      flex: 3,
                    ),
                    Column(
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Image.asset(
                            "assets/dashboard/goal.png",
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
                      "Levels",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // InkWell(
                    //   onTap: () {},
                    //   child: Text(
                    //     "See All",
                    //     style: TextStyle(fontSize: 16, color: Colors.blue[100]),
                    //   ),
                    // ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                _buildDashboardCard(
                  title: 'Level 1',
                  subtitle: 'Beginners',
                  image: Icons.flag,
                  color: const Color.fromARGB(255, 142, 210, 241),
                  status: 'View',
                  locked: false,
                  onTap: () {
                    Navigator.pushNamed(context, '/matchGameAnimals');
                  },
                ),
                _buildDashboardCard(
                  title: 'Level 2',
                  subtitle: 'Intermediate',
                  image: Icons.directions_run,
                  color: const Color.fromARGB(255, 111, 213, 114),
                  status: 'Next',
                  locked: false,
                  onTap: () {
                    print('In the City card tapped');
                    setState(() {
                      borderColor = const Color.fromARGB(255, 111, 213,
                          114); // Change border color when tapped
                    });
                  },
                ),
                _buildDashboardCard(
                  title: 'Level 3',
                  subtitle: 'hard ',
                  image: Icons.lightbulb_outline,
                  color: Color.fromARGB(255, 249, 211, 105),
                  status: 'Next',
                  locked: false,
                  onTap: () {
                    print('Alphabet card tapped');
                  },
                ),
                _buildDashboardCard(
                  title: 'Level 4',
                  subtitle: '0/95',
                  image: Icons.nature,
                  color: const Color.fromARGB(255, 240, 141, 134),
                  status: 'Start',
                  locked: true,
                  onTap: () {
                    print('Nature card tapped');
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
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 120,
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: borderColor), // Set border color here
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
