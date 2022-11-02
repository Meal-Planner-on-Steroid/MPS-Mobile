import 'package:flutter/material.dart';
import 'package:mps/models/auth_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future saveAuth(Auth auth) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('access', auth.access);
    await prefs.setString('refresh', auth.refresh);

    // TODO: request untuk ambil access dan refresh
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

      // TODO: request untuk hapus access dan request
      await prefs.remove('access');
      await prefs.remove('refresh');

      debugPrint('Auth preference deleted');

      return true;
    } on Exception catch (_) {
      return false;
    }
  }
}
