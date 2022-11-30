import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:mps/app/controllers/pages/riwayat_detail_controller.dart';
import 'package:mps/app/models/page/riwayat_detail_model.dart';
import 'package:mps/screens/riwayat/accordeon_makanan.dart';

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

  // late Future<RiwayatDetail> riwayatDetailFuture;
  late Future<int> damnFuture;

  // Future<RiwayatDetail> getThisRiwayatDetail(int id) async {
  //   var response = await _riwayatDetailController.getObject(id.toString());
  //   return response;
  // }

  Future<int> getNumber() async {
    await Future.delayed(const Duration(seconds: 1));

    return 2;
  }

  @override
  void initState() {
    super.initState();

    // riwayatDetailFuture = getThisRiwayatDetail(widget.riwayatId);
    damnFuture = getNumber();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Riwayat id adalah: ${widget.riwayatId}");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Kembali'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: FutureBuilder<int>(
            future: damnFuture,
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

              return ListView(
                children: const [
                  Text('Berhasil'),
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
