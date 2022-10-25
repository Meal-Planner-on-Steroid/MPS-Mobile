import 'package:flutter/material.dart';

class ProfilPage extends StatefulWidget {
  final String fromPage;
  const ProfilPage({
    Key? key,
    required this.fromPage,
  }) : super(key: key);

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  final _profilFormKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.fromPage),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            // Avatar besar
            const CircleAvatar(
              backgroundImage: AssetImage('assets/images/user_random.jpg'),
              radius: 100,
            ),

            // Form Update profil
            const SizedBox(height: 32),
            Builder(
              builder: (context) => Form(
                key: _profilFormKey,
                child: Column(
                  children: <Widget>[
                    // Email
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        icon: Icon(
                          Icons.alternate_email,
                          color: Colors.black,
                        ),
                        suffixIcon: Icon(
                          Icons.edit,
                          color: Colors.black,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                    ),
                    // Username
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        icon: Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                        suffixIcon: Icon(
                          Icons.edit,
                          color: Colors.black,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                    ),
                    // Nama
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Nama',
                        icon: Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                        suffixIcon: Icon(
                          Icons.edit,
                          color: Colors.black,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    // Tombol update profil
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                            primary: const Color.fromRGBO(127, 209, 174, 1),
                          ),
                          onPressed: () {
                            // final form = _profilFormKey.currentState;
                            // if (form!.validate()) {
                            //   form.save();
                            // }
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(11.0),
                            child: Text(
                              'Update Profil',
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
                  ],
                ),
              ),
            ),

            // Form Update password
            const SizedBox(height: 32),
            Builder(
              builder: (context) => Form(
                key: _passwordFormKey,
                child: Column(
                  children: <Widget>[
                    // Password lama
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Password lama',
                        icon: Icon(
                          Icons.key,
                          color: Color.fromRGBO(127, 209, 174, 1),
                        ),
                        suffixIcon: Icon(
                          Icons.edit,
                          color: Colors.black,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                    ),
                    // Password baru
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Password baru',
                        icon: Icon(
                          Icons.key,
                          color: Colors.yellow.shade800,
                        ),
                        suffixIcon: const Icon(
                          Icons.edit,
                          color: Colors.black,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    // Tombol update profil
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                            primary: const Color.fromRGBO(127, 209, 174, 1),
                          ),
                          onPressed: () {
                            // final form = _passwordFormKey.currentState;
                            // if (form!.validate()) {
                            //   form.save();
                            // }
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(11.0),
                            child: Text(
                              'Update Profil',
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
