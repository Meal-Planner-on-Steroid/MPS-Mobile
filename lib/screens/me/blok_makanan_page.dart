import 'package:flutter/material.dart';
import './list_makanan_page.dart';

class BlokMakananPage extends StatefulWidget {
  final String fromPage;

  const BlokMakananPage({Key? key, required this.fromPage}) : super(key: key);

  @override
  State<BlokMakananPage> createState() => _BlokMakananPageState();
}

class _BlokMakananPageState extends State<BlokMakananPage> {
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
            ListMakananPage(
              judul: 'menu',
              jenis: 'blok',
            ),
            ListMakananPage(
              judul: 'bahan',
              jenis: 'blok',
            ),
            ListMakananPage(
              judul: 'camilan',
              jenis: 'blok',
            ),
          ],
        ),
      ),
    );
  }
}
