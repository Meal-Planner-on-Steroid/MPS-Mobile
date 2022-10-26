import 'package:flutter/material.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import '../makanan_card.dart';
import 'slider_rencana_diet_page.dart';

class SliderRencanaDiet extends StatefulWidget {
  const SliderRencanaDiet({Key? key}) : super(key: key);

  @override
  State<SliderRencanaDiet> createState() => _SliderRencanaDietState();
}

class _SliderRencanaDietState extends State<SliderRencanaDiet> {
  // ignore: todo
  // TODO: Buat card makanan dengan checkbox
  List<ListRencanaDiet> listRencanaDiet = [
    ListRencanaDiet(
      hari: 'hari',
      body: const [
        MakananCard(),
        MakananCard(),
        MakananCard(),
        MakananCard(),
        MakananCard(),
      ],
    ),
    ListRencanaDiet(
      hari: 'hari',
      body: const [
        MakananCard(),
        MakananCard(),
        MakananCard(),
        MakananCard(),
        MakananCard(),
      ],
    ),
    ListRencanaDiet(
      hari: 'hari',
      body: const [
        MakananCard(),
        MakananCard(),
        MakananCard(),
        MakananCard(),
        MakananCard(),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // return const Text('he');
    return ExpandablePageView(
      children: listRencanaDiet
          .map(
            (item) =>
                SliderRencanaDietPage(hari: item.hari, makanans: item.body),
          )
          .toList(),
    );
  }
}

class ListRencanaDiet {
  final String hari;
  final List body;

  ListRencanaDiet({
    required this.hari,
    required this.body,
  });
}
