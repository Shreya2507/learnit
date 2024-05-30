// import 'dart:math';

import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

class DailyStreak extends StatefulWidget {
  const DailyStreak({super.key});

  @override
  State<DailyStreak> createState() => _DailyStreakState();
}

class _DailyStreakState extends State<DailyStreak> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  Set<DateTime> _streakDays = {};

  int _streak = (FirebaseAuth.instance.currentUser != null) ? 1 : 0;
  DateTime? _lastPunchedDay;
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _initPreferences();
  }

  void _initPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    // Load streak from SharedPreferences
    _streak = _prefs.getInt('streak') ?? 0;
    // If streak is greater than 0, load streak days
    if (_streak > 0) {
      List<String>? streakDays = _prefs.getStringList('streakDays');
      if (streakDays != null) {
        _streakDays = streakDays.map((date) => DateTime.parse(date)).toSet();
      }
    }
  }

  void _onPunchButtonPressed() {
    DateTime today = DateTime.now();
    DateTime todayWithoutTime = DateTime(today.year, today.month, today.day);

    setState(() {
      if (_lastPunchedDay != null &&
          _lastPunchedDay!.add(Duration(days: 1)) != todayWithoutTime) {
        _streak = 0;
        _streakDays.clear();
      }

      if (_streakDays.contains(todayWithoutTime)) {
        _streakDays.remove(todayWithoutTime);
        _streak = 0;
      } else {
        _streakDays.add(todayWithoutTime);
        _streak++;
      }

      _lastPunchedDay = todayWithoutTime;
      _prefs.setInt('streak', _streak); // Save streak to SharedPreferences
      _prefs.setStringList(
          'streakDays',
          _streakDays
              .map((date) => date.toIso8601String())
              .toList()); // Save streak days to SharedPreferences
    });
    AudioPlayer().play(AssetSource('streakSound.wav'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(131, 193, 60, 1),
        toolbarHeight: 100,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              DateFormat('HH:mm').format(DateTime.now()), // Show current time
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'Current Streak: $_streak days',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            // CircleAvatar(
            //   backgroundImage: NetworkImage(
            //       'https://via.placeholder.com/150'), // Placeholder image
            //   radius: 20,
            // ),
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 30),
          // Challenge progress slider
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text('$_streak Days'),
                        Text('Challenge Done'),
                      ],
                    ),
                    Column(
                      children: [
                        Text('${25 - _streak} Days'),
                        Text('Remaining'),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: LinearProgressIndicator(
                    value: _streak / 25,
                    backgroundColor: Colors.grey[300],
                    color: Colors.green,
                    minHeight: 25,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          // Calendar
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 2,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: TableCalendar(
                firstDay: DateTime.utc(2000, 1, 1),
                lastDay: DateTime.utc(2100, 12, 31),
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                selectedDayPredicate: (day) {
                  return isSameDay(
                      _focusedDay, day); // Highlight the focused day
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _focusedDay =
                        selectedDay; // Update the focused day when selected
                  });
                },
                onFormatChanged: (format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                },
                calendarBuilders: CalendarBuilders(
                  defaultBuilder: (context, day, focusedDay) {
                    if (_streakDays
                        .contains(DateTime(day.year, day.month, day.day))) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '${day.day}',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    } else if (isSameDay(_focusedDay, day)) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '${day.day}',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    } else {
                      return null;
                    }
                  },
                ),
              ),
            ),
          ),
          // Punch button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: _onPunchButtonPressed,
                  child: Text('Punch for Today'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(131, 193, 60, 1),
                    shadowColor: Color.fromRGBO(124, 194, 49, 1),
                    elevation: 3,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: _onPunchButtonPressed,
                  child: Text(
                    'Continue',
                    style: TextStyle(color: Colors.white),
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

          // Current streak display
        ],
      ),
    );
  }
}
