import 'package:flutter/material.dart';
import 'package:mps/app/filters/makanan_filter.dart';
import 'package:mps/app/models/makanan_model.dart';
import 'package:mps/app/services/pages/makanan_favorit_service.dart';

class MakananFavoritController {
  final _makananFavoritService = MakananFavoritService();

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
