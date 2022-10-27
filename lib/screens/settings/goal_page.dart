import 'package:flutter/material.dart';

class GoalPage extends StatelessWidget {
  final String fromPage;

  const GoalPage({
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
          children: const [Text('This is goal page')],
        ),
      ),
    );
  }
}
