import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import '../makanan_card.dart';

class AccordionMakanan extends StatefulWidget {
  const AccordionMakanan({Key? key}) : super(key: key);

  @override
  State<AccordionMakanan> createState() => _AccordionMakananState();
}

class _AccordionMakananState extends State<AccordionMakanan> {
  List<ListAccordeion> items = [
    ListAccordeion(
      header: "Senin",
      title: "Senin",
      body: const MakananCard(),
    ),
    ListAccordeion(
      header: "Selasa",
      title: "Selasa",
      body: const MakananCard(),
    ),
    ListAccordeion(
      header: "Rabu",
      title: "Rabu",
      body: const MakananCard(),
    ),
    ListAccordeion(
      header: "Kamis",
      title: "Kamis",
      body: const MakananCard(),
    ),
    ListAccordeion(
      header: "Jumat",
      title: "Jumat",
      body: const MakananCard(),
    ),
    ListAccordeion(
      header: "Sabtu",
      title: "Sabtu",
      body: const MakananCard(),
    ),
    ListAccordeion(
      header: "Minggu",
      title: "Minggu",
      body: const MakananCard(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: items
            .map((item) => GFAccordion(
                  title: item.title,
                  contentChild: item.body,
                ))
            .toList(),
      ),
    );
  }
}

class ListAccordeion {
  final String header;
  final String title;
  final MakananCard body;

  ListAccordeion({
    required this.header,
    required this.title,
    required this.body,
  });
}
