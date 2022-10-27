import 'package:flutter/material.dart';

class AirMinumPage extends StatelessWidget {
  final String fromPage;

  const AirMinumPage({
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
          children: const [Text('This is air minum page')],
        ),
      ),
    );
  }
}
