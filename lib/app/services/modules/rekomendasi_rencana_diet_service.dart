import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mps/app/filters/rekomendasi_rencana_diet_filter.dart';
import 'package:mps/app/serializers/rekomendasi_makanan_diet_serializer.dart';

class RekomendasiRencanaDietService {
  final String? _baseUrl = dotenv.env['BASE_URL'];
  final String endpoint = "/api/rekomendasi-rencana-diet/"; // Alamat endpoint

  Future get(RekomendasiRencanaDietFilter rekomendasiRencanaDietFilter) async {
    try {
      final queryParams = {
        "id": rekomendasiRencanaDietFilter.id,
        "order_by": rekomendasiRencanaDietFilter.orderBy
      };

      final url = Uri.http(_baseUrl.toString(), endpoint, queryParams);
      debugPrint(url.toString());

      var request = await http.get(url);

      final response = jsonDecode(request.body);
      return RekomendasiMakananDietSerializer.fromJson(response);
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future getObject(String id) async {
    try {
      final url = Uri.http(
        _baseUrl.toString(),
        "$endpoint/$id/",
      );

      var request = await http.get(url);

      final response = jsonDecode(request.body);
      return RekomendasiMakananDietSerializer.fromJson(response);
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
