import 'package:flutter/material.dart';
import 'package:mps/app/filters/preferensi_makanan_filter.dart';
import 'package:mps/app/filters/tingkat_aktivitas_filter.dart';
import 'package:mps/app/filters/user_profile_filter.dart';
import 'package:mps/app/models/generate_rekomendasi_menu_model.dart';
import 'package:mps/app/services/modules/generate_rekomendasi_menu_service.dart';
import 'package:mps/app/services/modules/preferensi_makanan_service.dart';
import 'package:mps/app/services/modules/tingkat_aktivitas_service.dart';
import 'package:mps/app/services/modules/user_profile_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GenerateRekomendasiMenuController {
  final _genereateRekomendasiMenuService = GenerateRekomendasiMenuService();
  final _userProfileService = UserProfileService();
  final _tingkatAktivitasService = TingkatAktivitasService();
  final _preferensiMakananService = PreferensiMakananService();

  var generateRekomendasiMenu = GenerateRekomendasiMenu();

  var userProfileFilter = UserProfileFilter();
  var tingkatAktivitasFilter = TingkatAktivitasFilter();
  var preferensiMakananFilter = PreferensiMakananFilter();

  Future post() async {
    try {
      // Ambil data yang dibutuhkan
      final prefs = await SharedPreferences.getInstance();

      var userId = int.parse(prefs.getString('userId') ?? '');
      userProfileFilter.userId = userId.toString();
      var userProfileData = await _userProfileService.get(userProfileFilter);

      if (userProfileData == false) {
        debugPrint('Gagal mengambil user profile');
        return false;
      }

      debugPrint(userProfileData.message);

      var userProfileDataBody = userProfileData.data[0];

      // Persiapkan data
      generateRekomendasiMenu.beratBadan = userProfileDataBody.beratBadan ?? 0;
      generateRekomendasiMenu.tinggiBadan =
          userProfileDataBody.tinggiBadan ?? 0;
      generateRekomendasiMenu.gender = userProfileDataBody.gender ?? '';
      generateRekomendasiMenu.usia = userProfileDataBody.usia ?? 0;

      // Ambil tingkat aktivitas
      tingkatAktivitasFilter.id =
          userProfileDataBody.tingkatAktivitasId.toString();
      var tingkatAktivitas =
          await _tingkatAktivitasService.get(tingkatAktivitasFilter);

      if (tingkatAktivitas == false) {
        debugPrint('Gagal mengambil tingkat aktivitas');
        return false;
      }

      debugPrint(tingkatAktivitas.message);

      generateRekomendasiMenu.nilaiTingkatAktivitas =
          tingkatAktivitas.data[0]['nilai'] ?? 0;

      // Ambil makanan blok
      List<int> listBlokMakanan = await makeListMakananIds();
      generateRekomendasiMenu.blokMakanan = listBlokMakanan;

      // Buat request
      var request =
          await _genereateRekomendasiMenuService.post(generateRekomendasiMenu);

      if (request == false) {
        debugPrint('Terjadi masalah saat pembuatan rekomendasi menu');
        return false;
      }

      debugPrint(request.message);

      return request;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<List<dynamic>> getPreferensiMakanan(
      PreferensiMakananFilter preferensiMakananFilter) async {
    final prefs = await SharedPreferences.getInstance();
    preferensiMakananFilter.userId = prefs.getString('userId');
    preferensiMakananFilter.jenis = 'BL';

    var request = await _preferensiMakananService.get(preferensiMakananFilter);

    return request.data;
  }

  Future<List<int>> makeListMakananIds() async {
    List listPreferensiMakanan =
        await getPreferensiMakanan(preferensiMakananFilter);
    List<int> result = [];
    for (var item in listPreferensiMakanan) {
      result.add(item.makananId);
    }

    return result;
  }
}
