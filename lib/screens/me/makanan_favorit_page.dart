import 'package:flutter/material.dart';
import './list_makanan_page.dart';

class MakananFavoritPage extends StatefulWidget {
  const MakananFavoritPage({Key? key}) : super(key: key);

  @override
  State<MakananFavoritPage> createState() => _MakananFavoritPageState();
}

class _MakananFavoritPageState extends State<MakananFavoritPage> {
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
          title: const Text('Me'),
        ),
        body: const TabBarView(
          children: [
            ListMakananPage(
              judul: 'menu',
              jenis: 'fav',
            ),
            ListMakananPage(
              judul: 'menu',
              jenis: 'fav',
            ),
            ListMakananPage(
              judul: 'menu',
              jenis: 'fav',
            ),
          ],
        ),
      ),
    );
  }
}
