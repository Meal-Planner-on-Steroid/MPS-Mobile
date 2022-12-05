import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mps/app/filters/rencana_diet_makanan_filter.dart';
import 'package:mps/app/serializers/rencana_diet_makanan_serializer.dart';

class RencanaDietMakananService {
  final String? _baseUrl = dotenv.env['BASE_URL'];
  final String endpoint = "/api/rencana-diet-makanan/"; // Alamat endpoint

  Future get(RencanaDietMakananFilter rencanaDietMakananFilter) async {
    try {
      final queryParams = {
        "waktu_makan": rencanaDietMakananFilter.waktuMakan,
        "status": rencanaDietMakananFilter.status,
        "makanan_id": rencanaDietMakananFilter.makananId,
        "rencana_diet_id": rencanaDietMakananFilter.rencanaDietId,
        "rencana_diet_id__in": rencanaDietMakananFilter.rencanaDietIdIn,
        "limit": rencanaDietMakananFilter.limit,
        "page": rencanaDietMakananFilter.page,
        "order_by": rencanaDietMakananFilter.orderBy,
      };

      var url = Uri.http(_baseUrl.toString(), endpoint, queryParams);
      var decodeUrl = Uri.decodeFull(url.toString());

      url = Uri.parse(decodeUrl);

      // debugPrint(url.toString());

      var request = await http.get(url);

      final response = jsonDecode(request.body);
      return RencanaDietMakananSerializer.fromJson(response);
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future getObject() async {
    try {
      return true;
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
