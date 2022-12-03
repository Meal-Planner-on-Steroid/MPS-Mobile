import 'package:flutter/material.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:intl/intl.dart';
import 'package:mps/app/controllers/pages/test_controller.dart';
import '../makanan_card.dart';
import 'slider_rencana_diet_page.dart';

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

  // List<ListRencanaDiet> listRencanaDiet = [
  //   ListRencanaDiet(
  //     hari: 'hari',
  //     body: const [
  //       MakananCard(beChecked: true),
  //       MakananCard(beChecked: true),
  //       MakananCard(beChecked: true),
  //       MakananCard(beChecked: true),
  //       MakananCard(beChecked: true),
  //     ],
  //   ),
  //   ListRencanaDiet(
  //     hari: 'hari',
  //     body: const [
  //       MakananCard(beChecked: true),
  //       MakananCard(beChecked: true),
  //       MakananCard(beChecked: true),
  //       MakananCard(beChecked: true),
  //       MakananCard(beChecked: true),
  //     ],
  //   ),
  //   ListRencanaDiet(
  //     hari: 'hari',
  //     body: const [
  //       MakananCard(beChecked: true),
  //       MakananCard(beChecked: true),
  //       MakananCard(beChecked: true),
  //       MakananCard(beChecked: true),
  //       MakananCard(beChecked: true),
  //     ],
  //   ),
  // ];

  @override
  Widget build(BuildContext context) {
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
                    const SizedBox(height: 16),
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

    // return ExpandablePageView(
    //   controller: _pageController,
    //   children: listRencanaDiet
    //       .map(
    //         (item) => SliderRencanaDietPage(
    //           hari: item.hari,
    //           makanans: item.body,
    //           controller: _pageController,
    //         ),
    //       )
    //       .toList(),
    // );
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
