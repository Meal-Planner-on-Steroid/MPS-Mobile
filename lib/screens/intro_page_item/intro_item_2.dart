import 'package:flutter/material.dart';

class IntroPage2 extends StatefulWidget {
  const IntroPage2({super.key});

  @override
  State<IntroPage2> createState() => _IntroPage2State();
}

class _IntroPage2State extends State<IntroPage2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(249, 249, 249, 1),
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
                          'assets/images/illustration/javascript_illustration.png')),
                ),
                SizedBox(height: 16),
                Text(
                  'MPS membuat rekomendasi rencana diet secara otomatis khusus untuk Kamu',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
