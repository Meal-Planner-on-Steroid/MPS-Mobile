import 'package:flutter/material.dart';
import 'package:mps/screens/me/makanan_favorit_list_page.dart';

class MakananFavoritPage extends StatefulWidget {
  final String fromPage;

  const MakananFavoritPage({Key? key, required this.fromPage})
      : super(key: key);

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
          title: Text(widget.fromPage),
        ),
        body: const TabBarView(
          children: [
            MakananFavoritListPage(
              judul: 'menu',
              jenis: 'ME',
            ),
            MakananFavoritListPage(
              judul: 'bahan',
              jenis: 'BA',
            ),
            MakananFavoritListPage(
              judul: 'camilan',
              jenis: 'CA',
            ),
          ],
        ),
      ),
    );
  }
}
