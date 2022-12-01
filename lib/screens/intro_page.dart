import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  // Controller page
  final PageController _introScreenController = PageController();

  List<Widget> pageViewItems = [
    Container(
      color: Colors.red,
    ),
    Container(
      color: Colors.yellow,
    ),
    Container(
      color: Colors.green,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        // Pageview
        PageView(
          controller: _introScreenController,
          children: pageViewItems.map((item) => item).toList(),
        ),

        // Indikator
        Container(
          alignment: const Alignment(0, 0.8),
          child: SmoothPageIndicator(
              controller: _introScreenController, count: pageViewItems.length),
        ),
      ],
    ));
  }
}
