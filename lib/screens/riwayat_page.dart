import 'package:flutter/material.dart';
import '../utils/riwayat/riwayat_item.dart';

class RiwayatPage extends StatefulWidget {
  const RiwayatPage({Key? key}) : super(key: key);

  @override
  State<RiwayatPage> createState() => _RiwayatPageState();
}

class _RiwayatPageState extends State<RiwayatPage> {
  List<ListRiwayat> listRiwayat = [
    const ListRiwayat(title: '21/05/2006'),
    const ListRiwayat(title: '22/05/2006'),
    const ListRiwayat(title: '23/05/2006'),
    const ListRiwayat(title: '24/05/2006'),
    const ListRiwayat(title: '25/05/2006'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: listRiwayat
              .map(
                (item) => Column(
                  children: [
                    RiwayatItem(title: item.title),
                    const SizedBox(height: 16),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class ListRiwayat {
  final String title;

  const ListRiwayat({
    required this.title,
  });
}
