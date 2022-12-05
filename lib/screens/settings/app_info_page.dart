import 'package:flutter/material.dart';
import 'package:getwidget/components/typography/gf_typography.dart';
import 'package:getwidget/getwidget.dart';

class AppInfo extends StatelessWidget {
  const AppInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Center(
            child: Column(
              children: [
                const Spacer(),
                Text(
                  'MPS',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                    color: Colors.grey.shade200,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Meal Planner on Steroid',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade200,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Alpha v0.1',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade200,
                  ),
                ),
                const SizedBox(height: 32),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    primary: const Color.fromRGBO(127, 209, 174, 1),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.arrow_back),
                ),

                // Text(
                //   'Meal Planner on Steroid',
                //   style: TextStyle(
                //     color: Colors.white,
                //     fontWeight: FontWeight.bold,
                //     fontSize: 16,
                //   ),
                // ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
