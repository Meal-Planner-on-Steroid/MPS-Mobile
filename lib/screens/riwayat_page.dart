import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:mps/app/controllers/modules/riwayat_rekomendasi_rencana_diet_controller.dart';
import 'package:mps/app/filters/riwayat_rekomendasi_rencana_diet_filter.dart';
import 'package:mps/app/serializers/riwayat_rekomendasi_rencana_diet_serializer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/riwayat/riwayat_item.dart';

class RiwayatPage extends StatefulWidget {
  const RiwayatPage({Key? key}) : super(key: key);

  @override
  State<RiwayatPage> createState() => _RiwayatPageState();
}

class _RiwayatPageState extends State<RiwayatPage> {
  final _riwayatRekomendasiRencanaDietController =
      RiwayatRekomendasiRencanaDietController();

  late Future<RiwayatRekomendasiRencanaDietSerializer> listRiwayatFuture;

  Future<RiwayatRekomendasiRencanaDietSerializer> getListRiwayatFuture() async {
    final prefs = await SharedPreferences.getInstance();

    var riwayatFilter = RiwayatRekomendasiRencanaDietFilter();
    riwayatFilter.userId = prefs.getString('userId');
    riwayatFilter.orderBy = '-created_at';

    var response =
        await _riwayatRekomendasiRencanaDietController.get(riwayatFilter);
    return response;
  }

  @override
  void initState() {
    super.initState();

    listRiwayatFuture = getListRiwayatFuture();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: FutureBuilder<RiwayatRekomendasiRencanaDietSerializer>(
          future: listRiwayatFuture,
          builder: (context, snapshot) {
            if (!snapshot.hasData ||
                snapshot.connectionState != ConnectionState.done) {
              return Padding(
                padding: const EdgeInsets.only(top: 24),
                child: Column(
                  children: const [
                    GFLoader(
                      type: GFLoaderType.circle,
                    ),
                    SizedBox(height: 24),
                    Text('Memuat riwayat rekomendasi rencana diet'),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Padding(
                padding: const EdgeInsets.only(top: 24),
                child: Column(
                  children: const [
                    Text('Gagal memuat riwayat rekomendasi rencana diet'),
                  ],
                ),
              );
            }
            var data = snapshot.data!.data;

            return ListView(
              padding: const EdgeInsets.all(24),
              children: data
                  .map<Widget>(
                    (item) => Column(
                      children: [
                        RiwayatItem(
                            title: DateTime.parse(item.createdAt).toString(),
                            riwayatId: item.id),
                        const SizedBox(height: 16),
                      ],
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ),
    );
  }
}
