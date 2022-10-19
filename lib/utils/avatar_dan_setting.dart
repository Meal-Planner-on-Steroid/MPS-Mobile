import 'package:flutter/material.dart';

class AvatarDanSetting extends StatelessWidget {
  const AvatarDanSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {},
          child: const CircleAvatar(
            backgroundImage: AssetImage('assets/images/user_random.jpg'),
          ),
        ),
        GestureDetector(
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //       builder: (context) => const MintaResetPasswordPage()),
            // );
          },
          child: const Padding(
            padding: EdgeInsets.all(12.0),
            child: Icon(
              Icons.settings,
            ),
          ),
        ),
      ],
    );
  }
}
