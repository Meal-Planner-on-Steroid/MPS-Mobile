import 'package:flutter/material.dart';

class DetailMenuPage extends StatefulWidget {
  const DetailMenuPage({Key? key}) : super(key: key);

  @override
  State<DetailMenuPage> createState() => _DetailMenuPageState();
}

class _DetailMenuPageState extends State<DetailMenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kembali'),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Stack(alignment: Alignment.bottomCenter, children: [
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/makanan_random.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                height: 200,
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(22),
                    topRight: Radius.circular(22),
                  ),
                ),
                height: 30,
              )
            ]),
            Column(
              children: [
                // Heading
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: Column(
                    children: const [
                      Text(
                        'Caramel toast',
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text('1 porsi'),
                    ],
                  ),
                ),

                // Nilai gizi
                const SizedBox(height: 16),
                Container(
                  height: 72,
                  color: const Color.fromRGBO(225, 219, 214, 1),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 24, left: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text('400 kcal'),
                            Text('Energi'),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text('100 g'),
                            Text('Protein'),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text('100 g'),
                            Text('Karbo'),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text('100 g'),
                            Text('Lemak'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                // Bahan
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Bahan',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text('- Bahan 1'),
                        SizedBox(height: 8),
                        Text('- Bahan 2'),
                        SizedBox(height: 8),
                        Text('- Bahan 3'),
                        SizedBox(height: 8),
                        Text('- Bahan 4'),
                        SizedBox(height: 8),
                        Text('- Bahan 5'),
                        SizedBox(height: 8),
                        Text('- Bahan 6'),
                        SizedBox(height: 8),
                        Text('- Bahan 7'),
                        SizedBox(height: 8),
                        Text('- Bahan 8'),
                        SizedBox(height: 8),
                        Text('- Bahan 9'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
