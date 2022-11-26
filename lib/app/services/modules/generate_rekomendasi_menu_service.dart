import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mps/app/models/generate_rekomendasi_menu_model.dart';
import 'package:mps/app/serializers/generate_rekomendasi_menu_serializer.dart';

class GenerateRekomendasiMenuService {
  final String? _baseUrl = dotenv.env['BASE_URL'];
  final String endpoint = "/api/generate-rekomendasi-menu"; // Alamat endpoint

  Future post(GenerateRekomendasiMenu generateRekomendasiMenu) async {
    try {
      final url = Uri.http(_baseUrl.toString(), endpoint);

      var request = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(
          {
            "berat_badan": generateRekomendasiMenu.beratBadan,
            "tinggi_badan": generateRekomendasiMenu.tinggiBadan,
            "gender": generateRekomendasiMenu.gender,
            "usia": generateRekomendasiMenu.usia,
            "nilai_tingkat_aktivitas":
                generateRekomendasiMenu.nilaiTingkatAktivitas,
            "with_detail": generateRekomendasiMenu.withDetail,
          },
        ),
      );

      var response = jsonDecode(request.body);
      return GenerateRekomendasiMenuSerializer.fromJson(response);
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
