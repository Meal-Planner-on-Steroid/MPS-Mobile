import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mps/app/services/auth_service.dart';
import 'package:mps/models/auth_model.dart';

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
      debugPrint(json);

      // TODO: simpan token access dan refresh
      // final newAuth = Auth(refresh: 'refresh', access: 'access');
      // await _authService.saveAuth(newAuth);

      return true;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}