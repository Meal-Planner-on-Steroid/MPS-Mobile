import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mps/app/filters/rekomendasi_makanan_diet_filter.dart';
import 'package:mps/app/serializers/rekomendasi_rencana_diet_serializer.dart';

class RekomendasiMakananDietService {
  final String? _baseUrl = dotenv.env['BASE_URL'];
  final String endpoint = "/api/rekomendasi-makanan-diet/"; // Alamat endpoint

  Future get(RekomendasiMakananDietFilter rekomendasiMakananDietFilter) async {
    try {
      final queryParams = {
        "id": rekomendasiMakananDietFilter.id,
        "waktu_makan": rekomendasiMakananDietFilter.waktuMakan,
        "makanan_id": rekomendasiMakananDietFilter.makananId,
        "riwayat_rekomendasi_id":
            rekomendasiMakananDietFilter.riwayatRekomendasiId,
        "order_by": rekomendasiMakananDietFilter.orderBy
      };

      final url = Uri.http(_baseUrl.toString(), endpoint, queryParams);
      debugPrint(url.toString());

      var request = await http.get(url);

      final response = jsonDecode(request.body);
      return RekomendasiRencanaDietSerializer.fromJson(response);
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future getObject(String id) async {
    try {
      final url = Uri.http(
        _baseUrl.toString(),
        "$endpoint$id/",
      );

      var request = await http.get(url);

      final response = jsonDecode(request.body);
      return RekomendasiRencanaDietSerializer.fromJson(response);
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
