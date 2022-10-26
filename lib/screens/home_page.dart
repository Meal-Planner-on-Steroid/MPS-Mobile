import 'package:flutter/material.dart';
import '../utils/avatar_dan_setting.dart';
import '../utils/home/goal_hari.dart';
import '../utils/home/slider_rencana_diet.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: const [
            AvatarDanSetting(currentPage: 'Home'),

            // Dropdown status
            SizedBox(height: 16),
            GoalHariIni(),

            // Slider
            SizedBox(height: 16),
            // ignore: todo
            // TODO: Buat padding khusus di slider page
            SliderRencanaDiet(),
          ],
        ),
      ),
    );
  }
}
