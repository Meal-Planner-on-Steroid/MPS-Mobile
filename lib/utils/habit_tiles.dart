import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HabitTile extends StatelessWidget {
  final String habitName;
  final VoidCallback onTap;
  final VoidCallback settingTapped;
  final int timeSpent;
  final int timeGoal;
  final bool isHabitStarted;

  const HabitTile({
    Key? key,
    required this.habitName,
    required this.onTap,
    required this.settingTapped,
    required this.timeSpent,
    required this.timeGoal,
    required this.isHabitStarted,
  }) : super(key: key);

  // Convert second into min:sec -> e.g. 62 seconds = 1:02
  String formatToMinSec(int totalSeconds) {
    String secs = (totalSeconds % 60).toString();
    String mins = (totalSeconds / 60).toStringAsFixed(5);

    // If secs is 1 digit number
    if (secs.length == 1) {
      secs = '0' + secs;
    }

    // If mins is 1 digit number
    if (mins[1] == '.') {
      mins = mins.substring(0, 1);
    }

    return mins + ":" + secs;
  }

  // Calculate progress percentage
  double percentCompleted() {
    return timeSpent / timeGoal * 60;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 16.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(9)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                // Progress circle
                GestureDetector(
                  onTap: onTap,
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: Stack(children: [
                      CircularPercentIndicator(
                        radius: 50,
                      ),
                      // play pause btn
                      Center(
                          child: Icon(
                              isHabitStarted ? Icons.pause : Icons.play_arrow))
                    ]),
                  ),
                ),

                // Space
                SizedBox(
                  width: 16,
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Habit name
                    Text(
                      habitName,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    // Space
                    const SizedBox(
                      height: 8.0,
                    ),
                    // Progress
                    Text(
                      formatToMinSec(timeSpent) +
                          ' / ' +
                          formatToMinSec(timeGoal) +
                          ' = ' +
                          (percentCompleted()).toStringAsFixed(0) +
                          ' %',
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
              ],
            ),
            GestureDetector(onTap: settingTapped, child: Icon(Icons.settings)),
          ],
        ),
      ),
    );
  }
}
