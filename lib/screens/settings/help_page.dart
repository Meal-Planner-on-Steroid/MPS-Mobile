import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HelpPage extends StatelessWidget {
  final String fromPage;
  List<ListHelp> listHelp = [
    ListHelp(
      settingIcon: Icons.question_mark,
      title: 'Cara penggunaan',
      desc: 'Langkah detail penggunaan aplikasi',
      href: 'link website',
    ),
    ListHelp(
      settingIcon: Icons.group,
      title: 'Hubungi Kami',
      desc: 'Pertanyaan? Butuh bantuan?',
      href: 'link website',
    ),
    ListHelp(
      settingIcon: Icons.phone_android,
      title: 'Ketentuan dan Kebijakan Privasi',
      desc: '',
      href: 'link website',
    ),
    ListHelp(
      settingIcon: Icons.info_outline,
      title: 'Info Aplikasi',
      desc: '',
      href: 'link website',
    ),
  ];

  HelpPage({
    Key? key,
    required this.fromPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(fromPage),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Column(
              children: listHelp
                  .map(
                    (item) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => item.href,
                          //   ),
                          // );
                        },
                        child: Container(
                          color: Colors.white,
                          child: Row(
                            children: [
                              Icon(
                                item.settingIcon,
                                color: Colors.yellow.shade800,
                              ),
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.title,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Visibility(
                                    visible: item.desc.isNotEmpty,
                                    child: Text(item.desc),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class ListHelp {
  final IconData settingIcon;
  final String title;
  final String desc;
  final String href;

  ListHelp({
    required this.settingIcon,
    required this.title,
    required this.desc,
    required this.href,
  });
}
