import 'package:flutter/material.dart';
import '../screens/profil_page.dart';
import '../screens/settings_page.dart';

class AvatarDanSetting extends StatelessWidget {
  final String currentPage;
  const AvatarDanSetting({
    Key? key,
    required this.currentPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProfilPage(
                        fromPage: currentPage,
                      )),
            );
          },
          child: const CircleAvatar(
            backgroundImage: AssetImage('assets/images/user_random.jpg'),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SettingsPage(fromPage: currentPage),
              ),
            );
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
