import 'package:flutter/material.dart';
import 'package:mps/app/filters/preferensi_makanan_filter.dart';
import 'package:mps/app/models/preferensi_makanan_model.dart';
import 'package:mps/app/services/modules/preferensi_makanan_service.dart';

class PreferensiMakananController {
  final _preferensiMakananService = PreferensiMakananService();

  Future get(PreferensiMakananFilter preferensiMakananFilter) async {
    try {
      var response =
          await _preferensiMakananService.get(preferensiMakananFilter);

      if (response == false) {
        debugPrint('Gagal mengambil list preferensi makanan');
        return false;
      }

      debugPrint("Berhasil mengambil list preferensi makanan");

      return response;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future getObject(String id) async {
    try {
      var response = await _preferensiMakananService.getObject(id);

      if (response == false) {
        debugPrint('Gagal mengambil object preferensi makanan');
        return false;
      }

      debugPrint("Berhasil mengambil object preferensi makanan");

      return response;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future post(PreferensiMakanan preferensiMakanan) async {
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
