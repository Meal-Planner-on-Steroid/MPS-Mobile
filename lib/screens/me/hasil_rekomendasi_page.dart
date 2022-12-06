import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:mps/app/controllers/modules/generate_rekomendasi_menu_controller.dart';
import 'package:mps/app/controllers/pages/hasil_rekomendasi_controller.dart';
import 'package:mps/app/serializers/generate_rekomendasi_menu_serializer.dart';
import 'package:mps/main.dart';
import 'package:mps/utils/accordeon_rekomendasi_makanan/accordion_makanan.dart';

class HasilRekomendasiPage extends StatefulWidget {
  const HasilRekomendasiPage({Key? key}) : super(key: key);

  @override
  State<HasilRekomendasiPage> createState() => _HasilRekomendasiPageState();
}

class _HasilRekomendasiPageState extends State<HasilRekomendasiPage> {
  final _generateRekomendasiMakananController =
      GenerateRekomendasiMenuController();
  final _hasilRekomendasiController = HasilRekomendasiController();

  late Future<GenerateRekomendasiMenuSerializer> hasilRekomendasiMenu;

  @override
  void initState() {
    super.initState();

    hasilRekomendasiMenu = generateRekomendasiMenu();
  }

  Future<GenerateRekomendasiMenuSerializer> generateRekomendasiMenu() async {
    try {
      var response = await _generateRekomendasiMakananController.post();
      return response;
    } catch (e) {
      return Future.error('error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<GenerateRekomendasiMenuSerializer>(
      future: hasilRekomendasiMenu,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: const [
                        GFLoader(
                          type: GFLoaderType.circle,
                        ),
                        SizedBox(height: 16),
                        Text('Membuat rekomendasi menu makanan diet untukmu'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          // Permintaan maaf
                          SizedBox(
                            height: 160,
                            child: Image.asset('assets/images/manhera_cry.jpg'),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                              'Yah ... Gagal membuat rekomendasi buat kamu 😭'),

                          // Tombol kembali
                          const SizedBox(height: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: const StadiumBorder(),
                                  primary:
                                      const Color.fromRGBO(127, 209, 174, 1),
                                ),
                                onPressed: () async {
                                  Navigator.pop(context);
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(11.0),
                                  child: Text(
                                    'Kembali',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        var data = snapshot.data!.data;
        var statusGizi = data!.kebutuhanGizi;
        var rekomendasiMakanan = data.rekomendasiMakanan;

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
                    // Tombol pakai / setuju
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
                          onPressed: () async {
                            if (await _hasilRekomendasiController.post(
                                statusGizi, rekomendasiMakanan)) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MyApp(),
                                ),
                              );
                            } else {
                              const AlertDialog(
                                title: Text('Berhasil'),
                              );
                            }
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
                            setState(() {
                              hasilRekomendasiMenu = generateRekomendasiMenu();
                            });
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
                          children: [
                            const Text('IMT'),
                            Text(statusGizi.imt!.toStringAsFixed(2)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Kebutuhan Energi'),
                            Row(
                              children: [
                                Text(statusGizi.keseluruhanEnergi!
                                    .toStringAsFixed(2)),
                                const Text(' kcal'),
                              ],
                            )
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
                          children: [
                            const Text('Protein'),
                            Row(
                              children: [
                                Text(statusGizi.butuhProtein!.protein10!
                                    .toStringAsFixed(2)),
                                const Text(' - '),
                                Text(statusGizi.butuhProtein!.protein15!
                                    .toStringAsFixed(2)),
                                const Text(' g'),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Karbohidrat'),
                            Row(
                              children: [
                                Text(statusGizi.butuhKarbo!.karbo60!
                                    .toStringAsFixed(2)),
                                const Text(' - '),
                                Text(statusGizi.butuhKarbo!.karbo75!
                                    .toStringAsFixed(2)),
                                const Text(' g'),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Lemak'),
                            Row(
                              children: [
                                Text(statusGizi.butuhLemak!.lemak10!
                                    .toStringAsFixed(2)),
                                const Text(' - '),
                                Text(statusGizi.butuhLemak!.lemak25!
                                    .toStringAsFixed(2)),
                                const Text(' g'),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),

                // List rekomendasi makanan
                const SizedBox(height: 16),
                AccordionMakanan(data: rekomendasiMakanan),
              ],
            ),
          ),
        );
      },
    );
  }

  waitDialog() {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) =>
          FutureBuilder<GenerateRekomendasiMenuSerializer>(
        future: generateRekomendasiMenu(),
        builder: (context, snapshot) {
          if (!snapshot.hasData ||
              snapshot.connectionState != ConnectionState.done) {
            return const AlertDialog(
              title: Text('Membuat rekomendasi menu makanan diet'),
              content: GFLoader(
                type: GFLoaderType.circle,
              ),
            );
          } else if (snapshot.hasError) {
            return AlertDialog(
              title: const Text('Gagal membuat rekomendasi menu makanan'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text(
                    'OK',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            );
          }

          return AlertDialog(
            title: const Text('Berhasil'),
            content: const Text('Berhasil membuat rekomendasi makanan'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text(
                  'OK',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
