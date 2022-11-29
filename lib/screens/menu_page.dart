import 'package:flutter/material.dart';
import 'menu/makanan_list_page.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
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
          title: const Text('Menu'),
        ),
        body: const TabBarView(
          children: [
            MakananListPage(
              judul: 'menu',
              jenis: 'ME',
            ),
            MakananListPage(
              judul: 'bahan',
              jenis: 'BA',
            ),
            MakananListPage(
              judul: 'camilan',
              jenis: 'CA',
            ),
          ],
        ),
      ),
    );
  }
}
