import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:mps/app/services/pages/auth_service.dart';
import 'package:mps/screens/auth/login_page.dart';
import 'package:mps/screens/fail_page.dart';
import 'package:mps/screens/intro_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/home_page.dart';
import 'screens/me_page.dart';
import 'screens/menu_page.dart';
import 'screens/riwayat_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

void main() async {
  await dotenv.load(fileName: 'assets/env/.env_production');
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
      home: const Splash(),
    );
  }
}

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with AfterLayoutMixin<Splash> {
  Future<bool> checkConnection() async {
    try {
      debugPrint('Check server');
      final String? baseUrl = dotenv.env['BASE_URL'];
      var url = Uri.http(baseUrl.toString(), '');

      await http.get(url);
      debugPrint('sudah Check server');

      return true;
    } catch (e) {
      debugPrint('gagal Check server');
      return false;
    }
  }

  Future checkFirst() async {
    final navigator = Navigator.of(context);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool access = (prefs.getString('access') ?? '').isNotEmpty;
    bool refresh = (prefs.getString('access') ?? '').isNotEmpty;
    bool seen = (prefs.getBool('seen') ?? false);

    if (await checkConnection()) {
      if (access && refresh) {
        if (seen) {
          // Pindah ke home page
          navigator.pushReplacement(
            MaterialPageRoute(
              builder: (context) => const RootPage(),
            ),
          );
        } else {
          // Pindah ke intro
          navigator.pushReplacement(
            MaterialPageRoute(
              builder: (context) => const IntroPage(),
            ),
          );
        }
      } else {
        // Pindah ke login page
        navigator.pushReplacement(
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
        );
      }
    } else {
      navigator.pushReplacement(
        MaterialPageRoute(
          builder: (context) => const FailPage(
            pesan:
                'Terjadi masalah saat menghubungi server, mohon coba lagi nanti',
          ),
        ),
      );
    }
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirst();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const Spacer(),
          Container(
            alignment: const Alignment(0, 0.5),
            child: Column(
              children: [
                SizedBox(
                  height: 160,
                  child: Image.asset(
                      'assets/images/illustration/rocket_green.png'),
                ),
                const SizedBox(height: 16),
                const GFLoader(
                  type: GFLoaderType.circle,
                ),
                const SizedBox(height: 16),
                const Text('Loading...'),
              ],
            ),
          ),
          const Spacer(),
        ],
      ),
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
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: pages[currentPage],
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
            icon: Image(
              image: AssetImage("assets/images/icons/63-home-lineal.png"),
              width: 35,
              color: null,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Image(
              image: AssetImage("assets/images/icons/21-avatar-lineal.png"),
              width: 35,
              color: null,
            ),
            label: 'Me',
          ),
          NavigationDestination(
            icon: Image(
              image: AssetImage(
                  "assets/images/icons/1486-food-as-resources-lineal.png"),
              width: 35,
              color: null,
            ),
            label: 'Menu',
          ),
          NavigationDestination(
            icon: Image(
              image: AssetImage("assets/images/icons/45-clock-time-lineal.png"),
              width: 35,
              color: null,
            ),
            label: 'Riwayat',
          ),
        ],
        onDestinationSelected: (int index) {
          setState(() {
            currentPage = index;
          });
        },
        selectedIndex: currentPage,
      ),
    );
  }
}
