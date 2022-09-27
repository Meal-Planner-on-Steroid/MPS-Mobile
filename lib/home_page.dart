import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mps/utils/habit_tiles.dart';
import 'utils/habit_tiles.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Fake data
  List habitList = [
    // [habitName, isHabitStarted, timeSpent, timeGoal]
    ['Makan', false, 0, 10],
    ['Cuci baju', false, 0, 30],
    ['Tidur', false, 0, 40],
    ['Olahraga', false, 0, 11],
    ['Ikan', false, 0, 15],
    ['Bakar', false, 0, 24],
    ['duud', false, 0, 57],
    ['dada', false, 0, 19],
  ];

  void habitStarted(int index) {
    // Note what the start time
    var startTime = DateTime.now();

    // Include last timer progress
    int elapsedTime = habitList[index][2];

    // Habit started
    setState(() {
      habitList[index][1] = !habitList[index][1];
    });

    if (habitList[index][1]) {
      // Keep the time going
      Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          // Check when the user has stop the timer
          if (!habitList[index][1]) {
            timer.cancel();
          }

          // Calculate the time elapsed by current time and start time
          var currentTime = DateTime.now();
          habitList[index][2] = elapsedTime +
              currentTime.second -
              startTime.second +
              60 * (currentTime.minute - startTime.minute) +
              60 * 60 * (currentTime.hour - startTime.hour);
        });
      });
    }
  }

  void settingOpened(int index) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Settings for ' + habitList[index][0]),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        title: Text('Consistency is the key'),
      ),
      body: ListView.builder(
        itemCount: habitList.length,
        itemBuilder: ((context, index) {
          return HabitTile(
            habitName: habitList[index][0],
            onTap: () {
              habitStarted(index);
            },
            settingTapped: () {
              settingOpened(index);
            },
            isHabitStarted: habitList[index][1],
            timeSpent: habitList[index][2],
            timeGoal: habitList[index][3],
          );
        }),
      ),
    );
  }
}
