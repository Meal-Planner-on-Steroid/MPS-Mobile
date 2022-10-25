import 'package:flutter/material.dart';
import '../utils/avatar_dan_setting.dart';

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
          ],
        ),
      ),
    );
  }
}
