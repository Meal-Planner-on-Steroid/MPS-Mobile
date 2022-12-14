import 'package:flutter/material.dart';

class MakananCard extends StatefulWidget {
  final String waktuMakan;
  final String namaMakanan;
  final double protein;
  final double karbo;
  final double fat;
  final double energi;

  const MakananCard({
    Key? key,
    required this.waktuMakan,
    required this.namaMakanan,
    required this.protein,
    required this.karbo,
    required this.fat,
    required this.energi,
  }) : super(key: key);

  @override
  State<MakananCard> createState() => _MakananCardState();
}

class _MakananCardState extends State<MakananCard> {
  @override
  Widget build(BuildContext context) {
    // debugPrint('MakananCard =========');
    // debugPrint(namaMakanan);
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        // color: Colors.grey,
        borderRadius: const BorderRadius.all(
          Radius.circular(9),
        ),
        border: Border.all(color: const Color.fromRGBO(225, 219, 214, 1)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Title & Gambar
            Row(
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
