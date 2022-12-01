import 'package:flutter/material.dart';

class IntroPage1 extends StatefulWidget {
  const IntroPage1({super.key});

  @override
  State<IntroPage1> createState() => _IntroPage1State();
}

class _IntroPage1State extends State<IntroPage1> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(205, 240, 234, 1),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: Column(
              children: const [
                Spacer(),
                Text('Hitung kebutuhan gizi kamu'),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
