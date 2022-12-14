import 'package:flutter/material.dart';
import 'package:mps/app/controllers/modules/makanan_controller.dart';
import 'package:mps/app/controllers/modules/preferensi_makanan_controller.dart';
import 'package:mps/app/filters/makanan_filter.dart';
import 'package:mps/app/filters/preferensi_makanan_filter.dart';
import 'package:mps/screens/menu/detail_menu_page.dart';
import 'package:mps/utils/checkbox_makanan_blok.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MakananBlokListPage extends StatefulWidget {
  final String judul;
  final String jenis;

  const MakananBlokListPage({
    Key? key,
    required this.judul,
    required this.jenis,
  }) : super(key: key);

  @override
  State<MakananBlokListPage> createState() => _MakananBlokListPageState();
}

class _MakananBlokListPageState extends State<MakananBlokListPage> {
  final _makananController = MakananController();
  final _preferensiMakananController = PreferensiMakananController();

  var makananFilter = MakananFilter();
  var preferensiMakananFilter = PreferensiMakananFilter();

  final controller = TextEditingController();
  var makananScrollController = ScrollController();
  List<dynamic> makanans = [];
  List<int> preferensiMakananIdList = [];

  late Future<List<dynamic>> makananListFuture;

  Future<List<dynamic>> getAndUpdateMakananList(
      MakananFilter makananFilter) async {
    makananFilter.jenis = widget.jenis;
    var request = await _makananController.get(makananFilter);
    makanans += request.data;
    return request.data;
  }

  Future<List<dynamic>> getPreferensiMakanan(
      PreferensiMakananFilter preferensiMakananFilter) async {
    final prefs = await SharedPreferences.getInstance();
    preferensiMakananFilter.userId = prefs.getString('userId');
    preferensiMakananFilter.jenis = 'BL';

    var request =
        await _preferensiMakananController.get(preferensiMakananFilter);

    return request.data;
  }

  Future<List<int>> makeListMakananIds() async {
    List listPreferensiMakanan =
        await getPreferensiMakanan(preferensiMakananFilter);
    List<int> result = [];
    for (var item in listPreferensiMakanan) {
      result.add(item.makananId);
    }

    preferensiMakananIdList = result;

    return result;
  }

  @override
  void initState() {
    super.initState();

    makananListFuture = getAndUpdateMakananList(makananFilter);
    makeListMakananIds();
    makananScrollController = ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // Search box
        Container(
          color: Colors.white,
          padding: const EdgeInsets.only(top: 16, left: 12, right: 12),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: 'Nama ${widget.judul}',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(22),
                // borderSide: const
              ),
            ),
            onChanged: searchMakanan,
          ),
        ),

        // List makanan
        const SizedBox(height: 16),
        FutureBuilder(
          future: makananListFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Expanded(
                child: ListView.separated(
                  controller: makananScrollController,
                  padding:
                      const EdgeInsets.only(left: 12, right: 12, bottom: 16),
                  itemCount: makanans.length,
                  itemBuilder: (context, index) {
                    final makanan = makanans[index];
                    return ListTile(
                      contentPadding: const EdgeInsets.all(8),
                      leading: const CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/makanan_default.jpg'),
                        radius: 30,
                      ),
                      title: Text(
                        makanan.nama,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                          "Pro ${makanan.protein}, Karb ${makanan.karbo}, Fat ${makanan.lemak}"),
                      trailing: CheckboxMakananBlok(
                        makananId: makanan.id,
                        checked: preferensiMakananIdList.contains(makanan.id),
                      ),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          width: 1,
                          color: Color.fromRGBO(225, 219, 214, 1),
                        ),
                        borderRadius: BorderRadius.circular(9),
                      ),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailMenuPage(makananId: makanan.id),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 8);
                  },
                ),
              );
            } else {
              return Column(
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Mengambil makanan'),
                ],
              );
            }
          },
        ),
      ],
    );
  }

  void searchMakanan(String namaMakanan) async {
    makananFilter.namaIcontains = namaMakanan;
    makananFilter.jenis = widget.jenis;
    final suggestions = await getAndUpdateMakananList(makananFilter);

    setState(() {
      makananFilter.namaIcontains = namaMakanan;
      makananFilter.jenis = widget.jenis;
      makanans = suggestions;
    });
  }

  void _scrollListener() async {
    if (makananScrollController.position.pixels ==
        makananScrollController.position.maxScrollExtent) {
      makananFilter.page = (int.parse(makananFilter.page) + 1).toString();
      final addMakanans = await getAndUpdateMakananList(makananFilter);

      // ignore: prefer_is_empty
      if (addMakanans.length > 0) {
        debugPrint("page sekarang ${makananFilter.page}");

        setState(() {});
      } else {
        debugPrint("=================================");
        debugPrint("Sudah tidak ada data");
      }
    }
  }
}
