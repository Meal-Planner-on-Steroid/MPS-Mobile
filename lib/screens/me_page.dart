import 'package:flutter/material.dart';
import 'package:mps/app/controllers/pages/hitung_kebutuhan_gizi_controller.dart';
import 'package:mps/app/models/user_profile_model.dart';
import 'package:mps/screens/me/makanan_blok_page.dart';
import 'package:mps/utils/avatar_dan_setting.dart';
import 'me/hitung_kebutuhan_gizi_page.dart';
import 'me/makanan_favorit_page.dart';
import 'me/hasil_rekomendasi_page.dart';

class MePage extends StatefulWidget {
  const MePage({Key? key}) : super(key: key);

  @override
  State<MePage> createState() => _MePageState();
}

class _MePageState extends State<MePage> {
  final _userProfileFuture = UserProfile();

  final _hitungKebutuhanGiziController = HitungKebutuhanGiziController();

  Future updateAndGetUserProfile() async {
    await Future.delayed(Duration.zero);
    final userProfileData = await _hitungKebutuhanGiziController.get();

    if (userProfileData.data.length > 0) {
      debugPrint("User telah memiliki user profile");
      return userProfileData.data[0];
    } else {
      debugPrint("User belum memiliki user profile");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const AvatarDanSetting(currentPage: 'Mee'),

            // Tiga tombol
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromRGBO(255, 135, 101, 1),
                  width: 2,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(9),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 3,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                              return const HitungKebuguhanGiziPage(
                                fromPage: 'Me',
                              );
                            }),
                          );
                        },
                        child: Column(
                          children: const [
                            Image(
                              image: AssetImage(
                                  "assets/images/icons/646-walking-walkcycle-person-lineal.png"),
                              width: 35,
                              color: null,
                            ),
                            Text('Kebutuhan'),
                            Text('Gizi'),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                              return const MakananFavoritPage(
                                fromPage: 'Me',
                              );
                            }),
                          );
                        },
                        child: Column(
                          children: const [
                            Image(
                              image: AssetImage(
                                  "assets/images/icons/237-star-rating-morph-lineal.png"),
                              width: 35,
                              color: null,
                            ),
                            Text('Makanan'),
                            Text('Favorit'),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                              return const MakananBlokPage(
                                fromPage: 'Me',
                              );
                            }),
                          );
                        },
                        child: Column(
                          children: const [
                            Image(
                              image: AssetImage(
                                  "assets/images/icons/926-roadblock-lineal.png"),
                              width: 35,
                              color: null,
                            ),
                            Text('Blok'),
                            Text('Makanan'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Tombol buat rekomendasi menu makanan
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(255, 135, 101, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HasilRekomendasiPage(),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: const [
                    Text(
                      "Buat Rekomendasi",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "Menu Makanan",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Streak
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromRGBO(127, 209, 174, 1),
                  width: 2,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(9),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text('Streak'),
                    const SizedBox(height: 8),
                    const Divider(
                      height: 1,
                      color: Color.fromRGBO(255, 219, 214, 1),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: const [
                        Text(
                          '7',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 38,
                          ),
                        ),
                        Text('hari'),
                      ],
                    )
                  ],
                ),
              ),
            ),

            // Status pengguna

            FutureBuilder(
              future: updateAndGetUserProfile(),
              builder: (context, snapshot) {
                dynamic currentData;
                if (snapshot.hasData && snapshot.data != false) {
                  currentData = snapshot.data!;
                } else {
                  currentData = _userProfileFuture;
                }

                return Column(
                  children: [
                    // Status
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromRGBO(127, 209, 174, 1),
                          width: 2,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(9),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Status',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('IMT'),
                                Text(currentData.imt.toStringAsFixed(2)),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Kebutuhan Energi'),
                                Row(
                                  children: [
                                    Text(currentData.keseluruhanEnergi
                                        .toStringAsFixed(2)),
                                    const Text(' kcal'),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),

                    // Kebutuhan gizi
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromRGBO(127, 209, 174, 1),
                          width: 2,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(9),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Kebutuhan Gizi',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Protein'),
                                Row(
                                  children: [
                                    Text(currentData.butuhProtein.protein10
                                        .toStringAsFixed(2)),
                                    const Text(' - '),
                                    Text(currentData.butuhProtein.protein15
                                        .toStringAsFixed(2)),
                                    const Text(' g'),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Karbohidrat'),
                                Row(
                                  children: [
                                    Text(currentData.butuhKarbo.karbo60
                                        .toStringAsFixed(2)),
                                    const Text(' - '),
                                    Text(currentData.butuhKarbo.karbo75
                                        .toStringAsFixed(2)),
                                    const Text(' g'),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Lemak'),
                                Row(
                                  children: [
                                    Text(currentData.butuhLemak.lemak10
                                        .toStringAsFixed(2)),
                                    const Text(' - '),
                                    Text(currentData.butuhLemak.lemak25
                                        .toStringAsFixed(2)),
                                    const Text(' g'),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
