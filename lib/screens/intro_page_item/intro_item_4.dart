import 'package:flutter/material.dart';

class IntroPage4 extends StatefulWidget {
  const IntroPage4({super.key});

  @override
  State<IntroPage4> createState() => _IntroPage4State();
}

class _IntroPage4State extends State<IntroPage4> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(255, 182, 0, 1),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: Column(
              children: const [
                Spacer(),
                SizedBox(
                  height: 200,
                  child: Image(
                      image: AssetImage(
                          'assets/images/illustration/day71-designer-tool-essential.png')),
                ),
                SizedBox(height: 16),
                Text(
                  'Selamat datang',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'di Meal Planner on Steroid Versi Alpha',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 4),
                Text(
                  'Segala bug/error adalah hal yang diharapkan',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 40),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
