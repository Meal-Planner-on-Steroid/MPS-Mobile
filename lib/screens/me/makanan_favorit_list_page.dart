import 'package:flutter/material.dart';
import 'package:mps/app/models/makanan_model.dart';
import 'package:mps/screens/menu/detail_menu_page.dart';
import 'package:mps/utils/checkbox_green.dart';

class MakananFavoritListPage extends StatefulWidget {
  final String judul;
  final String jenis;

  const MakananFavoritListPage({
    Key? key,
    required this.judul,
    required this.jenis,
  }) : super(key: key);

  @override
  State<MakananFavoritListPage> createState() => _MakananFavoritListPageState();
}

class _MakananFavoritListPageState extends State<MakananFavoritListPage> {
  final controller = TextEditingController();
  List<Makanan> makanans = [
    Makanan(),
    Makanan(),
    Makanan(),
    Makanan(),
    Makanan(),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
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
        const SizedBox(height: 16),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.only(left: 12, right: 12, bottom: 16),
            itemCount: makanans.length,
            itemBuilder: (context, index) {
              final makanan = makanans[index];

              return ListTile(
                leading: const CircleAvatar(
                  backgroundImage:
                      AssetImage('assets/images/makanan_random.jpg'),
                  radius: 30,
                ),
                title: Text(makanan.nama),
                subtitle: Text(makanan.kelompok),
                trailing: const CheckboxGreen(),
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
                    builder: (context) => const DetailMenuPage(),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 8);
            },
          ),
        )
      ],
    );
  }

  void searchMakanan(String query) {
    final suggestions = makanans.where((makanan) {
      final makananTitle = makanan.nama.toLowerCase();
      final input = query.toLowerCase();

      return makananTitle.contains(input);
    }).toList();

    setState(() => makanans = suggestions);
  }
}
