import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mps/app/models/user_profile_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mps/app/serializers/hasil_kebutuhan_gizi_serializer.dart';

class KebutuhanGiziService {
  final String? _baseUrl = dotenv.env['BASE_URL'];
  final String endpoint = '/api/kebutuhan-gizi';

  Future post(UserProfile userProfile) async {
    try {
      final url = Uri.http(_baseUrl.toString(), endpoint);

      var request = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(
          {
            "berat_badan": userProfile.beratBadan,
            "tinggi_badan": userProfile.tinggiBadan,
            "usia": userProfile.usia,
            "gender": userProfile.gender,
            "nilai_tingkat_aktivitas": userProfile.tingkatAktivitasNilai,
          },
        ),
      );

      var response = jsonDecode(request.body);
      return HasilKebutuhanGiziSerializer.fromJson(response);
    } on Exception catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
