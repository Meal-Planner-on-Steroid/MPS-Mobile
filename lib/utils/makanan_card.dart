import 'package:flutter/material.dart';
import 'checkbox_green.dart';

class MakananCard extends StatefulWidget {
  final String waktuMakan;
  final String namaMakanan;
  final double protein;
  final double karbo;
  final double fat;
  final double energi;

  const MakananCard({
    Key? key,
    this.waktuMakan = 'Waktu makan',
    this.namaMakanan = 'Nama makanan',
    this.protein = 0,
    this.karbo = 0,
    this.fat = 0,
    this.energi = 0,
  }) : super(key: key);

  @override
  State<MakananCard> createState() => _MakananCardState();
}

class _MakananCardState extends State<MakananCard> {
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
                Flexible(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(9),
                        child: SizedBox.fromSize(
                          size: const Size.fromRadius(40),
                          child: Image.asset(
                            'assets/images/makanan_default.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.waktuMakan,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              widget.namaMakanan,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const CheckboxGreen(),
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
              children: [
                // Detail
                Text(
                    "Pro ${widget.protein.toStringAsFixed(1)}, Karb ${widget.karbo.toStringAsFixed(1)}, Fat ${widget.fat.toStringAsFixed(1)}"),

                // Kalori
                Text(
                  "${widget.energi.toStringAsFixed(2)} kcal",
                  style: const TextStyle(color: Colors.blue),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
