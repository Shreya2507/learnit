import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //     // title: Text(''),
      //     // //backgroundColor: Colors.deepPurple,
      //     // backgroundColor: Color.fromRGBO(131, 193, 60, 1),
      //     // shape: RoundedRectangleBorder(
      //     //   borderRadius: BorderRadius.vertical(
      //     //     bottom: Radius.circular(15),
      //     //   ),
      //     // )
      //     ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Color.fromARGB(153, 171, 207, 186),
                      backgroundImage:
                          AssetImage('assets/dashboard/profile.png'),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Shreya Mathur',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(147, 1, 125, 67),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'shreya@gmail.com',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 10),
                    // Text(
                    //   '+919183485678',
                    //   style: TextStyle(
                    //     fontSize: 16,
                    //     color: Colors.grey[600],
                    //   ),
                    // ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(153, 193, 235, 199),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Bio',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 27, 42, 20),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Dedicated and passionate educator with over 10 years of experience in the field of Computer Science. .',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[800],
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    _buildListTile(Icons.school, 'Academic Qualifications',
                        'Ph.D. in Computer Science, M.S. in Software Engineering, B.S. in Computer Science'),
                    _buildListTile(Icons.book, 'Subjects of Expertise',
                        'Data Structures, Algorithms, Machine Learning, Artificial Intelligence, Software Development'),
                    _buildListTile(
                      Icons.class_,
                      'Current Courses',
                      'German',
                    ),
                    // _buildListTile(Icons.location_on, 'Location',
                    //     '1234 Main Street, Anytown, USA'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListTile(IconData icon, String title, String subtitle) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      elevation: 3,
      color: Color.fromRGBO(136, 255, 0, 0.553),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(icon, color: Color.fromARGB(255, 31, 44, 44)),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
      ),
    );
  }
}
