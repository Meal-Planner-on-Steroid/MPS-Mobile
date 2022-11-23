import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:mps/app/models/auth_model.dart';
import 'package:mps/app/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthService {
  final String? _baseUrl = dotenv.env['BASE_URL'];

  Map<String, dynamic> decodeToken(String token) {
    Map<String, dynamic> payload = Jwt.parseJwt(token);

    return payload;
  }

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

    // debugPrint(access);
    // debugPrint(refresh);

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
      final url = Uri.http(_baseUrl.toString(), 'api/auth/login');

      debugPrint(url.toString());
      debugPrint('username: $username');
      debugPrint('password: $password');

      var response = await http
          .post(url, body: {"username": username, "password": password});

      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      if (response.statusCode != 200) {
        debugPrint('Response status: ${response.statusCode}');
        return false;
      }

      return response.body;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future register(User user) async {
    try {
      final url = Uri.http(_baseUrl.toString(), 'api/auth/register');

      debugPrint(url.toString());

      var response = await http.post(url, body: {
        "first_name": user.firstName,
        "last_name": user.lastName,
        "email": user.email,
        "username": user.username,
        "password": user.password,
      });

      if (response.statusCode != 200) {
        return false;
      }

      return true;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
