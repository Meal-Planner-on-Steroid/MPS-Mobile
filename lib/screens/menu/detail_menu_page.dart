import 'package:flutter/material.dart';
import 'package:mps/app/controllers/pages/detail_menu_controller.dart';
import 'package:mps/app/models/detail_menu_model.dart';

class DetailMenuPage extends StatefulWidget {
  final int makananId;
  const DetailMenuPage({
    Key? key,
    required this.makananId,
  }) : super(key: key);

  @override
  State<DetailMenuPage> createState() => _DetailMenuPageState();
}

class _DetailMenuPageState extends State<DetailMenuPage> {
  final _detailMenuController = DetailMenuController();

  late Future<DetailMenu> detailMenuFuture;

  Future<DetailMenu> getThisMenuDetail(int id) async {
    var response = await _detailMenuController.getObject(id.toString());
    return response;
  }

  @override
  void initState() {
    super.initState();

    detailMenuFuture = getThisMenuDetail(widget.makananId);
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('makanan id: ${widget.makananId}');
    return Scaffold(
      appBar: AppBar(title: const Text('Kembali')),
      body: SafeArea(
        child: FutureBuilder<DetailMenu>(
          future: detailMenuFuture,
          builder: (context, snapshot) {
            if (!snapshot.hasData ||
                snapshot.connectionState != ConnectionState.done) {
              return const Text('memuat data makanan');
            } else if (snapshot.hasError) {
              return const Text('Gagal memuat makanan');
            }

            var result = snapshot.data!;
            var makanan = result.makanan.data;
            var satuan = result.satuan.data;

            // return Text(makanan.nama);
            return ListView(
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
                        children: [
                          Text(
                            makanan.nama,
                            style: const TextStyle(
                              fontSize: 24,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text("${makanan.porsi} ${satuan.nama}"),
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
                              children: [
                                Text('${makanan.energi} kcal'),
                                const Text('Energi'),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('${makanan.protein} g'),
                                const Text('Protein'),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('${makanan.karbo} g'),
                                const Text('Karbo'),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('${makanan.lemak} g'),
                                const Text('Lemak'),
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
            );
          },
        ),
      ),
    );
  }
}
