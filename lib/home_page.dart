import 'package:flutter/material.dart';
import 'package:mps/utils/habit_tiles.dart';
import 'utils/habit_tiles.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        title: Text('Consistency is the key'),
      ),
      body: Column(children: [
        HabitTile(habitName: 'Olahraga'),
        HabitTile(habitName: 'Makan'),
        HabitTile(habitName: 'Cuci baju'),
        HabitTile(habitName: 'Belajar'),
        HabitTile(habitName: 'Tidur'),
      ]),
    );
  }
}
