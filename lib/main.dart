import 'package:flutter/material.dart';
import 'package:mps/app/services/auth_service.dart';
import 'package:mps/screens/auth/login_page.dart';
import 'screens/home_page.dart';
import 'screens/me_page.dart';
import 'screens/menu_page.dart';
import 'screens/riwayat_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: 'assets/env/.env_development');
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
          primary: const Color.fromRGBO(225, 219, 214, 1),
        ),
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          foregroundColor: Colors.black,
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
  final _authService = AuthService();

  Future<bool> getAuth() async {
    try {
      // ignore: unused_local_variable
      final auth = await _authService.getAuth();
      debugPrint('This is main page');

      if (auth.access.isEmpty || auth.refresh.isEmpty) {
        debugPrint('tidak ada access dan refresh');
        return false;
      }

      debugPrint('ada access dan refresh');

      return true;
    } on Exception catch (_) {
      return false;
    }
  }

  int currentPage = 0;
  List<Widget> pages = const [
    HomePage(),
    MePage(),
    MenuPage(),
    RiwayatPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getAuth(),
      builder: (context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.data == true) {
          return Scaffold(
            backgroundColor: Colors.grey.shade300,
            // appBar: AppBar(
            //   title: const Text('Flutter'),
            // ),
            body: pages[currentPage],
            bottomNavigationBar: NavigationBar(
              destinations: const [
                NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
                NavigationDestination(icon: Icon(Icons.person), label: 'Me'),
                NavigationDestination(
                    icon: Icon(Icons.fastfood), label: 'Menu'),
                NavigationDestination(
                    icon: Icon(Icons.history), label: 'Riwayat'),
              ],
              onDestinationSelected: (int index) {
                setState(() {
                  currentPage = index;
                });
              },
              selectedIndex: currentPage,
            ),
          );
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
