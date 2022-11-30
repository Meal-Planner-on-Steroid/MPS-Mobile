import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:mps/utils/accordeon_rekomendasi_makanan/makanan_card.dart';

class AccordionMakanan extends StatefulWidget {
  final List<dynamic> rekomendasiRencana;
  final List<dynamic> rekomendasiMakanan;
  final List<dynamic> makanans;

  const AccordionMakanan({
    Key? key,
    required this.rekomendasiRencana,
    required this.rekomendasiMakanan,
    required this.makanans,
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

  List<ListAccordeion> listAccordeionBuilder(
    List<dynamic> rekomendasiRencana,
    List<dynamic> rekomendasiMakanan,
    List<dynamic> makanans,
  ) {
    List<ListAccordeion> result = [];

    // Loop setiap colum atau hari di data
    for (var i = 0; i < rekomendasiRencana.length; i++) {
      if (i >= 7) {
        break;
      }

      // debugPrint('Rekomendasi rencana id: ${rekomendasiRencana[i].id}');
      var listMakananRencana = rekomendasiMakanan.where((element) {
        return element.rekomendasiRencanaDietId == rekomendasiRencana[i].id;
      }).toList();

      List<MakananCard> listBody = [];

      // Buat list makanan di dalam hari berdasarkan rekomendasiMakanan
      for (var j = 0; j < listMakananRencana.length; j++) {
        var thisWaktuMakan = waktuMakan
            .where(
                (element) => element.code == listMakananRencana[j].waktuMakan)
            .toList();
        var thisMakanan = makanans
            .where((element) => element.id == listMakananRencana[j].makananId)
            .toList();

        listBody.add(MakananCard(
          waktuMakan: thisWaktuMakan[0].title,
          namaMakanan: thisMakanan[0].nama,
          protein: thisMakanan[0].protein,
          karbo: thisMakanan[0].karbo,
          fat: thisMakanan[0].lemak,
          energi: thisMakanan[0].energi,
        ));
      }

      result.add(
        ListAccordeion(
          header: hari[i],
          title: hari[i],
          body: listBody,
          // body: [
          //   const MakananCard(
          //     waktuMakan: 'waktuMakan',
          //     namaMakanan: 'namaMakanan',
          //     protein: 0,
          //     karbo: 0,
          //     fat: 0,
          //     energi: 0,
          //   ),
          // ],
        ),
      );

      // break;
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    items = listAccordeionBuilder(
      widget.rekomendasiRencana,
      widget.rekomendasiMakanan,
      widget.makanans,
    );

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
