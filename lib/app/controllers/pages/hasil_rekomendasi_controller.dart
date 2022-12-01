import 'package:flutter/material.dart';
import 'package:mps/app/filters/rencana_diet_filter.dart';
import 'package:mps/app/filters/tingkat_aktivitas_filter.dart';
import 'package:mps/app/filters/user_profile_filter.dart';
import 'package:mps/app/models/rencana_diet_model.dart';
import 'package:mps/app/models/riwayat_rekomendasi_rencana_diet_model.dart';
import 'package:mps/app/services/modules/rencana_diet_service.dart';
import 'package:mps/app/services/modules/riwayat_rekomendasi_rencana_diet_service.dart';
import 'package:mps/app/services/modules/user_profile_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HasilRekomendasiController {
  final _riwayatRekomendasiRencanaDietService =
      RiwayatRekomendasiRencanaDietService();
  final _userProfileService = UserProfileService();
  final _rencaDietService = RencanaDietService();

  var tingkatAktivitasFilter = TingkatAktivitasFilter();
  var userProfileFilter = UserProfileFilter();
  var rencanaDietFilter = RencanaDietFilter();

  var riwayatRekomendasiRencanaDiet = RiwayatRekomendasiRencanaDiet();
  KebutuhanGizi riwayatKebutuhanGizi = KebutuhanGizi();
  var rencanaDiet = RencanaDiet();

  List<String> waktuMakan = [
    "PH",
    "SI",
    "ML",
    "CA",
    "CA",
  ];

  Future get() async {
    try {
      return true;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future post(dynamic kebutuhanGizi, List<dynamic> rekomendasi) async {
    try {
      debugPrint('ini hasil rekomendasi controller');

      // Prepare insert riwayat rekomendasi rencana diet
      // User id
      final prefs = await SharedPreferences.getInstance();
      riwayatRekomendasiRencanaDiet.userId =
          int.parse(prefs.getString('userId') ?? '');

      // Kebutuhan gizi
      userProfileFilter.userId = prefs.getString('userId');
      var userProfileData = await _userProfileService.get(userProfileFilter);
      var userProfileDataBody = userProfileData.data[0];

      riwayatKebutuhanGizi.beratBadan = userProfileDataBody.beratBadan;
      riwayatKebutuhanGizi.tinggiBadan = userProfileDataBody.tinggiBadan;
      riwayatKebutuhanGizi.usia = userProfileDataBody.usia;
      riwayatKebutuhanGizi.gender = userProfileDataBody.gender;
      riwayatKebutuhanGizi.imt = userProfileDataBody.imt;
      riwayatKebutuhanGizi.keseluruhanEnergi =
          userProfileDataBody.keseluruhanEnergi;

      riwayatKebutuhanGizi.butuhProtein.protein10 =
          userProfileDataBody.butuhProtein.protein10;
      riwayatKebutuhanGizi.butuhProtein.protein15 =
          userProfileDataBody.butuhProtein.protein15;

      riwayatKebutuhanGizi.butuhLemak.lemak10 =
          userProfileDataBody.butuhLemak.lemak10;
      riwayatKebutuhanGizi.butuhLemak.lemak25 =
          userProfileDataBody.butuhLemak.lemak25;

      riwayatKebutuhanGizi.butuhKarbo.karbo60 =
          userProfileDataBody.butuhKarbo.karbo60;
      riwayatKebutuhanGizi.butuhKarbo.karbo75 =
          userProfileDataBody.butuhKarbo.karbo75;

      riwayatRekomendasiRencanaDiet.kebutuhanGizi = riwayatKebutuhanGizi;

      // Rekomendasi
      riwayatRekomendasiRencanaDiet.rekomendasi = rekomendasi;

      // Insert riwayat rekomendasi rencana diet
      // ignore: unused_local_variable
      var insertRiwayatRekomendasi = await _riwayatRekomendasiRencanaDietService
          .post(riwayatRekomendasiRencanaDiet);

      // Tentukan pivot tanggal
      DateTime pivotTanggal = DateTime.now();
      // Ambil tanggal terbaru dari rencaana diet
      rencanaDietFilter.userId = prefs.getString('userId');
      rencanaDietFilter.orderBy = "-tanggal";

      var rencanaDietData = await _rencaDietService.get(rencanaDietFilter);
      if (rencanaDietData.data.isNotEmpty) {
        var dataWaktu = rencanaDietData.data[0];
        DateTime rencanaTanggalDietTerbaru = DateTime.parse(dataWaktu.tanggal);

        if (pivotTanggal.isBefore(rencanaTanggalDietTerbaru)) {
          pivotTanggal = rencanaTanggalDietTerbaru;
        }
      }

      // Insert for loop rencana diet
      rencanaDiet.userId = int.parse(prefs.getString('userId') ?? '');
      for (var i = 0; i < rekomendasi.length; i++) {
        rencanaDiet.tanggal = DateTime(
            pivotTanggal.year, pivotTanggal.month, pivotTanggal.day + i);

        // Tambah waktu makan ke makanan
        for (var j = 0; j < rekomendasi[i].length; j++) {
          RencanaDietMakanan rencanaDietMakanan = RencanaDietMakanan();

          rencanaDietMakanan.waktuMakan = waktuMakan[j];
          rencanaDietMakanan.status = 2;
          rencanaDietMakanan.makanan = rekomendasi[i][j];

          debugPrint(rencanaDietMakanan.makanan.nama.toString());

          rencanaDiet.rencanaDietMakanan.add(rencanaDietMakanan);

          // break;
        }

        // ignore: unused_local_variable
        var insertRencanaDiet = _rencaDietService.post(rencanaDiet);
        rencanaDiet.rencanaDietMakanan = [];
        // break;
      }

      return true;
    } on Exception catch (e) {
      debugPrint('error di controller');
      debugPrint(e.toString());
      return false;
    }
  }
}
