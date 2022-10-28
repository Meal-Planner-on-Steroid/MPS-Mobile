import 'package:flutter/material.dart';
import 'package:mps/screens/me/blok_makanan_page.dart';
import 'package:mps/screens/profil_page.dart';
import 'package:mps/screens/settings/air_minum_page.dart';
import 'settings/goal_page.dart';
import 'settings/air_minum_page.dart';
import 'settings/help_page.dart';
import 'me/kebutuhan_gizi_page.dart';
import 'me/makanan_favorit_page.dart';
import 'profil_page.dart';

// ignore: must_be_immutable
class SettingsPage extends StatelessWidget {
  final String fromPage;

  List<ListSetting> listSetting = [
    ListSetting(
      settingIcon: Icons.star,
      title: 'Goal',
      desc: 'Sesuaikan tujuan diet',
      href: GoalPage(fromPage: 'Setting'),
    ),
    ListSetting(
      settingIcon: Icons.person,
      title: 'Kebutuhan Gizi',
      desc: 'Berat badan, tinggi badan, usia, dll',
      href: const KebuguhanGiziPage(),
    ),
    ListSetting(
      settingIcon: Icons.favorite,
      title: 'Makanan Favorit',
      desc: 'Makanan akan lebih sering ',
      href: const MakananFavoritPage(),
    ),
    ListSetting(
      settingIcon: Icons.heart_broken_sharp,
      title: 'Blok makanan',
      desc: 'Alergi atau makanan yang tidak disukai',
      href: const BlokMakananPage(),
    ),
    ListSetting(
      settingIcon: Icons.local_drink_rounded,
      title: 'Air Minum',
      desc: 'Alergi atau makanan yang tidak disukai',
      href: const AirMinumPage(
        fromPage: 'settings',
      ),
    ),
    ListSetting(
      settingIcon: Icons.contact_page,
      title: 'Profil',
      desc: 'Profil dan password',
      href: const ProfilPage(fromPage: 'settings'),
    ),
    ListSetting(
      settingIcon: Icons.question_mark,
      title: 'Bantuan',
      desc: 'Cara penggunaan, hubungi kami,',
      href: HelpPage(fromPage: 'setting'),
    ),
  ];

  SettingsPage({Key? key, required this.fromPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(fromPage),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            // List settings
            Column(
              children: listSetting
                  .map(
                    (item) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => item.href,
                            ),
                          );
                        },
                        child: Container(
                          color: Colors.white,
                          child: Row(
                            children: [
                              Icon(
                                item.settingIcon,
                                color: Colors.yellow.shade800,
                              ),
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.title,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(item.desc),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),

            // Tombol logout
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    primary: const Color.fromRGBO(127, 209, 174, 1),
                  ),
                  onPressed: () {
                    // final form = _formKey.currentState;
                    // if (form!.validate()) {
                    //   form.save();
                    // }
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(11.0),
                    child: Text(
                      'LOG OUT',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ListSetting {
  final IconData settingIcon;
  final String title;
  final String desc;
  final Widget href;

  ListSetting({
    required this.settingIcon,
    required this.title,
    required this.desc,
    required this.href,
  });
}
