import 'package:flutter/material.dart';
import 'package:mps/models/auth_model.dart';
import 'package:mps/services/auth_service.dart';

class User {
  final _authService = AuthService();

  String firstName = '';
  String lastName = '';
  String email = '';
  String username = '';
  String password = '';

  save() async {
    try {
      final newAuth = Auth(refresh: 'refresh', access: 'access');
      await _authService.saveAuth(newAuth);

      debugPrint('User save');
      return true;
    } on Exception catch (_) {
      debugPrint('Something went wrong');
      return false;
    }
  }
}
