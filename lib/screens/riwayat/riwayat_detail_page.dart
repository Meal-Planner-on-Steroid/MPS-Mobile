import 'package:flutter/material.dart';
import 'package:mps/screens/riwayat/accordeon_makanan.dart';

class RiwayatDetailpage extends StatefulWidget {
  const RiwayatDetailpage({Key? key}) : super(key: key);

  @override
  State<RiwayatDetailpage> createState() => _RiwayatDetailpageState();
}

class _RiwayatDetailpageState extends State<RiwayatDetailpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Riwayat'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            // Status pengguna
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

            // Accordeon makanan
            const SizedBox(height: 16),
            const AccordionMakanan(riwayatId: 1),
          ],
        ),
      ),
    );
  }
}
