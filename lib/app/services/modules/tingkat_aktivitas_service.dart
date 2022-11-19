import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mps/app/filters/tingkat_aktivitas_filter.dart';
import 'package:mps/app/serializers/tingkat_aktivitas_serializer.dart';

class TingkatAktivitasService {
  final String? _baseUrl = dotenv.env['BASE_URL'];
  final String endpoint = 'api/aktivitas';

  Future get(TingkatAktivitasFilter tingkatAktivitasFilter) async {
    try {
      final queryParams = {
        'id': tingkatAktivitasFilter.id,
        'nama': tingkatAktivitasFilter.nama,
        'nilai': tingkatAktivitasFilter.nilai,
        'gender': tingkatAktivitasFilter.gender,
      };

      final url = Uri.http(_baseUrl.toString(), endpoint, queryParams);

      var request = await http.get(url);

      final response = jsonDecode(request.body);
      return TingkatAktivitasSeralizer.fromJson(response);
    } on Exception catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
