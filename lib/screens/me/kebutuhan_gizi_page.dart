import 'package:flutter/material.dart';
import 'package:mps/app/controllers/kebutuhan_gizi_controller.dart';
import 'package:mps/app/controllers/tingkat_aktivitas_controller.dart';
import 'package:mps/app/models/user_profile_model.dart';
import 'package:select_form_field/select_form_field.dart';

class KebuguhanGiziPage extends StatefulWidget {
  final String fromPage;

  const KebuguhanGiziPage({Key? key, required this.fromPage}) : super(key: key);

  @override
  State<KebuguhanGiziPage> createState() => _KebuguhanGiziPageState();
}

class _KebuguhanGiziPageState extends State<KebuguhanGiziPage> {
  final _formKey = GlobalKey<FormState>();
  final _userProfile = UserProfile();
  final _kebutuhanGiziController = KebutuhanGiziController();
  final _tingkatAktivitasController = TingkatAktivitasController();

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

  @override
  Widget build(BuildContext context) {
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
                              initialValue: null,
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
                              maxLength: 6,
                              initialValue: null,
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
                              maxLength: 2,
                              initialValue: null,
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
                                hintText: 'Laki-laki',
                                border: OutlineInputBorder(),
                              ),
                              onSaved: (value) {
                                setState(() {
                                  _userProfile.gender = value!;
                                });
                              },
                              onChanged: (value) async {
                                var tingkatAktivitas =
                                    await _tingkatAktivitasController
                                        .get(value);
                                setState(() {
                                  enableTingkatAktivitas = true;
                                  tingkatAktivitasTemp = tingkatAktivitas.data;

                                  debugPrint(_aktivitas.toString());

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
                                hintText: 'Ringan',
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
                          await _kebutuhanGiziController.post(_userProfile);
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

            // Hasil
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
                      'Status',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('IMT'),
                        Text('-'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Kebutuhan Energi'),
                        Text('-'),
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
                      children: const [
                        Text('Protein'),
                        Text('-'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Karbohidrat'),
                        Text('-'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Lemak'),
                        Text('-'),
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
  }
}
