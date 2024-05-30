import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learnit/screens/personal-info.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void logout() async {
      await FirebaseAuth.instance.signOut();
      //removes all previous screens from stack
      // Navigator.popUntil(context, (route) => route.isFirst);
      //keep only dashboard screen , we can't go back to login screen from this
      Navigator.pushReplacementNamed(context, '/getStarted');
    }

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Text('Settings'),
        ),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Personal Info'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileInfoPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notifications'),
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => NotificationsPage()),
              // );
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('General'),
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => GeneralPage()),
              // );
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Log Out'),
            onTap: () {
              // Implement your log out functionality here
              // For demonstration, we just show a dialog
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Log Out'),
                  content: Text('Are you sure you want to log out?'),
                  actions: <Widget>[
                    TextButton(
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Text('Log Out'),
                      onPressed: () {
                        logout();
                        // Perform the log out operation
                        Navigator.of(context).pop();
                        // Optionally navigate to the login screen or home screen
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
