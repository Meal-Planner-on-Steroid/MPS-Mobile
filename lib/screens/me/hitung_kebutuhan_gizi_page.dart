import 'package:flutter/material.dart';
import 'package:mps/app/controllers/pages/hitung_kebutuhan_gizi_controller.dart';
import 'package:mps/app/controllers/modules/tingkat_aktivitas_controller.dart';
import 'package:mps/app/filters/tingkat_aktivitas_filter.dart';
import 'package:mps/app/models/user_profile_model.dart';
import 'package:select_form_field/select_form_field.dart';

class HitungKebuguhanGiziPage extends StatefulWidget {
  final String fromPage;

  const HitungKebuguhanGiziPage({Key? key, required this.fromPage})
      : super(key: key);

  @override
  State<HitungKebuguhanGiziPage> createState() =>
      _HitungKebuguhanGiziPageState();
}

class _HitungKebuguhanGiziPageState extends State<HitungKebuguhanGiziPage> {
  final _formKey = GlobalKey<FormState>();
  final _userProfile = UserProfile();
  final _userProfileFuture = UserProfile();

  final _hitungKebutuhanGiziController = HitungKebutuhanGiziController();
  final _tingkatAktivitasController = TingkatAktivitasController();

  var tingkatAktivitasFilter = TingkatAktivitasFilter();

  bool enableTingkatAktivitas = false;
  late List<dynamic> tingkatAktivitasTemp;

  final List<Map<String, dynamic>> _genders = [
    {
      'value': 'PE',
      'label': 'Perempuan',
    },
    {
      'value': 'LA',
      'label': 'Laki-laki',
    },
  ];

  List<Map<String, dynamic>> _aktivitas = [
    {
      'value': '1',
      'label': 'Pilih gender',
    },
  ];

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
    // return Text(_userProfileFuture.gender.toString());
    return FutureBuilder(
      future: updateAndGetUserProfile(),
      builder: ((context, snapshot) {
        dynamic currentData;
        if (snapshot.hasData && snapshot.data != false) {
          currentData = snapshot.data!;
        } else {
          currentData = _userProfileFuture;
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(widget.fromPage),
          ),
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                // Form
                Builder(
                  builder: (context) => Form(
                    key: _formKey,
                    child: Column(
                      children: [
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Data diri',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 16),

                                // Berat Badan
                                const Text('Berat Badan'),
                                const SizedBox(height: 8),
                                TextFormField(
                                  initialValue:
                                      currentData.beratBadan.toString(),
                                  maxLength: 5,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    suffix: Text('Kg'),
                                    hintText: '60',
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your username';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    setState(() {
                                      _userProfile.beratBadan =
                                          double.parse(value!);
                                    });
                                  },
                                ),
                                const SizedBox(height: 8),

                                // Tinggi badan
                                const Text('Tinggi Badan'),
                                const SizedBox(height: 8),
                                TextFormField(
                                  initialValue:
                                      currentData.tinggiBadan.toString(),
                                  maxLength: 6,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    suffix: Text('cm'),
                                    hintText: '60',
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your username';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    setState(() {
                                      _userProfile.tinggiBadan =
                                          double.parse(value!);
                                    });
                                  },
                                ),
                                const SizedBox(height: 8),

                                // Usia
                                const Text('Usia'),
                                const SizedBox(height: 8),
                                TextFormField(
                                  initialValue: currentData.usia.toString(),
                                  maxLength: 2,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    suffix: Text('Kg'),
                                    hintText: '60',
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your username';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    setState(() {
                                      _userProfile.usia = int.parse(value!);
                                    });
                                  },
                                ),
                                const SizedBox(height: 8),

                                // Gender
                                const Text('Gender'),
                                const SizedBox(height: 8),
                                SelectFormField(
                                  type: SelectFormFieldType
                                      .dropdown, // or can be dialog
                                  initialValue: null,
                                  labelText: 'Gender',
                                  icon: const Icon(Icons.format_shapes),
                                  items: _genders,
                                  decoration: const InputDecoration(
                                    hintText: 'Pilih gender',
                                    border: OutlineInputBorder(),
                                  ),
                                  onSaved: (value) {
                                    setState(() {
                                      _userProfile.gender = value!;
                                    });
                                  },
                                  onChanged: (value) async {
                                    tingkatAktivitasFilter.gender = value;
                                    var tingkatAktivitas =
                                        await _tingkatAktivitasController
                                            .get(tingkatAktivitasFilter);
                                    setState(() {
                                      enableTingkatAktivitas = true;
                                      tingkatAktivitasTemp =
                                          tingkatAktivitas.data;

                                      _aktivitas = [
                                        for (var items in tingkatAktivitasTemp)
                                          {
                                            'value': items['id'],
                                            'label': items['nama'],
                                          }
                                      ];

                                      debugPrint(_aktivitas.toString());
                                    });
                                  },
                                ),
                                const SizedBox(height: 8),

                                // Tingkat Aktivitas
                                const Text('Tingkat Aktivitas'),
                                const SizedBox(height: 8),
                                SelectFormField(
                                  enabled: enableTingkatAktivitas,
                                  type: SelectFormFieldType
                                      .dropdown, // or can be dialog
                                  initialValue: null,
                                  labelText: 'Gender',
                                  icon: const Icon(Icons.format_shapes),
                                  items: _aktivitas,
                                  decoration: const InputDecoration(
                                    hintText: 'Pilih gender terlebih dahulu',
                                    border: OutlineInputBorder(),
                                  ),
                                  onSaved: (value) {
                                    setState(() {
                                      _userProfile.tingkatAktivitasId =
                                          int.parse(value!);
                                    });
                                  },
                                  onChanged: (value) {
                                    debugPrint(value);
                                  },
                                ),
                                const SizedBox(height: 8),
                              ],
                            ),
                          ),
                        ),

                        // Tombol hitung kebutuhan gizi
                        const SizedBox(height: 16),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: const Color.fromRGBO(255, 135, 101, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9),
                            ),
                          ),
                          onPressed: () async {
                            final form = _formKey.currentState;

                            if (form!.validate()) {
                              form.save();
                              await _hitungKebutuhanGiziController
                                  .post(_userProfile);
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: const [
                                Text(
                                  "Hitung Kebutuhan Gizi",
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
                      ],
                    ),
                  ),
                ),

                // Divider hasil
                const SizedBox(height: 16),
                Row(children: const <Widget>[
                  Expanded(
                    child: Divider(
                      height: 2,
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8, right: 8),
                    child: Text("Hasil"),
                  ),
                  Expanded(
                    child: Divider(
                      height: 2,
                      color: Colors.black,
                    ),
                  ),
                ]),

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

                // Section
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
            ),
          ),
        );
      }),
    );
  }
}
