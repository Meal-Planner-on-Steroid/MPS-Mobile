import 'package:flutter/material.dart';
import 'package:mps/app/filters/makanan_filter.dart';
import 'package:mps/app/services/modules/makanan_service.dart';

class MakananController {
  final _makananService = MakananService();

  Future get(MakananFilter makananFilter) async {
    try {
      var response = await _makananService.get(makananFilter);

      if (response == false) {
        debugPrint('Gagal mengambil list makanan');
        return false;
      }

      debugPrint("Berhasil mengambil list makanan");

      return response;
    } catch (e) {
      debugPrint(e.toString());
      debugPrint("error di controller");
      return false;
    }
  }

  Future getObject(String id) async {
    try {
      var response = await _makananService.getObject(id);

      if (response == false) {
        debugPrint('Gagal mengambil object makanan');
        return false;
      }

      debugPrint("Berhasil mengambil object makanan");

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
