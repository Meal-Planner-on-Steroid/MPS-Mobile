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
