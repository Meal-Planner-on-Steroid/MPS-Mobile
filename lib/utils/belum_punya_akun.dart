import 'package:flutter/material.dart';
import '../screens/auth/register_page.dart';

class BelumPunyaAKun extends StatelessWidget {
  const BelumPunyaAKun({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Belum punya akun? '),
        GestureDetector(
          onTap: () {
            // debugPrint('Register');
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RegisterPage()),
            );
          },
          child: const Text(
            'Daftar disini',
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
