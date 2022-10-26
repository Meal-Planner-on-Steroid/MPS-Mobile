import 'package:flutter/material.dart';
// import '../makanan_card.dart';

class SliderRencanaDietItem extends StatelessWidget {
  final List makanans;
  const SliderRencanaDietItem({
    Key? key,
    required this.makanans,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: makanans
          .map(
            (item) => Padding(
              padding: const EdgeInsets.only(top: 16),
              child: item,
            ),
          )
          .toList(),
    );
  }
}
