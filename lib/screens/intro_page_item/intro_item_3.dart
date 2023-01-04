import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mps/app/controllers/modules/tingkat_aktivitas_controller.dart';
import 'package:mps/app/controllers/pages/hitung_kebutuhan_gizi_controller.dart';
import 'package:mps/app/filters/tingkat_aktivitas_filter.dart';
import 'package:mps/app/models/user_profile_model.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroPage3 extends StatefulWidget {
  final ValueChanged<bool> update;
  const IntroPage3({
    super.key,
    required this.update,
  });

  @override
  State<IntroPage3> createState() => _IntroPage3State();
}

class _IntroPage3State extends State<IntroPage3> {
  final _formKey = GlobalKey<FormState>();

  // Model data
  final _userProfile = UserProfile();

  // Controller modul dan page
  final _hitungKebutuhanGiziController = HitungKebutuhanGiziController();
  final _tingkatAktivitasController = TingkatAktivitasController();

  // Filter modul
  var tingkatAktivitasFilter = TingkatAktivitasFilter();

  // Kumpulan variable bawaan
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

  // Kumpulan variable yang nantik akan diubah
  // List<Map<String, dynamic>> _aktivitas = [
  //   {
  //     'value': '1',
  //     'label': 'Pilih gender',
  //   },
  // ];
  List<Map<String, dynamic>> _aktivitas = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(250, 244, 183, 1),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: Column(
              children: [
                // const Spacer(),
                const SizedBox(height: 32),
                // Salam
                const Text(
                  'Mari hitung kebutuhan gizi kamu dulu 👋',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                const SizedBox(height: 16),

                Builder(
                  builder: (context) => Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // Input berat badan
                        TextFormField(
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(5)
                          ],
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            suffix: Text('Kg'),
                            hintText: 'Berat badan',
                            border: OutlineInputBorder(),
                            fillColor: Colors.white,
                            filled: true,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Tolong isi berat badan';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            setState(() {
                              _userProfile.beratBadan = double.parse(value!);
                            });
                          },
                        ),

                        // Input tinggi badan
                        const SizedBox(height: 8),
                        TextFormField(
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(6)
                          ],
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            suffix: Text('cm'),
                            hintText: 'Tinggi badan',
                            border: OutlineInputBorder(),
                            fillColor: Colors.white,
                            filled: true,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Tolong isi tinggi badan';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            setState(() {
                              _userProfile.tinggiBadan = double.parse(value!);
                            });
                          },
                        ),

                        // Input usia
                        const SizedBox(height: 8),
                        TextFormField(
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(2)
                          ],
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            suffix: Text('Tahun'),
                            hintText: 'Usia',
                            border: OutlineInputBorder(),
                            fillColor: Colors.white,
                            filled: true,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Tolong isi usia';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            setState(() {
                              _userProfile.usia = int.parse(value!);
                            });
                          },
                        ),

                        // Input Gender
                        const SizedBox(height: 8),
                        SelectFormField(
                          type:
                              SelectFormFieldType.dropdown, // or can be dialog
                          initialValue: null,
                          labelText: 'Gender',
                          icon: const Icon(Icons.format_shapes),
                          items: _genders,
                          decoration: const InputDecoration(
                            hintText: 'Pilih gender',
                            border: OutlineInputBorder(),
                            fillColor: Colors.white,
                            filled: true,
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
                              tingkatAktivitasTemp = tingkatAktivitas.data;

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

                        // Input tingkat aktivitas
                        const SizedBox(height: 8),
                        SelectFormField(
                          enabled: enableTingkatAktivitas,
                          type:
                              SelectFormFieldType.dropdown, // or can be dialog
                          initialValue: null,
                          labelText: 'Gender',
                          icon: const Icon(Icons.format_shapes),
                          items: _aktivitas,
                          decoration: const InputDecoration(
                            hintText: 'Pilih Tingkat Aktivitas',
                            border: OutlineInputBorder(),
                            fillColor: Colors.white,
                            filled: true,
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

                        // Tombol submit
                        const SizedBox(height: 8),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                            primary: const Color.fromRGBO(127, 209, 174, 1),
                          ),
                          onPressed: () async {
                            final form = _formKey.currentState;
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();

                            if (form!.validate()) {
                              form.save();
                              widget.update(true);
                              prefs.setBool('seen', true);
                              await _hitungKebutuhanGiziController
                                  .post(_userProfile);
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(11.0),
                            child: Text(
                              'Hitung Kebutuhan Gizi',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
