import 'package:flutter/material.dart';
import 'package:mps/app/controllers/auth_controller.dart';
import 'package:mps/main.dart';
import 'package:mps/app/models/user_model.dart';
import '../../utils/belum_punya_akun.dart';
import '../../utils/lupa_password.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _user = User();
  final _authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(225, 219, 214, 1),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Builder(
            builder: (context) => Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 24),
                  // Salam
                  const Text(
                    'Halo 👋',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  const SizedBox(height: 8),

                  const Text(
                    'Selamat datang di aplikasi',
                    style: TextStyle(fontSize: 16),
                  ),

                  const SizedBox(height: 64),

                  // Username input
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Username'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      setState(() {
                        _user.username = value!;
                      });
                    },
                  ),

                  // Password input
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Password'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      setState(() {
                        _user.password = value!;
                      });
                    },
                  ),

                  const SizedBox(height: 16),

                  // Link lupa password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      LupaPassword(),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Tombol login
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          primary: const Color.fromRGBO(127, 209, 174, 1),
                        ),
                        onPressed: () async {
                          final form = _formKey.currentState;

                          if (form!.validate()) {
                            form.save();
                            if (await _authController.login(
                                _user.username, _user.password)) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MyApp(),
                                ),
                              );
                            }
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(11.0),
                          child: Text(
                            'LOG IN',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Atau login dengan
                  Row(children: const <Widget>[
                    Expanded(
                      child: Divider(),
                    ),
                    Text("Atau login dengan"),
                    Expanded(
                      child: Divider(),
                    ),
                  ]),

                  const SizedBox(height: 32),

                  // Tombol google login
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          primary: const Color.fromRGBO(255, 255, 255, 1),
                        ),
                        onPressed: () {
                          // final form = _formKey.currentState;
                          // if (form!.validate()) {
                          //   form.save();
                          // }
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(11.0),
                          child: Text(
                            'Google',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  // Belum punya akun
                  const BelumPunyaAKun(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
