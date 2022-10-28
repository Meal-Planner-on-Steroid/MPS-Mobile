import 'package:flutter/material.dart';

class AirMinumPage extends StatefulWidget {
  final String fromPage;

  const AirMinumPage({
    Key? key,
    required this.fromPage,
  }) : super(key: key);

  @override
  State<AirMinumPage> createState() => _AirMinumPageState();
}

class _AirMinumPageState extends State<AirMinumPage> {
  double _jumlahAirValue = 2;
  double _jumlahMinumValue = 8;

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
            // Jumlah Air
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
                    const Text(
                      'Jumlah Air',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Column(
                      children: [
                        Text(
                          _jumlahAirValue.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 38,
                          ),
                        ),
                        const Text('liter'),
                      ],
                    ),
                    Slider(
                      value: _jumlahAirValue,
                      min: 0,
                      max: 3,
                      divisions: 6,
                      thumbColor: const Color.fromRGBO(127, 209, 174, 1),
                      activeColor: const Color.fromRGBO(127, 209, 174, 1),
                      inactiveColor: Colors.black,
                      label: _jumlahAirValue.toString(),
                      onChanged: (double value) {
                        setState(() {
                          _jumlahAirValue = value;
                        });
                      },
                    )
                  ],
                ),
              ),
            ),

            // Jumlah Minum
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
                    const Text(
                      'Jumlah Minum',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Column(
                      children: [
                        Text(
                          _jumlahMinumValue.round().toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 38,
                          ),
                        ),
                        const Text('kali'),
                      ],
                    ),
                    Slider(
                      value: _jumlahMinumValue,
                      min: 0,
                      max: 20,
                      divisions: 20,
                      thumbColor: const Color.fromRGBO(127, 209, 174, 1),
                      activeColor: const Color.fromRGBO(127, 209, 174, 1),
                      inactiveColor: Colors.black,
                      label: _jumlahMinumValue.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          _jumlahMinumValue = value;
                        });
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
