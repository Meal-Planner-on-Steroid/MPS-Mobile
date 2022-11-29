import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mps/app/filters/bahan_makanan_filter.dart';
import 'package:http/http.dart' as http;
import 'package:mps/app/serializers/bahan_makanan_serializer.dart';

class BahanMakananService {
  final String? _baseUrl = dotenv.env['BASE_URL'];
  final String endpoint = "/api/makanan-terkait/";

  Future get(BahanMakananFilter bahanMakananFilter) async {
    try {
      final queryParams = {
        "id": bahanMakananFilter.id,
        "berat": bahanMakananFilter.berat,
        "berat__gt": bahanMakananFilter.beratGt,
        "berat__lt": bahanMakananFilter.beratLt,
        "satuan_id": bahanMakananFilter.satuanId,
        "bahan_makanan_id": bahanMakananFilter.bahanMakananId,
        "menu_makanan_id": bahanMakananFilter.menuMakananId,
      };

      var url = Uri.http(_baseUrl.toString(), endpoint, queryParams);
      var decodeUrl = Uri.decodeFull(url.toString());

      url = Uri.parse(decodeUrl);

      debugPrint(url.toString());

      var request = await http.get(url);

      final response = jsonDecode(request.body);

      // debugPrint(response.toString());

      return BahanMakananSerializer.fromJson(response);
    } on Exception catch (e) {
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
      debugPrint(response.toString());
      return BahanMakananSerializer.fromJson(response);
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

  Future delete(String id) async {
    try {
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
