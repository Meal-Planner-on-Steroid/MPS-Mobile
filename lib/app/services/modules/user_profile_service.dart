import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mps/app/filters/user_profile_filter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mps/app/serializers/user_profile_serializer.dart';

class UserProfileService {
  final String? _baseUrl = dotenv.env['BASE_URL'];
  final String endpoint = '/api/users-profile';

  Future get(UserProfileFilter userProfileFilter) async {
    try {
      final queryParams = {
        'user_id': userProfileFilter.userId,
      };

      final url = Uri.http(_baseUrl.toString(), endpoint, queryParams);

      var request = await http.get(url);

      debugPrint(request.body.toString());

      final response = jsonDecode(request.body);
      return UserProfileSeralizer.fromJson(response);
    } catch (e) {
      debugPrint('Error waktu get user profile');
      debugPrint(e.toString());
      return false;
    }
  }

  // Future post(UserProfile userProfile) async {
  //   try {
  //     final url = Uri.http(_baseUrl.toString(), endpoint);

  //     var request = await http.post(
  //       url,
  //       headers: {"Content-Type": "application/json"},
  //       body: jsonEncode(
  //         {
  //           "berat_badan": userProfile.beratBadan,
  //           "tinggi_badan": userProfile.tinggiBadan,
  //           "usia": userProfile.usia,
  //           "gender": userProfile.gender,
  //           "nilai_tingkat_aktivitas": userProfile.tingkatAktivitasNilai,
  //         },
  //       ),
  //     );

  //     var response = jsonDecode(request.body);
  //     return HasilKebutuhanGiziSerializer.fromJson(response);
  //   } on Exception catch (e) {
  //     debugPrint(e.toString());
  //     return false;
  //   }
  // }
}
