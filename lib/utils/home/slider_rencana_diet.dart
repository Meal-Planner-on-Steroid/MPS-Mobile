import 'package:flutter/material.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:intl/intl.dart';
import 'package:mps/app/controllers/pages/test_controller.dart';
import 'package:mps/utils/home/checkbox_gelas.dart';
import 'package:mps/utils/home/kartu_olahraga.dart';
import '../makanan_card.dart';

class SliderRencanaDiet extends StatefulWidget {
  final ValueChanged<String> homeDate;

  const SliderRencanaDiet({
    Key? key,
    required this.homeDate,
  }) : super(key: key);

  @override
  State<SliderRencanaDiet> createState() => _SliderRencanaDietState();
}

class _SliderRencanaDietState extends State<SliderRencanaDiet> {
  final PageController _pageViewController = PageController(initialPage: 16);
  final _testController = TestPageController();

  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  late Future<String> futureText;

  DateTime currentDate = DateTime.now();
  var thisPageDate = DateTime.now();
  var index = 0;

  Future<String> getRandomText(String whatDate) async {
    return await _testController.get() + whatDate;
  }

  @override
  void initState() {
    super.initState();

    futureText = getRandomText(formatter.format(thisPageDate).toString());
  }

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

  late List<MakananCard> listMakananCard;

  Map<String, dynamic> statusMinumBuilder(int jumlahMinum, int progress) {
    Map<String, dynamic> result = {};

    result = {
      "jumlah_minum": jumlahMinum,
      "progress": progress,
    };

    return result;
  }

  List<MakananCard> listMakananCardBuilder() {
    List<MakananCard> result = [];

    // Loop setiap waktu makan, untuk sekarang
    for (var i = 0; i < waktuMakan.length; i++) {
      var thisWaktuMakan = waktuMakan[i];

      result.add(MakananCard(
        namaMakanan: 'Watku makan loop',
        waktuMakan: thisWaktuMakan.title,
      ));
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    listMakananCard = listMakananCardBuilder();
    statusMinum = statusMinumBuilder(8, 2);

    return ExpandablePageView.builder(
      onPageChanged: (position) async {
        setState(() {
          index = position - 16;
          thisPageDate = DateTime(
              currentDate.year, currentDate.month, currentDate.day + index);
          widget.homeDate(formatter.format(thisPageDate));
          futureText = getRandomText(formatter.format(thisPageDate).toString());
        });
      },
      controller: _pageViewController,
      itemCount: 31,
      itemBuilder: (context, position) {
        return FutureBuilder<String>(
          future: futureText,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              String data = snapshot.data!;
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
                    const KartuOlahraga(),

                    // Content
                    Text('Current position $position'),
                    Text('Current index $index'),
                    Text('Current date ${formatter.format(currentDate)}'),
                    Text('This page date ${formatter.format(thisPageDate)}'),
                    const Text('the random text bellow'),
                    Text(data),
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

class ListRencanaDiet {
  final String hari;
  final List body;

  ListRencanaDiet({
    required this.hari,
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
