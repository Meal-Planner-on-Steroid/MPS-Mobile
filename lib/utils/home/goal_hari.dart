import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class GoalHariIni extends StatefulWidget {
  const GoalHariIni({Key? key}) : super(key: key);

  @override
  State<GoalHariIni> createState() => _GoalHariIniState();
}

class _GoalHariIniState extends State<GoalHariIni> {
  bool opened = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromRGBO(127, 209, 174, 1),
          width: 2,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(9),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Goal hari ini
            const Text('Goal hari ini️ ️‍🔥'),

            // goal lingkaran
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Energi',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '🔥 1000 kcal',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                CircularPercentIndicator(
                  radius: 60.0,
                  lineWidth: 5.0,
                  percent: 0.25,
                  center: const Text('25%'),
                  footer: const Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Text('Karb'),
                  ),
                  progressColor: Colors.red,
                ),
                CircularPercentIndicator(
                  radius: 60.0,
                  lineWidth: 5.0,
                  percent: 0.6,
                  center: const Text('60%'),
                  footer: const Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Text('Pro'),
                  ),
                  progressColor: Colors.blue,
                ),
                CircularPercentIndicator(
                  radius: 60.0,
                  lineWidth: 5.0,
                  percent: 0.80,
                  center: const Text('80%'),
                  footer: const Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Text('Fat'),
                  ),
                  progressColor: Colors.yellow.shade800,
                ),
              ],
            ),

            // Tombol dropdown
            const SizedBox(height: 16),
            Center(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    opened = !opened;
                  });
                },
                child: const Icon(
                  Icons.keyboard_arrow_down,
                  size: 36,
                ),
              ),
            ),

            // Detail goal
            Visibility(
              visible: opened,
              child: Column(
                children: [
                  // Energi
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Energi'),
                      Padding(
                        padding: const EdgeInsets.only(top: 4, bottom: 4),
                        child: LinearPercentIndicator(
                          animation: true,
                          lineHeight: 12.0,
                          animationDuration: 500,
                          percent: 0.25,
                          linearStrokeCap: LinearStrokeCap.roundAll,
                          progressColor: Colors.green,
                          backgroundColor: Colors.green.shade200,
                        ),
                      ),
                      const Text('12 / 1000 kcal'),
                    ],
                  ),

                  // Karbohidrat
                  const SizedBox(height: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Karbohidrat'),
                      Padding(
                        padding: const EdgeInsets.only(top: 4, bottom: 4),
                        child: LinearPercentIndicator(
                          animation: true,
                          lineHeight: 12.0,
                          animationDuration: 500,
                          percent: 0.25,
                          linearStrokeCap: LinearStrokeCap.roundAll,
                          progressColor: Colors.redAccent,
                          backgroundColor: Colors.red.shade200,
                        ),
                      ),
                      const Text('12 / 1000 g'),
                    ],
                  ),

                  // Protein
                  const SizedBox(height: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Protein'),
                      Padding(
                        padding: const EdgeInsets.only(top: 4, bottom: 4),
                        child: LinearPercentIndicator(
                          animation: true,
                          lineHeight: 12.0,
                          animationDuration: 500,
                          percent: 0.25,
                          linearStrokeCap: LinearStrokeCap.roundAll,
                          progressColor: Colors.blue,
                          backgroundColor: Colors.blue.shade200,
                        ),
                      ),
                      const Text('12 / 1000 g'),
                    ],
                  ),

                  // Lemak
                  const SizedBox(height: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Lemak'),
                      Padding(
                        padding: const EdgeInsets.only(top: 4, bottom: 4),
                        child: LinearPercentIndicator(
                          animation: true,
                          lineHeight: 12.0,
                          animationDuration: 500,
                          percent: 0.25,
                          linearStrokeCap: LinearStrokeCap.roundAll,
                          progressColor: Colors.yellow.shade800,
                          backgroundColor: Colors.yellow.shade200,
                        ),
                      ),
                      const Text('12 / 1000 g'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
