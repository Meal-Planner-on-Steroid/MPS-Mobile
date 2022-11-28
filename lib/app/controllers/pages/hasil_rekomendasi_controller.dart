import 'package:flutter/material.dart';
import 'package:mps/app/filters/tingkat_aktivitas_filter.dart';
import 'package:mps/app/filters/user_profile_filter.dart';
import 'package:mps/app/models/rencana_diet_model.dart';
import 'package:mps/app/models/riwayat_rekomendasi_rencana_diet_model.dart';
import 'package:mps/app/services/modules/rencana_diet_service.dart';
import 'package:mps/app/services/modules/riwayat_rekomendasi_rencana_diet_service.dart';

class HasilRekomendasiController {
  final _riwayatRekomendasiRencanaDietService =
      RiwayatRekomendasiRencanaDietService();
  final _rencaDietService = RencanaDietService();

  var tingkatAktivitasFilter = TingkatAktivitasFilter();
  var userProfileFilter = UserProfileFilter();

  var riwayatRekomendasiRencanaDiet = RiwayatRekomendasiRencanaDiet();
  var rencanaDiet = RencanaDiet();

  Future get() async {
    try {
      return true;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future post(dynamic data) async {
    try {
      // Insert riwayat rekomendasi rencana diet
      var insertRiwayatRekomendasi = _riwayatRekomendasiRencanaDietService
          .post(riwayatRekomendasiRencanaDiet);

      // Insert for loop rencana diet
      var insertRencanaDiet = _rencaDietService.post(rencanaDiet);

      return true;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
