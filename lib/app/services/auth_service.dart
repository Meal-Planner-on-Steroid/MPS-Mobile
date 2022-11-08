import 'package:flutter/material.dart';
import 'package:mps/models/auth_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future saveAuth(Auth auth) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('access', auth.access);
    await prefs.setString('refresh', auth.refresh);

    final access = prefs.getString('access') ?? '';
    final refresh = prefs.getString('refresh') ?? '';

    debugPrint(access);
    debugPrint(refresh);

    debugPrint('Auth saved');
  }

  Future<Auth> getAuth() async {
    final prefs = await SharedPreferences.getInstance();

    final access = prefs.getString('access') ?? '';
    final refresh = prefs.getString('refresh') ?? '';

    debugPrint(access);
    debugPrint(refresh);

    return Auth(
      refresh: refresh,
      access: access,
    );
  }

  Future deleteAuth() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      await prefs.remove('access');
      await prefs.remove('refresh');

      debugPrint('Auth preference deleted');

      return true;
    } on Exception catch (_) {
      return false;
    }
  }

  Future login(String username, String password) async {
    try {
      // TODO: ubah menjadi base_url
      // http://127.0.0.1:8000/auth/login
      final url = Uri.http('192.168.1.18:8000', 'api/auth/login');

      debugPrint(url.toString());
      debugPrint('username: $username');
      debugPrint('password: $password');

      var response = await http
          .post(url, body: {"username": username, "password": password});

      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      if (response.statusCode != 200) {
        return false;
      }

      return response.body;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
