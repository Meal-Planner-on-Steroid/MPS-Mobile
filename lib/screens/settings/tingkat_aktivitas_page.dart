import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class TingkatAktivitasInfo extends StatelessWidget {
  final String fromPage;
  const TingkatAktivitasInfo({
    super.key,
    required this.fromPage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(fromPage),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.shade300,
                  width: 2,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(9),
                ),
              ),
              child: const GFListTile(
                titleText: 'Sangat ringan',
                subTitleText:
                    'Aktivitas fisik yang sangat sedikit atau bahkan tidak ada, seperti duduk atau tidur sepanjang hari ',
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.shade300,
                  width: 2,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(9),
                ),
              ),
              child: const GFListTile(
                titleText: 'Ringan',
                subTitleText:
                    'Aktivitas fisik yang melibatkan pergerakan tubuh ringan selama sebagian besar hari, seperti berdiri atau berjalan di sekitar rumah atau kantor.',
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.shade300,
                  width: 2,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(9),
                ),
              ),
              child: const GFListTile(
                titleText: 'Sedang',
                subTitleText:
                    'Aktivitas fisik yang melibatkan pergerakan tubuh sedang selama sebagian besar hari, seperti berjalan cepat, bersepeda, atau melakukan pekerjaan rumah tangga.',
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.shade300,
                  width: 2,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(9),
                ),
              ),
              child: const GFListTile(
                titleText: 'Berat',
                subTitleText:
                    'Aktivitas fisik yang melibatkan pergerakan tubuh berat selama sebagian besar hari, seperti bekerja di lapangan atau melakukan olahraga intensitas tinggi secara teratur.',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
