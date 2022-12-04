import 'package:flutter/material.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:intl/intl.dart';
import 'package:mps/app/controllers/pages/home_controller.dart';
import 'package:mps/utils/home/checkbox_gelas.dart';
import 'package:mps/utils/home/kartu_olahraga.dart';
import 'package:mps/utils/makanan_card.dart';

class SliderRencanaDiet extends StatefulWidget {
  const SliderRencanaDiet({
    Key? key,
  }) : super(key: key);

  @override
  State<SliderRencanaDiet> createState() => _SliderRencanaDietState();
}

class _SliderRencanaDietState extends State<SliderRencanaDiet> {
  final PageController _pageViewController = PageController(initialPage: 16);
  final _homeController = HomeController();

  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  late Future<Map<String, dynamic>> futureRencanaDiet;

  DateTime currentDate = DateTime.now();
  var thisPageDate = DateTime.now();
  var index = 0;

  List<ItemWaktuMakan> waktuMakan = [
    ItemWaktuMakan(title: 'Makan Pagi', code: 'PH'),
    ItemWaktuMakan(title: 'Makan Siang', code: 'SI'),
    ItemWaktuMakan(title: 'Makan Malam', code: 'ML'),
    ItemWaktuMakan(title: 'Camilan', code: 'CA'),
    ItemWaktuMakan(title: 'Camilan', code: 'CA'),
  ];

  // List<MakananCard> listMakananCard = [
  //   const MakananCard(),
  //   const MakananCard(),
  //   const MakananCard(),
  //   const MakananCard(),
  //   const MakananCard(),
  // ];

  Map<String, dynamic> statusMinum = {
    "jumlah_minum": 8,
    "progress": 2,
  };
  Map<String, dynamic> statusOlahraga = {
    "nama": '',
    "status": 2,
  };
  late List<MakananCard> listMakananCard;

  Future<Map<String, dynamic>> getRencanaDiet(String tanggal) async {
    return await _homeController.get(tanggal);
  }

  Map<String, dynamic> statusMinumBuilder(int jumlahMinum, int progress) {
    Map<String, dynamic> result = {};

    result = {
      "jumlah_minum": jumlahMinum,
      "progress": progress,
    };

    return result;
  }

  // List<MakananCard> listMakananCardBuilder() {
  List<MakananCard> listMakananCardBuilder(
      List<dynamic> rencanaMakanan, List<dynamic> makanans) {
    List<MakananCard> result = [];

    // Loop setiap waktu makan, untuk sekarang
    if (rencanaMakanan.isEmpty || makanans.isEmpty) {
      for (var i = 0; i < waktuMakan.length; i++) {
        var thisWaktuMakan = waktuMakan[i];

        result.add(MakananCard(
          waktuMakan: thisWaktuMakan.title,
        ));
      }
    } else {
      for (var i = 0; i < waktuMakan.length; i++) {
        var thisWaktuMakan = waktuMakan[i];
        var thisRencanaMakan = rencanaMakanan.where((element) {
          return element.waktuMakan == thisWaktuMakan.code;
        }).toList();
        var thisMakanan = makanans.where((element) {
          return element.id == thisRencanaMakan[0].makananId;
        }).toList();

        result.add(MakananCard(
          waktuMakan: thisWaktuMakan.title,
          namaMakanan: thisMakanan[0].nama,
          protein: thisMakanan[0].protein,
          karbo: thisMakanan[0].karbo,
          fat: thisMakanan[0].lemak,
          energi: thisMakanan[0].energi,
        ));
      }
    }

    return result;
  }

  @override
  void initState() {
    super.initState();

    futureRencanaDiet = getRencanaDiet(formatter.format(thisPageDate));
  }

  // ! Lag karena futurebuilder terpainggi banyak kali
  // * Lihat cara penggunakan provider dan cosumer
  @override
  Widget build(BuildContext context) {
    return ExpandablePageView.builder(
      onPageChanged: (position) async {
        setState(() {
          index = position - 16;
          thisPageDate = DateTime(
              currentDate.year, currentDate.month, currentDate.day + index);

          futureRencanaDiet = getRencanaDiet(formatter.format(thisPageDate));
        });
      },
      controller: _pageViewController,
      itemCount: 31,
      itemBuilder: (context, position) {
        return FutureBuilder<Map<String, dynamic>>(
          future: futureRencanaDiet,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Map<String, dynamic> data = snapshot.data!;

              // Cek rencana minum
              if (data.containsKey('rencana_diet_minum')) {
                var rencanaMinum = data['rencana_diet_minum'].data[0];
                statusMinum = statusMinumBuilder(
                  rencanaMinum.jumlahMinum,
                  rencanaMinum.progress,
                );
              }

              // Cek rencana makanan
              if (data.containsKey('rencana_diet_makanan') &&
                  data.containsKey('makanans')) {
                listMakananCard = listMakananCardBuilder(
                  data['rencana_diet_makanan'].data,
                  data['makanans'].data,
                );
              } else {
                listMakananCard = listMakananCardBuilder([], []);
              }

              // cek rencana olahraga
              if (data.containsKey('rencana_diet_olahraga')) {
                var rencanaOlahraga = data['rencana_diet_olahraga'].data[0];
                statusOlahraga = {
                  "nama": rencanaOlahraga.nama,
                  "status": rencanaOlahraga.status == 2,
                };
              }

              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    // Navigasi
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            _pageViewController.previousPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut);
                          },
                          icon: const Icon(Icons.arrow_circle_left),
                        ),
                        Text(formatter.format(thisPageDate)),
                        IconButton(
                          onPressed: () {
                            _pageViewController.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut);
                          },
                          icon: const Icon(Icons.arrow_circle_right),
                        ),
                      ],
                    ),

                    // Rencana minum air
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromRGBO(127, 209, 174, 1),
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(9),
                        ),
                      ),
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: statusMinum['jumlah_minum'],
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 5),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(4),
                            child: Center(
                              child: Container(
                                color: Colors.white,
                                child: CheckboxGelas(
                                    isDone: index < statusMinum['progress']),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 8),

                    // List rencana makanan diet
                    Column(
                      children: listMakananCard
                          .map(
                            (item) => Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: item,
                            ),
                          )
                          .toList(),
                    ),

                    // Karu olahraga
                    KartuOlahraga(
                      namaOlahraga: statusOlahraga['nama'],
                      isComplete: statusOlahraga['status'] == 1,
                    ),

                    // Content
                    Text('Current position $position'),
                    Text('Current index $index'),
                    Text('Current date ${formatter.format(currentDate)}'),
                    Text('This page date ${formatter.format(thisPageDate)}'),
                    const SizedBox(height: 8),
                  ],
                ),
              );
            } else {
              return Column(
                children: const [
                  SizedBox(height: 100),
                  Text('Loading...'),
                  SizedBox(height: 100),
                ],
              );
            }
          },
        );
      },
    );
  }
}

class ItemWaktuMakan {
  final String title;
  final String code;

  ItemWaktuMakan({
    required this.title,
    required this.code,
  });
}
