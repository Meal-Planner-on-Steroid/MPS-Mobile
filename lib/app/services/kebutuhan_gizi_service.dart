import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mps/app/models/user_profile_model.dart';
import 'package:mps/app/serializers/user_profile_serializer.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class KebutuhanGiziService {
  final String? _baseUrl = dotenv.env['BASE_URL'];

  Future get(int userId) async {
    try {
      final queryParams = {'user_id': userId.toString()};

      final url =
          Uri.http(_baseUrl.toString(), 'api/users-profile/', queryParams);

      debugPrint(url.toString());

      var response = await http.get(url);

      debugPrint(response.body);

      final result = jsonDecode(response.body);
      return UserProfileSeralizer.fromJson(result);
    } on Exception catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future post(UserProfile userProfile) async {
    try {
      final url = Uri.http(_baseUrl.toString(), '/api/users-profile');

      debugPrint(url.toString());

      var response = await http.post(url, body: {
        "user": {"id": userProfile.userId},
        "berat_badan": userProfile.beratBadan,
        "tinggi_badan": userProfile.tinggiBadan,
        "usia": userProfile.usia,
        "gender": userProfile.gender,
        "tingkat_aktivitas": {"id": userProfile.tingkatAktivitasId},
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

  Future getKebutuhanGizi(UserProfile userProfile) async {
    try {
      final url = Uri.http(_baseUrl.toString(), '/api/kebutuhan-gizi');

      debugPrint(url.toString());

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

      return request.body;
    } on Exception catch (e) {
      debugPrint('error di getkebutuhangizi');
      debugPrint(e.toString());
      return false;
    }
  }
}
