import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mps/app/filters/makanan_filter.dart';
import 'package:mps/app/models/makanan_model.dart';
import 'package:http/http.dart' as http;
import 'package:mps/app/serializers/makanan_serializer.dart';

class MakananService {
  final String? _baseUrl = dotenv.env['BASE_URL'];
  final String endpoint = "/api/makanan/";

  Future get(MakananFilter makananFilter) async {
    try {
      final queryParams = {
        "id": makananFilter.id,
        "id__in": makananFilter.idIn,
        "nama": makananFilter.nama,
        "nama__icontains": makananFilter.namaIcontains,
        "porsi": makananFilter.porsi,
        "lemak": makananFilter.lemak,
        "protein": makananFilter.protein,
        "karbo": makananFilter.karbo,
        "energi": makananFilter.energi,
        "jenis": makananFilter.jenis,
        "page": makananFilter.page,
        "limit": makananFilter.limit,
      };

      var url = Uri.http(_baseUrl.toString(), endpoint, queryParams);
      var decodeUrl = Uri.decodeFull(url.toString());

      url = Uri.parse(decodeUrl);

      // debugPrint(url.toString());

      var request = await http.get(url);

      final response = jsonDecode(request.body);

      // debugPrint(response.toString());

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
        "$endpoint$id/",
      );

      var request = await http.get(url);

      final response = jsonDecode(request.body);
      debugPrint(response.toString());
      return MakananSerializer.fromJson(response);
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future post(Makanan makanan) async {
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
