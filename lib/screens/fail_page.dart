import 'package:flutter/material.dart';

class FailPage extends StatelessWidget {
  final String pesan;
  const FailPage({
    super.key,
    this.pesan = 'Terjadi masalah',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Center(
            child: Column(
              children: [
                const Spacer(),
                SizedBox(
                  height: 160,
                  child: Image.asset(
                      'assets/images/illustration/day41-desktop-trans.png'),
                ),
                const SizedBox(height: 16),
                Text(
                  pesan,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
