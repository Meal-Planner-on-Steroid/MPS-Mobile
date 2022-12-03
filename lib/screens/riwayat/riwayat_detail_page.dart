import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:mps/app/controllers/pages/riwayat_detail_controller.dart';
import 'package:mps/app/models/page/riwayat_detail_model.dart';
import 'package:mps/screens/riwayat/accordeon_makanan.dart';
import 'package:mps/utils/coming_soon_dialog.dart';

class RiwayatDetailpage extends StatefulWidget {
  final int riwayatId;
  const RiwayatDetailpage({
    Key? key,
    required this.riwayatId,
  }) : super(key: key);

  @override
  State<RiwayatDetailpage> createState() => _RiwayatDetailpageState();
}

class _RiwayatDetailpageState extends State<RiwayatDetailpage> {
  final _riwayatDetailController = RiwayatDetailController();

  late Future<RiwayatDetail> riwayatDetailFuture;
  late Future<int> damnFuture;

  Future<RiwayatDetail> getThisRiwayatDetail(int id) async {
    var response = await _riwayatDetailController.getObject(id.toString());
    return response;
  }

  Future<int> getNumber() async {
    await Future.delayed(const Duration(seconds: 1));

    return 2;
  }

  @override
  void initState() {
    super.initState();

    riwayatDetailFuture = getThisRiwayatDetail(widget.riwayatId);
    damnFuture = getNumber();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Riwayat id adalah: ${widget.riwayatId}");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Kembali'),
        actions: [
          TextButton(
            onPressed: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => const ComingSoonDialog(),
            ),
            child: Row(
              children: const [
                Text(
                  'Share',
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(width: 4),
                Icon(
                  Icons.share,
                  color: Colors.black,
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => const ComingSoonDialog(),
            ),
            child: Row(
              children: const [
                Text(
                  'Export',
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(width: 4),
                Icon(
                  Icons.save,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: FutureBuilder<RiwayatDetail>(
            future: riwayatDetailFuture,
            builder: (context, snapshot) {
              if (!snapshot.hasData ||
                  snapshot.connectionState != ConnectionState.done) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    GFLoader(
                      type: GFLoaderType.circle,
                    ),
                    SizedBox(height: 24),
                    Center(child: Text('Proses memuat riwayat makanan')),
                  ],
                );
              } else if (snapshot.hasError) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: SizedBox(
                        height: 160,
                        child: Image.asset('assets/images/manhera_cry.jpg'),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Center(child: Text('Gagal memuat riwayat makanan')),
                  ],
                );
              }

              var data = snapshot.data!;
              var riwayatRekomendasi = data.riwayatRekomendasi.data;
              var rekomendasiRencana = data.rekomendasiRencana.data;
              var rekomendasiMakanan = data.rekomendasiMakanan.data;
              var makanans = data.makanan.data;

              // inspect(rekomendasiRencana);

              return ListView(
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
                            children: [
                              const Text('IMT'),
                              Text(riwayatRekomendasi.imt!.toStringAsFixed(2)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Kebutuhan Energi'),
                              Row(
                                children: [
                                  Text(riwayatRekomendasi.keseluruhanEnergi!
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
                                  Text(riwayatRekomendasi
                                      .butuhProtein!.protein10!
                                      .toStringAsFixed(2)),
                                  const Text(' - '),
                                  Text(riwayatRekomendasi
                                      .butuhProtein!.protein15!
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
                                  Text(riwayatRekomendasi.butuhKarbo!.karbo60!
                                      .toStringAsFixed(2)),
                                  const Text(' - '),
                                  Text(riwayatRekomendasi.butuhKarbo!.karbo75!
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
                                  Text(riwayatRekomendasi.butuhLemak!.lemak10!
                                      .toStringAsFixed(2)),
                                  const Text(' - '),
                                  Text(riwayatRekomendasi.butuhLemak!.lemak25!
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

                  // Accordeon makanan
                  const SizedBox(height: 16),
                  AccordionMakanan(
                    rekomendasiRencana: rekomendasiRencana,
                    rekomendasiMakanan: rekomendasiMakanan,
                    makanans: makanans,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );

    // return Scaffold(
    //   backgroundColor: Colors.white,
    //   appBar: AppBar(
    //     title: const Text('Riwayat'),
    //   ),
    //   body: SafeArea(
    //     child: ListView(
    //       padding: const EdgeInsets.all(24),
    //       children: [
    //         // Status pengguna
    //         Container(
    //           decoration: BoxDecoration(
    //             border: Border.all(
    //               color: const Color.fromRGBO(127, 209, 174, 1),
    //               width: 2,
    //             ),
    //             borderRadius: const BorderRadius.all(
    //               Radius.circular(9),
    //             ),
    //           ),
    //           child: Padding(
    //             padding: const EdgeInsets.all(16),
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 const Text(
    //                   'Status',
    //                   style: TextStyle(
    //                     fontWeight: FontWeight.bold,
    //                   ),
    //                 ),
    //                 const SizedBox(height: 8),
    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: const [
    //                     Text('IMT'),
    //                     Text('-'),
    //                   ],
    //                 ),
    //                 const SizedBox(height: 8),
    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: const [
    //                     Text('Kebutuhan Energi'),
    //                     Text('-'),
    //                   ],
    //                 )
    //               ],
    //             ),
    //           ),
    //         ),

    //         // Status gizi
    //         const SizedBox(height: 16),
    //         Container(
    //           decoration: BoxDecoration(
    //             border: Border.all(
    //               color: const Color.fromRGBO(127, 209, 174, 1),
    //               width: 2,
    //             ),
    //             borderRadius: const BorderRadius.all(
    //               Radius.circular(9),
    //             ),
    //           ),
    //           child: Padding(
    //             padding: const EdgeInsets.all(16),
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 const Text(
    //                   'Kebutuhan Gizi',
    //                   style: TextStyle(
    //                     fontWeight: FontWeight.bold,
    //                   ),
    //                 ),
    //                 const SizedBox(height: 8),
    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: const [
    //                     Text('Protein'),
    //                     Text('-'),
    //                   ],
    //                 ),
    //                 const SizedBox(height: 8),
    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: const [
    //                     Text('Karbohidrat'),
    //                     Text('-'),
    //                   ],
    //                 ),
    //                 const SizedBox(height: 8),
    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: const [
    //                     Text('Lemak'),
    //                     Text('-'),
    //                   ],
    //                 )
    //               ],
    //             ),
    //           ),
    //         ),

    //         // Accordeon makanan
    //         const SizedBox(height: 16),
    //         const AccordionMakanan(riwayatId: 1),
    //       ],
    //     ),
    //   ),
    // );
  }
}
