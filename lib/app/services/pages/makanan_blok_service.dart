import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mps/app/filters/makanan_filter.dart';
import 'package:mps/app/models/makanan_model.dart';

class MakananFavoritService {
  // ignore: unused_field
  final String? _baseUrl = dotenv.env['BASE_URL'];
  final String endpoint = "/api/preferensi-makanan/";

  Future get(MakananFilter makananFilter) async {
    try {
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future getObject(String id) async {
    try {
      return true;
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
