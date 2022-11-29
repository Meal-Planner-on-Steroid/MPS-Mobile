import 'package:flutter/material.dart';
import 'package:mps/app/filters/bahan_makanan_filter.dart';
import 'package:mps/app/services/modules/bahan_makanan_service.dart';

class BahanMakananController {
  final _bahanMakananService = BahanMakananService();

  Future get(BahanMakananFilter bahanMakananFilter) async {
    try {
      var response = await _bahanMakananService.get(bahanMakananFilter);

      if (response == false) {
        debugPrint('Gagal mengambil list satuan');
        return false;
      }

      debugPrint("Berhasil mengambil list satuan");

      return response;
    } catch (e) {
      debugPrint(e.toString());
      debugPrint("error di controller");
      return false;
    }
  }

  Future getObject(String id) async {
    try {
      var response = await _bahanMakananService.getObject(id);

      if (response == false) {
        debugPrint('Gagal mengambil object satuan');
        return false;
      }

      debugPrint("Berhasil mengambil object satuan");

      return response;
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
