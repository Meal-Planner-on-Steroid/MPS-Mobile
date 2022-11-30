import 'package:flutter/material.dart';
import 'package:mps/app/filters/riwayat_rekomendasi_rencana_diet_filter.dart';
import 'package:mps/app/services/modules/riwayat_rekomendasi_rencana_diet_service.dart';

class RiwayatRekomendasiRencanaDietController {
  final _riwayatRekomendasiRencanaDietService =
      RiwayatRekomendasiRencanaDietService();

  Future get(
      RiwayatRekomendasiRencanaDietFilter
          riwayatRekomendasiRencanaDietFilter) async {
    try {
      var response = await _riwayatRekomendasiRencanaDietService
          .get(riwayatRekomendasiRencanaDietFilter);

      if (response == false) {
        debugPrint('Gagal mengambil list riwayat rekomendasi');
        return false;
      }

      debugPrint("Berhasil mengambil list riwayat rekomendasi");

      return response;
    } catch (e) {
      debugPrint(e.toString());
      debugPrint("error di controller");
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
