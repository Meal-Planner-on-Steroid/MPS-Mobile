import 'package:flutter/material.dart';
import 'package:mps/app/filters/tingkat_aktivitas_filter.dart';
import 'package:mps/app/services/tingkat_aktivitas_service.dart';

class TingkatAktivitasController {
  final _tingkatAktivitasService = TingkatAktivitasService();

  Future get(TingkatAktivitasFilter tingkatAktivitasFilter) async {
    try {
      var response = await _tingkatAktivitasService.get(tingkatAktivitasFilter);

      if (response == false) {
        debugPrint('fail');
        return false;
      }

      debugPrint("yey");
      debugPrint(response.message);
      debugPrint(response.statusCode.toString());

      return response;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
