import 'dart:developer';

import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mps/app/controllers/pages/test_controller.dart';

class TestPage extends StatefulWidget {
  final ValueChanged<String> homeDate;

  const TestPage({super.key, required this.homeDate});

  @override
  State<TestPage> createState() => TestPageState();
}

class TestPageState extends State<TestPage> {
  PageController pageViewController = PageController(initialPage: 11);
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

  @override
  Widget build(BuildContext context) {
    return ExpandablePageView.builder(
      onPageChanged: (position) async {
        setState(() {
          index = position - 11;
          thisPageDate = DateTime(
              currentDate.year, currentDate.month, currentDate.day + index);
          widget.homeDate(formatter.format(thisPageDate));
          futureText = getRandomText(formatter.format(thisPageDate).toString());
        });
      },
      controller: pageViewController,
      itemCount: 21,
      itemBuilder: (context, position) {
        return FutureBuilder<String>(
          future: futureText,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              String data = snapshot.data!;
              inspect(data);
              return Container(
                padding: const EdgeInsets.only(left: 24, right: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 32),
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
