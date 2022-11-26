import 'package:flutter/material.dart';
import 'package:mps/screens/me/makanan_blok_list_page.dart';

class MakananBlokPage extends StatefulWidget {
  final String fromPage;

  const MakananBlokPage({Key? key, required this.fromPage}) : super(key: key);

  @override
  State<MakananBlokPage> createState() => _MakananBlokPageState();
}

class _MakananBlokPageState extends State<MakananBlokPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey.shade700,
            tabs: const [
              Tab(
                text: 'Menu',
                icon: Icon(Icons.fastfood),
              ),
              Tab(
                text: 'Bahan',
                icon: Icon(Icons.egg),
              ),
              Tab(
                  text: 'Camilan',
                  icon: Icon(
                    Icons.icecream_sharp,
                  )),
            ],
          ),
          title: Text(widget.fromPage),
        ),
        body: const TabBarView(
          children: [
            MakananBlokListPage(
              judul: 'menu',
              jenis: 'ME',
            ),
            MakananBlokListPage(
              judul: 'bahan',
              jenis: 'BA',
            ),
            MakananBlokListPage(
              judul: 'camilan',
              jenis: 'CA',
            ),
          ],
        ),
      ),
    );
  }
}
