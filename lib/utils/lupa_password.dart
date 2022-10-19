import 'package:flutter/material.dart';
import '../screens/auth/minta_reset_password.dart';

class LupaPassword extends StatelessWidget {
  const LupaPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const MintaResetPasswordPage()),
        );
      },
      child: const Text(
        "Lupa password?",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
