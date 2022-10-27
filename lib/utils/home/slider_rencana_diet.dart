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
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  List<ListRencanaDiet> listRencanaDiet = [
    ListRencanaDiet(
      hari: 'hari',
      body: const [
        MakananCard(beChecked: true),
        MakananCard(beChecked: true),
        MakananCard(beChecked: true),
        MakananCard(beChecked: true),
        MakananCard(beChecked: true),
      ],
    ),
    ListRencanaDiet(
      hari: 'hari',
      body: const [
        MakananCard(beChecked: true),
        MakananCard(beChecked: true),
        MakananCard(beChecked: true),
        MakananCard(beChecked: true),
        MakananCard(beChecked: true),
      ],
    ),
    ListRencanaDiet(
      hari: 'hari',
      body: const [
        MakananCard(beChecked: true),
        MakananCard(beChecked: true),
        MakananCard(beChecked: true),
        MakananCard(beChecked: true),
        MakananCard(beChecked: true),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // return const Text('he');
    return ExpandablePageView(
      controller: _pageController,
      children: listRencanaDiet
          .map(
            (item) => SliderRencanaDietPage(
              hari: item.hari,
              makanans: item.body,
              controller: _pageController,
            ),
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
