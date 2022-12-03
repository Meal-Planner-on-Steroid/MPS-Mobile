import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mps/app/filters/rencana_diet_olahraga_filter.dart';
import 'package:mps/app/serializers/rencana_diet_olahraga_serializer.dart';

class RencanaDietOlahragaService {
  final String? _baseUrl = dotenv.env['BASE_URL'];
  final String endpoint = "/api/rencana-diet-olahraga/"; // Alamat endpoint

  Future get(RencanaDietOlahragaFilter rencanaDietOlahragaFilter) async {
    try {
      final queryParams = {
        "nama": rencanaDietOlahragaFilter.nama,
        "nama__icontains": rencanaDietOlahragaFilter.namaIcontains,
        "status": rencanaDietOlahragaFilter.status,
        "rencana_diet_id": rencanaDietOlahragaFilter.rencanaDietId,
      };

      final url = Uri.http(_baseUrl.toString(), endpoint, queryParams);

      // debugPrint(url.toString());

      var request = await http.get(url);

      final response = jsonDecode(request.body);
      return RencanaDietOlahragaSerializer.fromJson(response);
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
