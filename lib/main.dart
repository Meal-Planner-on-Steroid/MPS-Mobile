import 'package:flutter/material.dart';
import 'screens/home_page.dart';
import 'screens/auth/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color.fromARGB(100, 225, 219, 214),
        ),
      ),
      home: const RootPage(),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int currentPage = 0;
  List<Widget> pages = const [
    HomePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      // appBar: AppBar(
      //   title: const Text('Flutter'),
      // ),
      //   body: pages[currentPage],
      body: LoginPage(),
      //   bottomNavigationBar: NavigationBar(
      //     destinations: const [
      //       NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
      //       NavigationDestination(icon: Icon(Icons.person), label: 'Me'),
      //       NavigationDestination(icon: Icon(Icons.fastfood), label: 'Menu'),
      //       NavigationDestination(icon: Icon(Icons.history), label: 'Riwayat'),
      //     ],
      //     onDestinationSelected: (int index) {
      //       setState(() {
      //         currentPage = index;
      //       });
      //     },
      //     selectedIndex: currentPage,
      //   ),
    );
  }
}
