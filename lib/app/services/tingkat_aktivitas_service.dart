import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mps/app/serializers/tingkat_aktivitas_serializer.dart';

class TingkatAktivitasService {
  final String? _baseUrl = dotenv.env['BASE_URL'];

  Future get(String gender) async {
    try {
      final queryParams = {'gender': gender.toString()};

      final url = Uri.http(_baseUrl.toString(), 'api/aktivitas/', queryParams);

      debugPrint(url.toString());

      var response = await http.get(url);

      debugPrint(response.body);

      final result = jsonDecode(response.body);
      return TingkatAktivitasSeralizer.fromJson(result);
    } on Exception catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
