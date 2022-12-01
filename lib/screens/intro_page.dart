import 'package:flutter/material.dart';
import 'package:mps/main.dart';
import 'package:mps/screens/intro_page_item/intro_item_1.dart';
import 'package:mps/screens/intro_page_item/intro_item_3.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'intro_page_item/intro_item_2.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  // Controller page
  final PageController _introScreenController = PageController();

  bool _alreadySubmit = false;
  bool _onLastPage = false;

  void _updateSubmit(bool alreadySubmit) {
    setState(() {
      _alreadySubmit = alreadySubmit;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pageViewItems = [
      const IntroPage1(),
      const IntroPage2(),
      IntroPage3(update: _updateSubmit),
    ];

    return Scaffold(
        body: Stack(
      children: [
        // Pageview
        PageView(
          onPageChanged: (index) {
            setState(() {
              _onLastPage = (index == pageViewItems.length - 1);
            });
          },
          controller: _introScreenController,
          children: pageViewItems.map((item) => item).toList(),
        ),

        // Indikator
        Container(
          alignment: const Alignment(0, 0.85),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Skip
              GestureDetector(
                onTap: () {
                  _introScreenController.jumpToPage(2);
                },
                child: const Text('Skip'),
              ),

              // Indikator dot
              SmoothPageIndicator(
                  controller: _introScreenController,
                  count: pageViewItems.length),

              // Next or done
              _onLastPage
                  ? _alreadySubmit
                      ? GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const RootPage();
                                },
                              ),
                            );
                          },
                          child: const Text('Done'),
                        )
                      : GestureDetector(
                          child: Text(
                            'Done',
                            style: TextStyle(color: Colors.grey.shade400),
                          ),
                        )
                  : GestureDetector(
                      onTap: () {
                        _introScreenController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                        );
                      },
                      child: const Text('Next'),
                    )
            ],
          ),
        ),
      ],
    ));
  }
}
