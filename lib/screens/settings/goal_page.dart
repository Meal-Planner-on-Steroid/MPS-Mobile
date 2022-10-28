import 'package:flutter/material.dart';
import 'package:mps/utils/big_checkbox_btn.dart';

// ignore: must_be_immutable
class GoalPage extends StatelessWidget {
  final String fromPage;

  List<ListGoal> listGoal = [
    ListGoal(title: 'Otomatis', selected: true),
    ListGoal(title: 'Turun Berat Badan', selected: false),
    ListGoal(title: 'Pertahankan Berat', selected: false),
    ListGoal(title: 'Naik Berat Badan', selected: false),
  ];

  GoalPage({
    Key? key,
    required this.fromPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(fromPage),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: listGoal
              .map(
                (item) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: BigCheckboxBtn(
                    selected: item.selected,
                    title: item.title,
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class ListGoal {
  final String title;
  final bool selected;

  ListGoal({
    required this.title,
    required this.selected,
  });
}
