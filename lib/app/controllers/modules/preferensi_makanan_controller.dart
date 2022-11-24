import 'package:flutter/material.dart';
import 'package:mps/app/filters/preferensi_makanan_filter.dart';
import 'package:mps/app/models/preferensi_makanan_model.dart';
import 'package:mps/app/services/modules/preferensi_makanan_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferensiMakananController {
  final _preferensiMakananService = PreferensiMakananService();

  Future get(PreferensiMakananFilter preferensiMakananFilter) async {
    try {
      var request =
          await _preferensiMakananService.get(preferensiMakananFilter);

      if (request == false) {
        debugPrint('Gagal mengambil list preferensi makanan');
        return false;
      }

      debugPrint("Berhasil mengambil list preferensi makanan");

      return request;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future getObject(String id) async {
    try {
      var request = await _preferensiMakananService.getObject(id);

      if (request == false) {
        debugPrint('Gagal mengambil object preferensi makanan');
        return false;
      }

      debugPrint("Berhasil mengambil object preferensi makanan");

      return request;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future post(PreferensiMakanan preferensiMakanan) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      preferensiMakanan.userId = int.parse(prefs.getString('userId') ?? '');

      debugPrint('create preferensi');
      debugPrint('user id: ${preferensiMakanan.userId}');
      debugPrint('makanan id: ${preferensiMakanan.makananId}');
      debugPrint('jenis: ${preferensiMakanan.jenis}');

      var request = await _preferensiMakananService.post(preferensiMakanan);

      if (request == false) {
        debugPrint('Gagal mengambil membuat preferensi makanan');
        return false;
      }

      debugPrint("Berhasil mengambil membuat preferensi makanan");

      // return request;
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future delete(PreferensiMakanan preferensiMakanan) async {
    try {
      // Prepare
      final prefs = await SharedPreferences.getInstance();
      preferensiMakanan.userId = int.parse(prefs.getString('userId') ?? '');

      debugPrint('delete preferensi');
      debugPrint('user id: ${preferensiMakanan.userId}');
      debugPrint('makanan id: ${preferensiMakanan.makananId}');

      // Cari preferensi makanan berdasarkan userid dan makananID
      // Supaya sederhana di item builder
      PreferensiMakananFilter preferensiMakananFilter =
          PreferensiMakananFilter();

      preferensiMakananFilter.userId = preferensiMakanan.userId.toString();
      preferensiMakananFilter.makananId =
          preferensiMakanan.makananId.toString();

      var getPreferensiMakanan =
          await _preferensiMakananService.get(preferensiMakananFilter);

      if (getPreferensiMakanan == false) {
        debugPrint('Gagal mengambil list preferensi makanan');
        return false;
      }

      if (getPreferensiMakanan.data.length <= 0) {
        debugPrint('Data preferensi makanan tidak ditemukan');
        return false;
      }

      debugPrint("Berhasil mengambil list preferensi makanan");

      // Proses delete preferensi makanan dengan id data[0]
      debugPrint(getPreferensiMakanan.data.length.toString());
      int preferensiId = getPreferensiMakanan.data[0].id;

      debugPrint(preferensiId.toString());
      var request = await _preferensiMakananService.delete(preferensiId);

      if (request == false) {
        debugPrint('Gagal menghapus preferensi makanan');
        return false;
      }

      debugPrint("Berhasil menghapus preferensi makanan");

      // return request;
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
