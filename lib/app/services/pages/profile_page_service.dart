import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mps/app/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:mps/app/serializers/user_serializer.dart';

class ProfilPageService {
  // ignore: unused_field
  final String? _baseUrl = dotenv.env['BASE_URL'];
  final String endpoint = "/api/users/"; // Alamat endpoint

  Future get() async {
    try {
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future getObject(String id) async {
    try {
      final url = Uri.http(
        _baseUrl.toString(),
        "$endpoint$id",
      );

      debugPrint(url.toString());

      var request = await http.get(url);

      final response = jsonDecode(request.body);
      debugPrint(response.toString());
      return UserSerializer.fromJson(response);
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future chageProfil(String id, User userModel) async {
    try {
      final url = Uri.http(
        _baseUrl.toString(),
        "$endpoint$id/edit/",
      );

      debugPrint(url.toString());

      var request = await http.put(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          // "email": userModel.email,
          // "username": userModel.username,
          "first_name": userModel.firstName,
          "last_name": userModel.lastName,
        }),
      );

      final response = jsonDecode(request.body);
      debugPrint(response.toString());
      // return UserSerializer.fromJson(response);
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future changePassword(String id, User userModel) async {
    try {
      final url = Uri.http(
        _baseUrl.toString(),
        "$endpoint$id/edit-password/",
      );

      debugPrint(url.toString());

      var request = await http.put(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "old_password": userModel.password,
          "new_password": userModel.newPassword,
        }),
      );

      final response = jsonDecode(request.body);
      debugPrint(response.toString());
      // return UserSerializer.fromJson(response);
      return response;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future post() async {
    try {
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future delete() async {
    try {
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
