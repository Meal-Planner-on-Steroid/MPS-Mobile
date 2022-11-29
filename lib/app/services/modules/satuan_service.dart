import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mps/app/filters/satuan_filter.dart';
import 'package:http/http.dart' as http;
import 'package:mps/app/serializers/satuan_serializer.dart';

class SatuanService {
  final String? _baseUrl = dotenv.env['BASE_URL'];
  final String endpoint = "/api/satuan/";

  Future get(SatuanFilter satuanFilter) async {
    try {
      final queryParams = {
        "id": satuanFilter.id,
        "nama": satuanFilter.nama,
      };

      var url = Uri.http(_baseUrl.toString(), endpoint, queryParams);
      var decodeUrl = Uri.decodeFull(url.toString());

      url = Uri.parse(decodeUrl);

      debugPrint(url.toString());

      var request = await http.get(url);

      final response = jsonDecode(request.body);

      // debugPrint(response.toString());

      return SatuanSerializer.fromJson(response);
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
      return SatuanSerializer.fromJson(response);
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
