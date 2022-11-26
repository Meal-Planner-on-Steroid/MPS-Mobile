import 'package:flutter/material.dart';
import 'package:mps/main.dart';
import 'package:mps/utils/accordeon_rekomendasi_makanan/accordion_makanan.dart';

class HasilRekomendasiPage extends StatelessWidget {
  const HasilRekomendasiPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            // Tiga tombol
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Tombol pakai
                Expanded(
                  flex: 3,
                  child: SizedBox(
                    height: 64,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MyApp(),
                          ),
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Icon(
                          Icons.check_circle_rounded,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),

                // Tombol buat lagi / ulang
                const SizedBox(width: 8),
                Expanded(
                  flex: 3,
                  child: SizedBox(
                    height: 64,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.yellow.shade700,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                      ),
                      onPressed: () {
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(builder: (BuildContext context) {
                        //     return const HasilRekomendasiPage();
                        //   }),
                        // );
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Icon(
                          Icons.repeat,
                          size: 40,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),

                // Tombol batal
                const SizedBox(width: 8),
                Expanded(
                  flex: 3,
                  child: SizedBox(
                    height: 64,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromRGBO(255, 135, 101, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Icon(
                          Icons.cancel,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Status
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromRGBO(127, 209, 174, 1),
                  width: 2,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(9),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Status',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('IMT'),
                        Text('-'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Kebutuhan Energi'),
                        Text('-'),
                      ],
                    )
                  ],
                ),
              ),
            ),

            // Status gizi
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromRGBO(127, 209, 174, 1),
                  width: 2,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(9),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Kebutuhan Gizi',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Protein'),
                        Text('-'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Karbohidrat'),
                        Text('-'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Lemak'),
                        Text('-'),
                      ],
                    )
                  ],
                ),
              ),
            ),

            // List rekomendasi makanan
            const SizedBox(height: 16),
            const AccordionMakanan(),
          ],
        ),
      ),
    );
  }
}
