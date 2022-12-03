import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mps/app/filters/rencana_diet_filter.dart';
import 'package:mps/app/services/modules/rencana_diet_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController {
  // final _makananFavoritService = MakananFavoritService();
  final _rencanaDietService = RencanaDietService();

  RencanaDietFilter rencanaDietFilter = RencanaDietFilter();

  Future get(String tanggal) async {
    try {
      Map<String, dynamic> result = {};
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // Ambil rencana diet di tanggal ini
      rencanaDietFilter.tanggal = tanggal;
      rencanaDietFilter.userId = prefs.getString('userId');
      var responseRencanaDiet =
          await _rencanaDietService.get(rencanaDietFilter);
      result['rencana_diet'] = responseRencanaDiet;

      // Ambil rencana diet makanan

      // Ambil rencana diet minum

      // Ambil rencana diet olahraga

      inspect(result['rencana_diet']);

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
