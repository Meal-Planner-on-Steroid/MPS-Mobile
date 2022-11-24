import 'package:flutter/material.dart';
import '../../utils/makanan_search/makanan_search_items.dart';
import '../../utils/checkbox_green.dart';
import '../../utils/checkbox_red.dart';

class ListMakananPage extends StatefulWidget {
  final String judul;
  final String jenis;

  const ListMakananPage({
    Key? key,
    required this.judul,
    required this.jenis,
  }) : super(key: key);

  @override
  State<ListMakananPage> createState() => _ListMakananPageState();
}

class _ListMakananPageState extends State<ListMakananPage> {
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
                trailing: widget.jenis == 'fav'
                    ? const CheckboxGreen()
                    : CheckboxRed(),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    width: 1,
                    color: Color.fromRGBO(225, 219, 214, 1),
                  ),
                  borderRadius: BorderRadius.circular(9),
                ),
                // onTap: () => Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => MakananPage(makanan: makanan),
                //     ),
                // ),
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
