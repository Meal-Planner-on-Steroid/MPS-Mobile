import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class GoalHariIni extends StatefulWidget {
  final double keseluruhanEnergi;
  final double butuhKarbo;
  final double butuhProtein;
  final double butuhLemak;
  final double progresEnergi;
  final double progresKarbo;
  final double progresProtein;
  final double progresLemak;

  const GoalHariIni({
    Key? key,
    this.keseluruhanEnergi = 0,
    this.butuhKarbo = 0,
    this.butuhProtein = 0,
    this.butuhLemak = 0,
    this.progresEnergi = 0,
    this.progresKarbo = 0,
    this.progresProtein = 0,
    this.progresLemak = 0,
  }) : super(key: key);

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
            const Text(
              'Goal hari ini️ ️‍🔥',
              style: TextStyle(
                fontSize: 16,
              ),
            ),

            // goal lingkaran
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Energi',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '🔥 ${widget.keseluruhanEnergi.toStringAsFixed(0)} kcal',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                // Progress lingkaran karbo
                CircularPercentIndicator(
                  radius: 60.0,
                  lineWidth: 5.0,
                  percent: widget.progresKarbo,
                  center: Text('${widget.progresKarbo.toStringAsFixed(0)}%'),
                  footer: const Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Text('Karb'),
                  ),
                  progressColor: Colors.red,
                ),

                // Progress lingkaran protein
                CircularPercentIndicator(
                  radius: 60.0,
                  lineWidth: 5.0,
                  percent: widget.progresProtein,
                  center: Text('${widget.progresProtein.toStringAsFixed(0)}%'),
                  footer: const Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Text('Pro'),
                  ),
                  progressColor: Colors.blue,
                ),

                // Progress lingkaran lemak
                CircularPercentIndicator(
                  radius: 60.0,
                  lineWidth: 5.0,
                  percent: widget.progresLemak,
                  center: Text('${widget.progresLemak.toStringAsFixed(0)}%'),
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
                child: Icon(
                  opened ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  size: 36,
                ),
              ),
            ),

            // Detail goal
            Visibility(
              visible: opened,
              child: Column(
                children: [
                  // Progres bar Energi
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
                          percent: widget.progresEnergi,
                          linearStrokeCap: LinearStrokeCap.roundAll,
                          progressColor: Colors.green,
                          backgroundColor: Colors.green.shade200,
                        ),
                      ),
                      Text(
                          '${widget.progresEnergi.toStringAsFixed(0)} / ${widget.keseluruhanEnergi.toStringAsFixed(0)} kcal'),
                    ],
                  ),

                  // Progres bar Karbohidrat
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
                          percent: widget.progresKarbo,
                          linearStrokeCap: LinearStrokeCap.roundAll,
                          progressColor: Colors.redAccent,
                          backgroundColor: Colors.red.shade200,
                        ),
                      ),
                      Text(
                          '${widget.progresKarbo.toStringAsFixed(0)} / ${widget.butuhKarbo.toStringAsFixed(0)} g'),
                    ],
                  ),

                  // Progres bar Protein
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
                          percent: widget.progresProtein,
                          linearStrokeCap: LinearStrokeCap.roundAll,
                          progressColor: Colors.blue,
                          backgroundColor: Colors.blue.shade200,
                        ),
                      ),
                      Text(
                          '${widget.progresProtein.toStringAsFixed(0)} / ${widget.butuhProtein.toStringAsFixed(0)} g'),
                    ],
                  ),

                  // Progres bar Lemak
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
                          percent: widget.progresLemak,
                          linearStrokeCap: LinearStrokeCap.roundAll,
                          progressColor: Colors.yellow.shade800,
                          backgroundColor: Colors.yellow.shade200,
                        ),
                      ),
                      Text(
                          '${widget.progresLemak.toStringAsFixed(0)} / ${widget.butuhLemak.toStringAsFixed(0)} g'),
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
