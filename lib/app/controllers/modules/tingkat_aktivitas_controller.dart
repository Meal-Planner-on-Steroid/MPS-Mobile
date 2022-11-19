import 'package:flutter/material.dart';
import 'package:mps/app/filters/tingkat_aktivitas_filter.dart';
import 'package:mps/app/services/modules/tingkat_aktivitas_service.dart';

class TingkatAktivitasController {
  final _tingkatAktivitasService = TingkatAktivitasService();

  Future get(TingkatAktivitasFilter tingkatAktivitasFilter) async {
    try {
      var response = await _tingkatAktivitasService.get(tingkatAktivitasFilter);

      if (response == false) {
        debugPrint('Gagal mengambil tingkat aktivitas');
        return false;
      }

      debugPrint("Berhasil mengambil tingkat aktivitas");

      return response;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
