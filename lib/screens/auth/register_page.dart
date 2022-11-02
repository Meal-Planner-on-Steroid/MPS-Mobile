import 'package:flutter/material.dart';
// import '../../utils/belum_punya_akun.dart';
import '../../utils/sudah_punya_akun.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

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

                  // Register input
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'First name'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your first name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Last name'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your last name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Username'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Password'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
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
                          primary: const Color.fromRGBO(127, 209, 174, 1),
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
