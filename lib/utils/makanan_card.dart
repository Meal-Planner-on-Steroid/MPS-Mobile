import 'package:flutter/material.dart';

class MakananCard extends StatelessWidget {
  const MakananCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(38, 50, 56, 12),
            blurRadius: 2,
            offset: Offset(0, 1),
          )
        ],
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(9),
                  child: SizedBox.fromSize(
                    size: const Size.fromRadius(40),
                    child: Image.asset(
                      'assets/images/makanan_random.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Waktu makan',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text('Nama makanan'),
                  ],
                ),
              ],
            ),
            // Divider
            Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                child: Container(
                  height: 2,
                  color: Colors.yellow.shade700,
                )),

            // Detail & kalori
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                // Detail
                Text('Detail'),
                // Kalori
                Text(
                  'Kalori',
                  style: TextStyle(color: Colors.blue),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
