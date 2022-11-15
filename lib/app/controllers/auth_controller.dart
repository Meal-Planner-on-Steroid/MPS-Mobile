import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mps/app/models/auth_model.dart';
import 'package:mps/app/services/auth_service.dart';
import 'package:mps/app/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  final _authService = AuthService();

  Future<Auth> getAuth() async {
    try {
      return await _authService.getAuth();
    } on Exception catch (e) {
      debugPrint(e.toString());
      return Auth(refresh: '', access: '');
    }
  }

  Future deleteAuth() async {
    try {
      await _authService.deleteAuth();

      return true;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future login(String username, String password) async {
    try {
      var response = await _authService.login(username, password);
      if (response == false) {
        debugPrint('fail');
        return false;
      }
      debugPrint('yey');

      final json = jsonDecode(response);

      // Simpan auth
      final newAuth = Auth(refresh: json['refresh'], access: json['access']);
      await _authService.saveAuth(newAuth);

      // Simpan decoded jwt access
      var decodeAccess = _authService.decodeToken(json['access']);
      final prefs = await SharedPreferences.getInstance();

      await prefs.setString('userId', decodeAccess['user_id'].toString());
      await prefs.setString('username', decodeAccess['username'].toString());

      return true;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future register(User user) async {
    try {
      var response = await _authService.register(user);

      if (response == false) {
        debugPrint('fail');
        return false;
      }

      debugPrint("yey");

      return true;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
