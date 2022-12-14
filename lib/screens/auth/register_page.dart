import 'package:flutter/material.dart';
import 'package:mps/app/controllers/pages/auth_controller.dart';
import 'package:mps/app/models/user_model.dart';
import 'package:mps/screens/auth/login_page.dart';
import '../../utils/sudah_punya_akun.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _user = User();
  final _authController = AuthController();

  bool isError = false;
  String errorMessage = '';

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
                    'Buat akun anda 📓',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),

                  const SizedBox(height: 64),

                  // input nama depan
                  TextFormField(
                    cursorColor: Colors.black,
                    decoration: const InputDecoration(
                      hintText: 'Nama depan',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(9),
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Tolong masukkan Nama depan';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      setState(() {
                        _user.firstName = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 8),

                  // Input nama belakang
                  TextFormField(
                    cursorColor: Colors.black,
                    decoration: const InputDecoration(
                      hintText: 'Nama belakang',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(9),
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Tolong masukkan Nama belakaang';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      setState(() {
                        _user.lastName = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 8),

                  // Input email
                  TextFormField(
                    cursorColor: Colors.black,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(9),
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Tolong masukkan email';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      setState(() {
                        _user.email = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 8),

                  // Input username
                  TextFormField(
                    cursorColor: Colors.black,
                    decoration: const InputDecoration(
                      hintText: 'Username',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(9),
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Tolong masukkan username';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      setState(() {
                        _user.username = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 8),

                  // Input password
                  TextFormField(
                    cursorColor: Colors.black,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(9),
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Tolong masukkan password';
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

                  // Tombol login
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          backgroundColor:
                              const Color.fromRGBO(127, 209, 174, 1),
                        ),
                        onPressed: () async {
                          final form = _formKey.currentState;
                          if (form!.validate()) {
                            form.save();
                            if (await _authController.register(_user)) {
                              debugPrint("User registered");
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ),
                              );
                              return;
                            }
                            setState(() {
                              isError = !isError;
                              errorMessage =
                                  "Maaf, terjadi masalah pada registrasi 😢";
                            });
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(11.0),
                          child: Text(
                            'DAFTAR',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  Visibility(
                    visible: isError,
                    child: Text(
                      errorMessage,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const Spacer(),

                  // Belum punya akun
                  const SudahPunyaAkun(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
