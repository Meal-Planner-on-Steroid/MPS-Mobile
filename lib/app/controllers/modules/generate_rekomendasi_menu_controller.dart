import 'package:flutter/material.dart';
import 'package:mps/app/models/generate_rekomendasi_menu_model.dart';
import 'package:mps/app/services/modules/generate_rekomendasi_menu_service.dart';

class GenerateRekomendasiMenuController {
  final _genereateRekomendasiMenuService = GenerateRekomendasiMenuService();

  Future post(GenerateRekomendasiMenu generateRekomendasiMenu) async {
    try {
      var request =
          await _genereateRekomendasiMenuService.post(generateRekomendasiMenu);

      if (request == false) {
        debugPrint('Terjadi masalah saat pembuatan rekomendasi menu');
        return false;
      }

      debugPrint("Berhasil membuat rekomendasi menu");

      return request;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
