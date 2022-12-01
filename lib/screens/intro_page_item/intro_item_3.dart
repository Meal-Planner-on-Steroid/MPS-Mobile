import 'package:flutter/material.dart';

class IntroPage3 extends StatefulWidget {
  final ValueChanged<bool> update;
  const IntroPage3({
    super.key,
    required this.update,
  });

  @override
  State<IntroPage3> createState() => _IntroPage3State();
}

class _IntroPage3State extends State<IntroPage3> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(250, 244, 183, 1),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: Column(
              children: [
                const Spacer(),
                const Text('Mari hitung kebutuhan gizi kamu dulu'),
                const SizedBox(height: 16),
                // Tombol submit
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    primary: const Color.fromRGBO(127, 209, 174, 1),
                  ),
                  onPressed: () {
                    widget.update(true);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(11.0),
                    child: Text(
                      'LOG IN',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
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
