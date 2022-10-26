import 'package:flutter/material.dart';
// import '../makanan_card.dart';
import 'slider_rencana_diet_item.dart';

class SliderRencanaDietPage extends StatelessWidget {
  final String hari;
  final List makanans;

  const SliderRencanaDietPage({
    Key? key,
    required this.hari,
    required this.makanans,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: todo
    // TODO: Buat gesture untuk pindah page ontap panah
    return Column(
      children: [
        // Navigation hari
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.arrow_circle_left),
            Text(hari),
            const Icon(Icons.arrow_circle_right),
          ],
        ),
        // List rencana diet
        SliderRencanaDietItem(makanans: makanans)
      ],
    );
  }
}
