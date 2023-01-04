import 'package:flutter/material.dart';
import 'package:mps/utils/checkbox_green.dart';

class KartuOlahraga extends StatelessWidget {
  final String namaOlahraga;
  final bool isComplete;

  const KartuOlahraga({
    Key? key,
    this.namaOlahraga = "Belum olahraga 😔",
    this.isComplete = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(9),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Title & Gambar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(9),
                      child: SizedBox.fromSize(
                        size: const Size.fromRadius(40),
                        child: Image.asset(
                          'assets/images/olahraga_default.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Olahraga',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(namaOlahraga != ''
                            ? namaOlahraga
                            : 'Belum olahraga 😔'),
                      ],
                    ),
                  ],
                ),
                CheckboxGreen(checked: isComplete),
              ],
            ),

            // Divider
            // Padding(
            //     padding: const EdgeInsets.only(top: 8, bottom: 8),
            //     child: Container(
            //       height: 2,
            //       color: Colors.yellow.shade700,
            //     )),

            // Detail & kalori
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: const [
            //     // Detail
            //     Text('Detail'),
            //     // Kalori
            //     Text(
            //       'Kalori',
            //       style: TextStyle(color: Colors.blue),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
