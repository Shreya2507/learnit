import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learnit/screens/dashboard.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      color: Color.fromARGB(255, 240, 241, 244),
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              'Khyati Dhawan',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 20),
            ),
            accountEmail: Text(
              'khyati21csu047@ncuindia.edu',
              style: TextStyle(color: Colors.white),
            ),
            currentAccountPicture: Image.asset(
              'assets/dashboard/profile.png',
            ),
            decoration: BoxDecoration(
              color: Color.fromRGBO(113, 168, 51, 1),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text(
              'Home',
              style: TextStyle(fontSize: 20),
            ),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Dashboard()));
            },
          ),
          ListTile(
            leading: Icon(Icons.save_sharp),
            title: Text(
              'Saved Locations',
              style: TextStyle(fontSize: 20),
            ),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Dashboard()));
            },
          ),
          ListTile(
            leading: Icon(Icons.add_box_rounded),
            title: Text(
              'New Location',
              style: TextStyle(fontSize: 20),
            ),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Dashboard()));
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text(
              'Settings',
              style: TextStyle(fontSize: 20),
            ),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Dashboard()));
            },
          ),
        ],
      ),
    ));
  }
}
