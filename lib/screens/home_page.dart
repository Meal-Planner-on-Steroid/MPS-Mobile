import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mps/app/controllers/pages/hitung_kebutuhan_gizi_controller.dart';
import 'package:mps/app/serializers/user_profile_serializer.dart';
import 'package:mps/utils/avatar_dan_setting.dart';
import 'package:mps/utils/home/goal_hari.dart';
import 'package:mps/utils/home/slider_rencana_diet.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _hitungKebutuhanGiziController = HitungKebutuhanGiziController();

  String _homeDate = DateFormat('yyy-MM-dd').format(DateTime.now()).toString();

  late Future<UserProfileSerializer> _userProfileFuture;

  Future<UserProfileSerializer> getUserProfile() async {
    final userProfileData = await _hitungKebutuhanGiziController.get();
    // inspect(userProfileData);
    return userProfileData;
  }

  void _updateHomeDate(String homeDate) {
    setState(() {
      _homeDate = homeDate;
    });
  }

  @override
  void initState() {
    super.initState();

    _userProfileFuture = getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {});
        },
        child: const Icon(Icons.refresh),
      ),
      body: SafeArea(
        child: ListView(
          // padding: const EdgeInsets.all(24),
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 24,
                top: 24,
                right: 24,
              ),
              child: Column(
                children: [
                  const AvatarDanSetting(currentPage: 'Home'),

                  // Dropdown status
                  const SizedBox(height: 16),
                  FutureBuilder<UserProfileSerializer>(
                    future: _userProfileFuture,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const GoalHariIni();
                      }
                      var data = snapshot.data!.data[0];

                      double tempButuhKarbo =
                          (data.butuhKarbo.karbo60 + data.butuhKarbo.karbo75) /
                              2;
                      double tempButuhProtein = (data.butuhProtein.protein10 +
                              data.butuhProtein.protein15) /
                          2;
                      double tempButuhLemak =
                          (data.butuhLemak.lemak10 + data.butuhLemak.lemak25) /
                              2;

                      return GoalHariIni(
                        keseluruhanEnergi: data.keseluruhanEnergi ?? 0,
                        butuhKarbo: tempButuhKarbo,
                        butuhProtein: tempButuhProtein,
                        butuhLemak: tempButuhLemak,
                        progresEnergi: 0,
                        progresKarbo: 0,
                        progresProtein: 0,
                        progresLemak: 0,
                      );
                      // return const Text('ada data');
                    },
                  ),

                  // const GoalHariIni(),
                ],
              ),
            ),

            // Slider
            const SizedBox(height: 16),
            Center(child: Text(_homeDate)),
            SliderRencanaDiet(homeDate: _updateHomeDate),
          ],
        ),
      ),
    );
  }
}
