import 'package:flutter/material.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => ResetPasswordPageState();
}

class ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    'Reset password 🔧',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),

                  const SizedBox(height: 64),

                  // Reset input
                  TextFormField(
                    decoration:
                        const InputDecoration(labelText: 'Password baru'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your new password';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Ketik kembali password baru'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your new password';
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
                          primary: const Color.fromARGB(100, 127, 209, 174),
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
                            'Minta Reset Password',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
