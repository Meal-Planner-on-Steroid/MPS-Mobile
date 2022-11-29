import 'package:flutter/material.dart';
import 'package:mps/app/filters/satuan_filter.dart';
import 'package:mps/app/services/modules/satuan_service.dart';

class SatuanController {
  final _satuanService = SatuanService();

  Future get(SatuanFilter satuanFilter) async {
    try {
      var response = await _satuanService.get(satuanFilter);

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
      var response = await _satuanService.getObject(id);

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
