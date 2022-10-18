import 'package:flutter/material.dart';
import '../screens/auth/login_page.dart';

class SudahPunyaAkun extends StatelessWidget {
  const SudahPunyaAkun({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Sudah punya akun? '),
        GestureDetector(
          onTap: () {
            // debugPrint('Register');
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
          },
          child: const Text(
            'Klik disini',
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
