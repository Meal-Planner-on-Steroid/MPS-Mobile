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
                icon: Image(
                  image: AssetImage(
                      "assets/images/icons/1486-food-as-resources-lineal.png"),
                  width: 35,
                  color: null,
                ),
              ),
              Tab(
                text: 'Bahan',
                icon: Image(
                  image: AssetImage("assets/images/icons/585-herbs-lineal.png"),
                  width: 35,
                  color: null,
                ),
              ),
              Tab(
                text: 'Camilan',
                icon: Image(
                  image: AssetImage(
                      "assets/images/icons/2230-candy-cane-lineal.png"),
                  width: 35,
                  color: null,
                ),
              ),
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
