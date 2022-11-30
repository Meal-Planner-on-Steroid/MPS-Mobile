import 'package:flutter/material.dart';
import 'package:mps/app/filters/makanan_filter.dart';
import 'package:mps/app/models/makanan_model.dart';
import 'package:mps/app/services/modules/makanan_service.dart';
import 'package:mps/app/services/modules/rekomendasi_makanan_diet_service.dart';
import 'package:mps/app/services/modules/rekomendasi_rencana_diet_service.dart';
import 'package:mps/app/services/modules/riwayat_rekomendasi_rencana_diet_service.dart';
import 'package:mps/app/services/pages/makanan_favorit_service.dart';

class RiwayatDetailController {
  // ignore: unused_field
  final _makananFavoritService = MakananFavoritService();
  final _riwayatRekomendasiRencanaDietService =
      RiwayatRekomendasiRencanaDietService();
  final _rekomendasiRencanaDietService = RekomendasiRencanaDietService();
  final _rekomendasiMakananDietService = RekomendasiMakananDietService();
  final _makananService = MakananService();

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
