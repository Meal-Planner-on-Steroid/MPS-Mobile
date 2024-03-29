import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mps/app/filters/tingkat_aktivitas_filter.dart';
import 'package:mps/app/filters/user_profile_filter.dart';
import 'package:mps/app/models/user_profile_model.dart';
import 'package:mps/app/services/modules/kebutuhan_gizi_service.dart';
import 'package:mps/app/services/modules/tingkat_aktivitas_service.dart';
import 'package:mps/app/services/modules/user_profile_service.dart';
import 'package:mps/app/services/pages/hitung_kebutuhan_gizi_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HitungKebutuhanGiziController {
  final _hitungKebutuhanGiziService = HitungKebutuhanGiziService();
  final _tingkatAktivitasService = TingkatAktivitasService();
  final _kebutuhanGiziService = KebutuhanGiziService();
  final _userProfileSerivce = UserProfileService();

  var tingkatAktivitasFilter = TingkatAktivitasFilter();
  var userProfileFilter = UserProfileFilter();

  var butuhProtein = ButuhProtein();
  var butuhLemak = ButuhLemak();
  var butuhKarbo = ButuhKarbo();

  Future get() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      var userId = int.parse(prefs.getString('userId') ?? '');
      userProfileFilter.userId = userId.toString();
      var userProfileData = await _userProfileSerivce.get(userProfileFilter);

      if (userProfileData == false) {
        debugPrint('Gagal mengambil user profile');
        return false;
      }

      debugPrint(userProfileData.message);

      return userProfileData;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  // Future testDate() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   var userId = prefs.getString('userId');

  //   _rencanaDietFilter.userId = userId;
  //   _rencanaDietFilter.orderBy = "-tanggal";

  //   DateTime pivotTanggal = DateTime.now();

  //   var request = await _rencanaDietService.get(_rencanaDietFilter);
  //   if (request.data.isNotEmpty) {
  //     debugPrint('ada rencana diet');
  //     var dataWaktu = request.data[0];
  //     DateTime rencanaTanggalDietTerbaru = DateTime.parse(dataWaktu.tanggal);

  //     if (pivotTanggal.isBefore(rencanaTanggalDietTerbaru)) {
  //       pivotTanggal = rencanaTanggalDietTerbaru;
  //     }
  //   }

  //   debugPrint("Pivot tanggal adalah $pivotTanggal");
  // }

  Future post(UserProfile userProfile) async {
    try {
      // Ambil nilai tingkat aktivitas
      tingkatAktivitasFilter.id = userProfile.tingkatAktivitasId.toString();
      var tingkatAktivitas =
          await _tingkatAktivitasService.get(tingkatAktivitasFilter);
      var nilaiTingkatAktivitas = tingkatAktivitas.data[0]['nilai'];

      debugPrint(nilaiTingkatAktivitas.toString());

      // Hitung kebutuhan gizi
      userProfile.tingkatAktivitasNilai = nilaiTingkatAktivitas;
      var hasilKebutuhanGizi = await _kebutuhanGiziService.post(userProfile);

      if (hasilKebutuhanGizi == false) {
        debugPrint('Gagal menghitung kebutuhan gizi');
        return false;
      }

      debugPrint(hasilKebutuhanGizi.message);

      // Persipan data user profil
      final prefs = await SharedPreferences.getInstance();

      userProfile.userId = int.parse(prefs.getString('userId') ?? '');
      userProfile.keseluruhanEnergi =
          hasilKebutuhanGizi.data?.energiSesuai ?? 0;
      userProfile.imt = hasilKebutuhanGizi.data?.imt ?? 0;
      userProfile.imt = hasilKebutuhanGizi.data?.imt ?? 0;

      butuhProtein.protein15 =
          hasilKebutuhanGizi.data?.butuhProtein?.protein15 ?? 0;
      butuhProtein.protein20 =
          hasilKebutuhanGizi.data?.butuhProtein?.protein20 ?? 0;
      userProfile.butuhProtein = butuhProtein;

      butuhLemak.lemak20 = hasilKebutuhanGizi.data?.butuhLemak?.lemak20 ?? 0;
      butuhLemak.lemak25 = hasilKebutuhanGizi.data?.butuhLemak?.lemak25 ?? 0;
      userProfile.butuhLemak = butuhLemak;

      butuhKarbo.karbo55 = hasilKebutuhanGizi.data?.butuhKarbo?.karbo55 ?? 0;
      butuhKarbo.karbo65 = hasilKebutuhanGizi.data?.butuhKarbo?.karbo65 ?? 0;
      userProfile.butuhKarbo = butuhKarbo;

      inspect(userProfile);

      // Update or insert
      userProfileFilter.userId = userProfile.userId.toString();
      var userProfileData = await _userProfileSerivce.get(userProfileFilter);
      // ignore: unused_local_variable, prefer_typing_uninitialized_variables
      var request;

      if (userProfileData.data.length == 0) {
        // Buat user profile jika belum ada
        debugPrint('User belum memiliki profile');
        request = await _hitungKebutuhanGiziService.post(userProfile);
      } else {
        // Update user profile jika sudah ada
        debugPrint('User sudah memiliki profile');
        var profileId = userProfileData.data[0].id.toString();
        request = await _hitungKebutuhanGiziService.put(userProfile, profileId);
      }

      return true;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
