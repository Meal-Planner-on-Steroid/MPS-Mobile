import 'package:flutter/material.dart';
import '../../utils/makanan_search/makanan_search_items.dart';
import 'detail_menu_page.dart';

class ListItemPage extends StatefulWidget {
  final String judul;

  const ListItemPage({
    Key? key,
    required this.judul,
  }) : super(key: key);

  @override
  State<ListItemPage> createState() => _ListItemPageState();
}

class _ListItemPageState extends State<ListItemPage> {
  final controller = TextEditingController();
  List<Makanan> makanans = makananList;

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
                leading: CircleAvatar(
                  backgroundImage: AssetImage(makanan.image),
                  radius: 30,
                ),
                title: Text(makanan.title),
                subtitle: Text(makanan.desc),
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
    final suggestions = makananList.where((makanan) {
      final makananTitle = makanan.title.toLowerCase();
      final input = query.toLowerCase();

      return makananTitle.contains(input);
    }).toList();

    setState(() => makanans = suggestions);
  }
}
