import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mps/app/models/user_profile_model.dart';
import 'package:mps/app/serializers/user_profile_serializer.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HitungKebutuhanGiziService {
  final String? _baseUrl = dotenv.env['BASE_URL'];
  final String endpoint = "/api/users-profile/";

  Future get(int userId) async {
    try {
      final queryParams = {'user_id': userId.toString()};

      final url = Uri.http(_baseUrl.toString(), endpoint, queryParams);

      debugPrint(url.toString());

      var request = await http.get(url);

      final response = jsonDecode(request.body);
      return UserProfileSeralizer.fromJson(response);
    } on Exception catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future post(UserProfile userProfile) async {
    try {
      final url = Uri.http(_baseUrl.toString(), endpoint);

      debugPrint('Hitung kebutuhan gizi service post');
      debugPrint(url.toString());

      var request = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "user": {"id": userProfile.userId},
          "berat_badan": userProfile.beratBadan,
          "tinggi_badan": userProfile.tinggiBadan,
          "usia": userProfile.usia,
          "gender": userProfile.gender,
          "tingkat_aktivitas": {"id": userProfile.tingkatAktivitasId},
          "keseluruhan_energi": userProfile.keseluruhanEnergi,
          "imt": userProfile.imt,
          "butuh_protein": {
            "protein_10": userProfile.butuhProtein.protein10,
            "protein_15": userProfile.butuhProtein.protein15
          },
          "butuh_lemak": {
            "lemak_10": userProfile.butuhLemak.lemak10,
            "lemak_25": userProfile.butuhLemak.lemak25,
          },
          "butuh_karbo": {
            "karbo_60": userProfile.butuhKarbo.karbo60,
            "karbo_75": userProfile.butuhKarbo.karbo75,
          }
        }),
      );

      // ignore: todo
      // TODO: serialize list or object
      var response = jsonDecode(request.body);
      debugPrint(response.toString());
      response = UserProfileSeralizer.fromJson(response);

      if (response.statusCode != 200) {
        debugPrint(response.message.toString());
        return false;
      }

      debugPrint('Berhasil menyimpan user profile dan kebutuhan gizi');

      return true;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future put(UserProfile userProfile, dynamic userId) async {
    try {
      final url = Uri.http(_baseUrl.toString(), ("$endpoint$userId/"));

      debugPrint('Hitung kebutuhan gizi service put');
      debugPrint(url.toString());

      // ignore: unused_local_variable
      var request = await http.put(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "berat_badan": userProfile.beratBadan,
          "tinggi_badan": userProfile.tinggiBadan,
          "usia": userProfile.usia,
          "gender": userProfile.gender,
          "tingkat_aktivitas": {"id": userProfile.tingkatAktivitasId},
          "keseluruhan_energi": userProfile.keseluruhanEnergi,
          "imt": userProfile.imt,
          "butuh_protein": {
            "protein_10": userProfile.butuhProtein.protein10,
            "protein_15": userProfile.butuhProtein.protein15
          },
          "butuh_lemak": {
            "lemak_10": userProfile.butuhLemak.lemak10,
            "lemak_25": userProfile.butuhLemak.lemak25,
          },
          "butuh_karbo": {
            "karbo_60": userProfile.butuhKarbo.karbo60,
            "karbo_75": userProfile.butuhKarbo.karbo75,
          }
        }),
      );

      // ignore: todo
      // TODO: serialize list or object
      var response = jsonDecode(request.body);
      debugPrint(response.toString());
      response = UserProfileSeralizer.fromJson(response);

      if (response.statusCode != 200) {
        debugPrint(response.message.toString());
        return false;
      }

      debugPrint('Berhasil merubah user profile dan kebutuhan gizi');

      return true;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
