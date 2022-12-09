import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:mps/app/controllers/modules/riwayat_rekomendasi_rencana_diet_controller.dart';
import 'package:mps/app/filters/riwayat_rekomendasi_rencana_diet_filter.dart';
import 'package:mps/app/serializers/riwayat_rekomendasi_rencana_diet_serializer.dart';
import 'package:mps/utils/coming_soon_dialog.dart';
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
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

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
      appBar: AppBar(
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
      backgroundColor: Colors.white,
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
                            title:
                                "Rekomendasi - ${formatter.format(DateTime.parse(item.createdAt))}",
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
