import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mps/app/controllers/pages/home_controller.dart';
import 'package:mps/app/controllers/pages/test_controller.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => TestPageState();
}

class TestPageState extends State<TestPage> {
  PageController pageViewController = PageController(initialPage: 16);
  final _testController = TestPageController();
  final _homeController = HomeController();

  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  // late Future<String> futureText;
  // late Future<List<String>> manyDummyData;
  // late Future<Map<String, dynamic>> futureListRencanaDiet;

  DateTime currentDate = DateTime.now();
  var thisPageDate = DateTime.now();
  var index = 0;

  List<String> dummyData = [
    'ISUJDJXXHN 1',
    'JEVZTDCXTF 2',
    'PKWJKRBAWZ 3',
    'ZSKLRXXHKD 4',
    'XDLMDCVCDK 5',
    'UPRYXAXKDI 6',
    'UUYPXZLOJT 7',
    'CHMZCAMDQQ 8',
    'NWIGCMWNXD 9',
    'OKODMRQONK 10',
    'ISUJDJXXHN 1',
    'JEVZTDCXTF 2',
    'PKWJKRBAWZ 3',
    'ZSKLRXXHKD 4',
    'XDLMDCVCDK 5',
    'UPRYXAXKDI 6',
    'UUYPXZLOJT 7',
    'CHMZCAMDQQ 8',
    'NWIGCMWNXD 9',
    'OKODMRQONK 10',
  ];

  Map<String, dynamic> dummyData2 = {
    '2022-12-01': {
      'text': 'text 1',
    },
    '2022-12-02': {
      'text': 'text 2',
    },
    '2022-12-03': {
      'text': 'text 3',
    },
    '2022-12-04': {
      'text': 'text 4',
    },
    '2022-12-05': {
      'text': 'text 5',
    },
    '2022-12-06': {
      'text': 'text 6',
    },
    '2022-12-07': {
      'text': 'text 7',
    },
    '2022-12-08': {
      'text': 'text 8',
    },
    '2022-12-09': {
      'text': 'text 9',
    },
    '2022-12-10': {
      'text': 'text 10',
    },
    '2022-12-11': {
      'text': 'text 11',
    },
    '2022-12-12': {
      'text': 'text 12',
    },
    '2022-12-13': {
      'text': 'text 13',
    },
    '2022-12-14': {
      'text': 'text 14',
    },
    '2022-12-15': {
      'text': 'text 15',
    },
    '2022-12-16': {
      'text': 'text 16',
    },
    '2022-12-17': {
      'text': 'text 17',
    },
    '2022-12-18': {
      'text': 'text 18',
    },
    '2022-12-19': {
      'text': 'text 19',
    },
    '2022-12-20': {
      'text': 'text 20',
    },
    '2022-12-21': {
      'text': 'text 21',
    },
    '2022-12-22': {
      'text': 'text 22',
    },
    '2022-12-23': {
      'text': 'text 23',
    },
    '2022-12-24': {
      'text': 'text 24',
    },
    '2022-12-25': {
      'text': 'text 25',
    },
    '2022-12-26': {
      'text': 'text 26',
    },
    '2022-12-27': {
      'text': 'text 27',
    },
    '2022-12-28': {
      'text': 'text 28',
    },
    '2022-12-29': {
      'text': 'text 29',
    },
    '2022-12-30': {
      'text': 'text 30',
    },
  };

  Future<Map<String, dynamic>> listRencanaDiet(String mulaiDariTanggal) async {
    return await _homeController.getSetRencanaDiet(mulaiDariTanggal);
  }

  Future<String> getRandomText() async {
    return await _testController.get();
  }

  @override
  void initState() {
    super.initState();

    // futureText = getRandomText(formatter.format(thisPageDate).toString());
    // manyDummyData = getManyRandomText(10);
    // futureListRencanaDiet = listRencanaDiet(formatter.format(
    //     DateTime(currentDate.year, currentDate.month, currentDate.day - 16)));
  }

  @override
  Widget build(BuildContext context) {
    // return FutureBuilder<Map<String, dynamic>>(
    //   future: futureListRencanaDiet,
    //   builder: (context, snapshot) {
    //     if (snapshot.hasData) {
    //       Map<String, dynamic> data = snapshot.data!;

    //       return ExpandablePageView.builder(
    //         controller: pageViewController,
    //         itemCount: 31,
    //         itemBuilder: (context, position) {
    //           debugPrint(position.toString());
    //           index = position - 16;
    //           thisPageDate = DateTime(
    //               currentDate.year, currentDate.month, currentDate.day + index);
    //           String dateKey = formatter.format(thisPageDate);

    //           if (data.containsKey(dateKey)) {
    //             return Column(
    //               children: [
    //                 Text("current position $position"),
    //                 Text("current date $dateKey"),
    //                 const SizedBox(height: 8),
    //                 const Text("Dummy text"),
    //                 Text(data[dateKey]['rencana_diet'].id.toString()),
    //                 Text(data[dateKey]['rencana_diet'].tanggal.toString()),
    //               ],
    //             );
    //           } else {
    //             return Column(
    //               children: [
    //                 const Text('Sudah tidak ada data'),
    //                 Text(dateKey.toString()),
    //                 Text(data.containsKey(dateKey).toString()),
    //               ],
    //             );
    //           }
    //         },
    //       );

    //       // return Container(
    //       //   child: Text(data['rencana_diet'][0].tanggal.toString()),
    //       // );
    //     } else {
    //       return Column(
    //         children: const [
    //           Text('Loading'),
    //         ],
    //       );
    //     }
    //   },
    // );
    return ExpandablePageView.builder(
      controller: pageViewController,
      itemCount: 31,
      itemBuilder: (context, position) {
        // debugPrint(position.toString());
        index = position - 16;
        thisPageDate = DateTime(
            currentDate.year, currentDate.month, currentDate.day + index);
        String dateKey = formatter.format(thisPageDate);

        if (dummyData2.containsKey(dateKey)) {
          return Column(
            children: [
              Text("current position $position"),
              Text("current date $dateKey"),
              const SizedBox(height: 8),
              const Text("Dummy text"),
              Text(dummyData2[dateKey]['text']),
            ],
          );
        } else {
          return Column(
            children: const [
              Text('Sudah tidak ada data'),
            ],
          );
        }
      },
    );
    // return ExpandablePageView.builder(
    //   controller: pageViewController,
    //   itemCount: 31,
    //   itemBuilder: (context, position) {
    //     if (position >= dummyData.length) {
    //       return Column(
    //         children: const [
    //           Text("Sudah tidak ada data"),
    //         ],
    //       );
    //     } else {
    //       debugPrint(position.toString());
    //       return Column(
    //         children: [
    //           Text("current position $position"),
    //           Text(dummyData[position]),
    //         ],
    //       );
    //     }
    //   },
    // );
    // return FutureBuilder<List<String>>(
    //   future: manyDummyData,
    //   builder: (context, snapshot) {
    //     if (snapshot.hasData) {
    //       var dummy = snapshot.data!;

    //       return ExpandablePageView.builder(
    //         controller: pageViewController,
    //         itemCount: 31,
    //         itemBuilder: (context, position) {
    //           debugPrint(position.toString());
    //           return Column(
    //             children: [
    //               Text(dummy[position]),
    //             ],
    //           );
    //         },
    //       );
    //     } else {
    //       return const Text('Loading...');
    //     }
    //   },
    // );

    // return ExpandablePageView.builder(
    //   onPageChanged: (position) async {
    //     setState(() {
    //       index = position - 11;
    //       thisPageDate = DateTime(
    //           currentDate.year, currentDate.month, currentDate.day + index);
    //       futureText = getRandomText(formatter.format(thisPageDate).toString());
    //     });
    //   },
    //   controller: pageViewController,
    //   itemCount: 21,
    //   itemBuilder: (context, position) {
    //     return FutureBuilder<String>(
    //       future: futureText,
    //       builder: (context, snapshot) {
    //         if (snapshot.hasData) {
    //           String data = snapshot.data!;
    //           inspect(data);
    //           return Container(
    //             padding: const EdgeInsets.only(left: 24, right: 24),
    //             child: Column(
    //               children: [
    //                 const SizedBox(height: 32),
    //                 Text('Current position $position'),
    //                 Text('Current index $index'),
    //                 Text('Current date ${formatter.format(currentDate)}'),
    //                 Text('This page date ${formatter.format(thisPageDate)}'),
    //                 const Text('the random text bellow'),
    //                 Text(data),
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
    // );
  }
}
