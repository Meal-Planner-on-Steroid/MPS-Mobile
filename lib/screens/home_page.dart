import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../utils/avatar_dan_setting.dart';
import '../utils/home/goal_hari.dart';
import '../utils/home/slider_rencana_diet.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _homeDate = DateFormat('yyy-MM-dd').format(DateTime.now()).toString();

  void _updateHomeDate(String homeDate) {
    setState(() {
      _homeDate = homeDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {});
        },
        child: const Icon(Icons.refresh),
      ),
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
                children: const [
                  AvatarDanSetting(currentPage: 'Home'),

                  // Dropdown status
                  SizedBox(height: 16),
                  GoalHariIni(),
                ],
              ),
            ),

            // Slider
            const SizedBox(height: 16),
            Center(child: Text(_homeDate)),
            // const SizedBox(height: 16),
            SliderRencanaDiet(homeDate: _updateHomeDate),
            // TestPage(homeDate: _updateHomeDate),
          ],
        ),
      ),
    );
  }
}
