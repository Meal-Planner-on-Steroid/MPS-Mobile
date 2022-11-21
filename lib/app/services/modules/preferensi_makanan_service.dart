import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mps/app/filters/preferensi_makanan_filter.dart';
import 'package:http/http.dart' as http;
import 'package:mps/app/models/preferensi_makanan_model.dart';
import 'package:mps/app/serializers/makanan_serializer.dart';

class PreferensiMakananService {
  final String? _baseUrl = dotenv.env['BASE_URL'];
  final String endpoint = "/api/preferensi-makanan/";

  Future get(PreferensiMakananFilter preferensiMakananFilter) async {
    try {
      final queryParams = {
        "id": preferensiMakananFilter.id,
        "user_id": preferensiMakananFilter.userId,
        "makanan_id": preferensiMakananFilter.makananId,
        "jenis": preferensiMakananFilter.jenis,
      };

      final url = Uri.http(_baseUrl.toString(), endpoint, queryParams);

      var request = await http.get(url);

      final response = jsonDecode(request.body);
      return MakananSerializer.fromJson(response);
    } on Exception catch (e) {
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
      return MakananSerializer.fromJson(response);
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future post(PreferensiMakanan preferensiMakanan) async {
    try {
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future delete(String id) async {
    try {
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
