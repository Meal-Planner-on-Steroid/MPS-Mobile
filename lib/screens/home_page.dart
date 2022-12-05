import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mps/app/controllers/pages/hitung_kebutuhan_gizi_controller.dart';
import 'package:mps/app/controllers/pages/home_controller.dart';
import 'package:mps/app/serializers/user_profile_serializer.dart';
import 'package:mps/utils/avatar_dan_setting.dart';
import 'package:mps/utils/home/checkbox_gelas.dart';
import 'package:mps/utils/home/goal_hari.dart';
import 'package:mps/utils/home/kartu_olahraga.dart';
import 'package:mps/utils/home/makanan_card.dart';
import 'package:mps/utils/home/slider_rencana_diet.dart';
import 'package:mps/utils/home/test_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Model & endpoint controller
  final _hitungKebutuhanGiziController = HitungKebutuhanGiziController();
  final _homeController = HomeController();

  // Widget controller
  final PageController _pageViewController = PageController(initialPage: 16);

  // Variable future dan late
  late Future<UserProfileSerializer> _userProfileFuture;
  // late Future<Map<String, dynamic>> futureRencanaDiet;
  late List<MakananCard> listMakananCard;
  late Future<Map<String, dynamic>> futureListRencanaDiet;

  // Variable biasa
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
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
  Map<String, dynamic> statusMinum = {
    "jumlah_minum": 8,
    "progress": 2,
  };
  Map<String, dynamic> statusOlahraga = {
    "nama": '',
    "status": 2,
  };

  // Fungsi
  Future<UserProfileSerializer> getUserProfile() async {
    final userProfileData = await _hitungKebutuhanGiziController.get();
    return userProfileData;
  }

  Future<Map<String, dynamic>> getRencanaDiet(String tanggal) async {
    return await _homeController.get(tanggal);
  }

  Future<Map<String, dynamic>> getSetRencanaDiet(
      String mulaiDariTanggal) async {
    return await _homeController.getSetRencanaDiet(mulaiDariTanggal);
  }

  Map<String, dynamic> statusMinumBuilder(int jumlahMinum, int progress) {
    Map<String, dynamic> result = {};

    result = {
      "jumlah_minum": jumlahMinum,
      "progress": progress,
    };

    return result;
  }

  List<MakananCard> listMakananCardBuilder(
      List<dynamic> rencanaMakanan, List<dynamic> makanans) {
    List<MakananCard> result = [];
    dynamic thisRencanaMakan = [];
    List<dynamic> thisWaktuMakan = [];
    List<dynamic> thisMakanan = [];

    // Loop setiap waktu makan, untuk sekarang
    if (rencanaMakanan.isEmpty || makanans.isEmpty) {
      for (var i = 0; i < waktuMakan.length; i++) {
        var thisWaktuMakan = waktuMakan[i];

        result.add(MakananCard(
          waktuMakan: thisWaktuMakan.title,
        ));
      }
    } else {
      // Buat list makanan
      for (var i = 0; i < rencanaMakanan.length; i++) {
        thisRencanaMakan = rencanaMakanan[i];

        thisWaktuMakan = waktuMakan.where((element) {
          return element.code == thisRencanaMakan.waktuMakan;
        }).toList();

        thisMakanan = makanans.where((element) {
          return element.id == thisRencanaMakan.makananId;
        }).toList();

        result.add(MakananCard(
          rencanaMakanId: thisRencanaMakan.id,
          statusRencanaMakan: thisRencanaMakan.status,
          waktuMakan: thisWaktuMakan[0].title,
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

    _userProfileFuture = getUserProfile();
    // futureRencanaDiet = getRencanaDiet(formatter.format(thisPageDate));
    futureListRencanaDiet = getSetRencanaDiet(formatter.format(
        DateTime(currentDate.year, currentDate.month, currentDate.day - 16)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     setState(() {});
      //   },
      //   child: const Icon(Icons.refresh),
      // ),
      body: SafeArea(
        child: ListView(
          // padding: const EdgeInsets.all(24),
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 24,
                top: 24,
                right: 24,
              ),
              child: Column(
                children: [
                  const AvatarDanSetting(currentPage: 'Home'),

                  // Dropdown status
                  const SizedBox(height: 16),
                  FutureBuilder<UserProfileSerializer>(
                    future: _userProfileFuture,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const GoalHariIni();
                      }
                      var data = snapshot.data!.data[0];

                      double tempButuhKarbo =
                          (data.butuhKarbo.karbo60 + data.butuhKarbo.karbo75) /
                              2;
                      double tempButuhProtein = (data.butuhProtein.protein10 +
                              data.butuhProtein.protein15) /
                          2;
                      double tempButuhLemak =
                          (data.butuhLemak.lemak10 + data.butuhLemak.lemak25) /
                              2;

                      return GoalHariIni(
                        keseluruhanEnergi: data.keseluruhanEnergi ?? 0,
                        butuhKarbo: tempButuhKarbo,
                        butuhProtein: tempButuhProtein,
                        butuhLemak: tempButuhLemak,
                        progresEnergi: 0,
                        progresKarbo: 0,
                        progresProtein: 0,
                        progresLemak: 0,
                      );
                      // return const Text('ada data');
                    },
                  ),

                  // const GoalHariIni(),
                ],
              ),
            ),

            // Slider
            const SizedBox(height: 8),
            // const SliderRencanaDiet(),
            // const TestPage(),

            FutureBuilder<Map<String, dynamic>>(
              future: futureListRencanaDiet,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  Map<String, dynamic> data = snapshot.data!;
                  // inspect(data);

                  return ExpandablePageView.builder(
                    controller: _pageViewController,
                    itemCount: 31,
                    itemBuilder: (context, position) {
                      index = position - 16;
                      thisPageDate = DateTime(currentDate.year,
                          currentDate.month, currentDate.day + index);
                      String dateKey = formatter.format(thisPageDate);

                      if (data.containsKey(dateKey)) {
                        Map<String, dynamic> currentData = data[dateKey];

                        // Refererensi data agar mudah
                        // ignore: unused_local_variable
                        var rencanaDiet = currentData['rencana_diet'];
                        List rencanaDietMakanan =
                            currentData['rencana_diet_makanan'];
                        List makanans = currentData['makanans'];
                        var rencanaDietMinum =
                            currentData['rencana_diet_minum'];
                        var rencanaDietOlahraga =
                            currentData['rencana_diet_olahraga'];

                        // Build widget & data widget
                        // Rencana minum
                        statusMinum = statusMinumBuilder(
                            rencanaDietMinum.jumlahMinum,
                            rencanaDietMinum.progress);

                        // Rencana makan
                        listMakananCard = listMakananCardBuilder(
                          rencanaDietMakanan,
                          makanans,
                        );

                        // Rencana olahraga
                        statusOlahraga = {
                          "nama": rencanaDietOlahraga.nama,
                          "status": rencanaDietOlahraga.status == 2,
                        };
                      }

                      // Container page
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
                                        duration:
                                            const Duration(milliseconds: 500),
                                        curve: Curves.easeInOut);
                                  },
                                  icon: const Icon(Icons.arrow_circle_left),
                                ),
                                Text(formatter.format(thisPageDate)),
                                IconButton(
                                  onPressed: () {
                                    _pageViewController.nextPage(
                                        duration:
                                            const Duration(milliseconds: 500),
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
                                            isDone: index <
                                                statusMinum['progress']),
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
                                  .map<Widget>(
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
                            const SizedBox(height: 8),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return Column(
                    children: const [
                      Text('Loading...'),
                    ],
                  );
                }
              },
            ),

            // ExpandablePageView.builder(
            //   onPageChanged: (position) async {
            //     setState(() {
            //       index = position - 16;
            //       thisPageDate = DateTime(currentDate.year, currentDate.month,
            //           currentDate.day + index);
            //       futureRencanaDiet =
            //           getRencanaDiet(formatter.format(thisPageDate));
            //     });
            //   },
            //   controller: _pageViewController,
            //   itemCount: 31,
            //   itemBuilder: (context, position) {
            //     return FutureBuilder<Map<String, dynamic>>(
            //       future: futureRencanaDiet,
            //       builder: (context, snapshot) {
            //         if (snapshot.hasData) {
            //           Map<String, dynamic> data = snapshot.data!;

            //           // Cek rencana minum
            //           if (data.containsKey('rencana_diet_minum')) {
            //             var rencanaMinum = data['rencana_diet_minum'].data[0];
            //             statusMinum = statusMinumBuilder(
            //               rencanaMinum.jumlahMinum,
            //               rencanaMinum.progress,
            //             );
            //           }

            //           // Cek rencana makanan
            //           if (data.containsKey('rencana_diet_makanan') &&
            //               data.containsKey('makanans')) {
            //             listMakananCard = listMakananCardBuilder(
            //               data['rencana_diet_makanan'].data,
            //               data['makanans'].data,
            //             );
            //           } else {
            //             listMakananCard = listMakananCardBuilder([], []);
            //           }

            //           // cek rencana olahraga
            //           if (data.containsKey('rencana_diet_olahraga')) {
            //             var rencanaOlahraga =
            //                 data['rencana_diet_olahraga'].data[0];
            //             statusOlahraga = {
            //               "nama": rencanaOlahraga.nama,
            //               "status": rencanaOlahraga.status == 2,
            //             };
            //           }

            //           return Container(
            //             padding: const EdgeInsets.symmetric(horizontal: 24),
            //             child: Column(
            //               children: [
            //                 // Navigasi
            //                 Row(
            //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                   children: [
            //                     IconButton(
            //                       onPressed: () {
            //                         _pageViewController.previousPage(
            //                             duration:
            //                                 const Duration(milliseconds: 500),
            //                             curve: Curves.easeInOut);
            //                       },
            //                       icon: const Icon(Icons.arrow_circle_left),
            //                     ),
            //                     Text(formatter.format(thisPageDate)),
            //                     IconButton(
            //                       onPressed: () {
            //                         _pageViewController.nextPage(
            //                             duration:
            //                                 const Duration(milliseconds: 500),
            //                             curve: Curves.easeInOut);
            //                       },
            //                       icon: const Icon(Icons.arrow_circle_right),
            //                     ),
            //                   ],
            //                 ),

            //                 // Rencana minum air
            //                 Container(
            //                   decoration: BoxDecoration(
            //                     border: Border.all(
            //                       color: const Color.fromRGBO(127, 209, 174, 1),
            //                       width: 1,
            //                     ),
            //                     borderRadius: const BorderRadius.all(
            //                       Radius.circular(9),
            //                     ),
            //                   ),
            //                   child: GridView.builder(
            //                     physics: const NeverScrollableScrollPhysics(),
            //                     shrinkWrap: true,
            //                     itemCount: statusMinum['jumlah_minum'],
            //                     gridDelegate:
            //                         const SliverGridDelegateWithFixedCrossAxisCount(
            //                             crossAxisCount: 5),
            //                     itemBuilder: (context, index) {
            //                       return Padding(
            //                         padding: const EdgeInsets.all(4),
            //                         child: Center(
            //                           child: Container(
            //                             color: Colors.white,
            //                             child: CheckboxGelas(
            //                                 isDone: index <
            //                                     statusMinum['progress']),
            //                           ),
            //                         ),
            //                       );
            //                     },
            //                   ),
            //                 ),
            //                 const SizedBox(height: 8),

            //                 // List rencana makanan diet
            //                 Column(
            //                   children: listMakananCard
            //                       .map<Widget>(
            //                         (item) => Padding(
            //                           padding: const EdgeInsets.only(bottom: 8),
            //                           child: item,
            //                         ),
            //                       )
            //                       .toList(),
            //                 ),

            //                 // Karu olahraga
            //                 KartuOlahraga(
            //                   namaOlahraga: statusOlahraga['nama'],
            //                   isComplete: statusOlahraga['status'] == 1,
            //                 ),
            //                 const SizedBox(height: 8),
            //               ],
            //             ),
            //           );
            //         } else {
            //           return Column(
            //             children: const [
            //               SizedBox(height: 100),
            //               Text('Loading...'),
            //               SizedBox(height: 100),
            //             ],
            //           );
            //         }
            //       },
            //     );
            //   },
            // ),
          ],
        ),
      ),
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
