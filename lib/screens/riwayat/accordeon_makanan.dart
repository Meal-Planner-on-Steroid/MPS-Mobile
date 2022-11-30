import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:mps/utils/accordeon_rekomendasi_makanan/makanan_card.dart';

class AccordionMakanan extends StatefulWidget {
  final List<dynamic> rekomendasiRencana;
  const AccordionMakanan({
    Key? key,
    required this.rekomendasiRencana,
  }) : super(key: key);

  @override
  State<AccordionMakanan> createState() => _AccordionMakananState();
}

class _AccordionMakananState extends State<AccordionMakanan> {
  List<String> hari = [
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat',
    'Sabtu',
    'Minggu',
  ];

  List<ItemWaktuMakan> waktuMakan = [
    ItemWaktuMakan(title: 'Makan Pagi', code: 'PH'),
    ItemWaktuMakan(title: 'Makan Siang', code: 'SI'),
    ItemWaktuMakan(title: 'Makan Malam', code: 'ML'),
    ItemWaktuMakan(title: 'Camilan', code: 'CA'),
    ItemWaktuMakan(title: 'Camilan', code: 'CA'),
  ];

  late List<ListAccordeion> items = [];

  List<ListAccordeion> listAccordeionBuilder(List<dynamic> rekomendasiRencana) {
    List<ListAccordeion> result = [];

    // Loop setiap colum atau hari di data
    for (var i = 0; i < rekomendasiRencana.length; i++) {
      // List<dynamic> makanans = data[i];
      if (i >= 7) {
        break;
      }

      // List<MakananCard> listBody = [];

      // Lopp setiap makanan di data
      // for (var j = 0; j < makanans.length; j++) {
      //   listBody.add(MakananCard(
      //     waktuMakan: waktuMakan[j].title,
      //     namaMakanan: makanans[j].nama,
      //     protein: makanans[j].protein,
      //     karbo: makanans[j].karbo,
      //     fat: makanans[j].lemak,
      //     energi: makanans[j].energi,
      //   ));
      // }

      result.add(
        ListAccordeion(
          header: hari[i],
          title: hari[i],
          body: [
            const MakananCard(
              waktuMakan: 'waktuMakan',
              namaMakanan: 'namaMakanan',
              protein: 0,
              karbo: 0,
              fat: 0,
              energi: 0,
            ),
            const MakananCard(
              waktuMakan: 'waktuMakan',
              namaMakanan: 'namaMakanan',
              protein: 0,
              karbo: 0,
              fat: 0,
              energi: 0,
            ),
            const MakananCard(
              waktuMakan: 'waktuMakan',
              namaMakanan: 'namaMakanan',
              protein: 0,
              karbo: 0,
              fat: 0,
              energi: 0,
            ),
            const MakananCard(
              waktuMakan: 'waktuMakan',
              namaMakanan: 'namaMakanan',
              protein: 0,
              karbo: 0,
              fat: 0,
              energi: 0,
            ),
            const MakananCard(
              waktuMakan: 'waktuMakan',
              namaMakanan: 'namaMakanan',
              protein: 0,
              karbo: 0,
              fat: 0,
              energi: 0,
            ),
          ],
        ),
      );
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    items = listAccordeionBuilder(widget.rekomendasiRencana);

    inspect(widget.rekomendasiRencana);
    return Container(
      color: Colors.white,
      child: Column(
        children: items
            .map(
              (item) => GFAccordion(
                contentPadding: const EdgeInsets.only(top: 8, bottom: 8),
                title: item.title,
                contentChild: Column(
                  children: item.body.map((e) => e).toList(),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class ListAccordeion {
  final String header;
  final String title;
  final List<MakananCard> body;

  ListAccordeion({
    required this.header,
    required this.title,
    required this.body,
  });
}

class ItemWaktuMakan {
  final String title;
  final String code;

  ItemWaktuMakan({
    required this.title,
    required this.code,
  });
}
