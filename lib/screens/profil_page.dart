import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:getwidget/components/toast/gf_toast.dart';
import 'package:getwidget/position/gf_toast_position.dart';
import 'package:mps/app/controllers/pages/profil_page_controller.dart';
import 'package:mps/app/models/user_model.dart';
import 'package:mps/app/serializers/user_serializer.dart';

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

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  User userModel = User();

  final _profilePageController = ProfilPageController();

  late Future<UserSerializer> futureUser;

  Future<UserSerializer> getUserData() async {
    try {
      var result = await _profilePageController.getObject();

      setState(() {
        firstNameController.text = result.data.firstName;
        lastNameController.text = result.data.lastName;
        usernameController.text = result.data.username;
        emailController.text = result.data.email;
      });

      return result;
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    firstNameController.dispose();
    lastNameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    futureUser = getUserData();
  }

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
                      enabled: false,
                      controller: emailController,
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
                          return 'Tolong masukkan email';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        setState(() {
                          userModel.email = value!;
                        });
                      },
                    ),

                    // Username
                    TextFormField(
                      enabled: false,
                      controller: usernameController,
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
                          return 'Tolong masukkan username';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        setState(() {
                          userModel.username = value!;
                        });
                      },
                    ),

                    // First name
                    TextFormField(
                      controller: firstNameController,
                      decoration: const InputDecoration(
                        labelText: 'Nama depan',
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
                          return 'Tolong masukkan nama depan';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        // firstNameController.clear();
                        setState(() {
                          debugPrint('im saving $value');
                          userModel.firstName = value!;
                        });
                      },
                    ),

                    // Last name
                    TextFormField(
                      controller: lastNameController,
                      decoration: const InputDecoration(
                        labelText: 'Nama belakang',
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
                          return 'Tolong masukkan nama terakhir';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        setState(() {
                          userModel.lastName = value!;
                        });
                      },
                    ),

                    // Tombol update profil
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                            primary: const Color.fromRGBO(127, 209, 174, 1),
                          ),
                          onPressed: () async {
                            final form = _profilFormKey.currentState;
                            if (form!.validate()) {
                              form.save();

                              inspect(userModel);

                              if (await _profilePageController
                                  .changeProfile(userModel)) {
                                GFToast.showToast(
                                  'Berhasil update profil',
                                  context,
                                  toastPosition: GFToastPosition.BOTTOM,
                                );
                              } else {
                                GFToast.showToast(
                                  'Gagal update profil',
                                  context,
                                  toastPosition: GFToastPosition.BOTTOM,
                                );
                              }
                            }
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
                      obscureText: true,
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
                          return 'Tolong masukkan password lama';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        setState(() {
                          userModel.password = value!;
                        });
                      },
                    ),

                    // Password baru
                    TextFormField(
                      obscureText: true,
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
                          return 'Tolong masukkan password baru';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        setState(() {
                          userModel.newPassword = value!;
                        });
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
                          onPressed: () async {
                            final form = _passwordFormKey.currentState;
                            if (form!.validate()) {
                              form.save();

                              if (await _profilePageController
                                  .changePassword(userModel)) {
                                GFToast.showToast(
                                  'Berhasil update password',
                                  context,
                                  toastPosition: GFToastPosition.BOTTOM,
                                );
                              } else {
                                GFToast.showToast(
                                  'Gagal update password',
                                  context,
                                  toastPosition: GFToastPosition.BOTTOM,
                                );
                              }

                              inspect(userModel);
                            }
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
