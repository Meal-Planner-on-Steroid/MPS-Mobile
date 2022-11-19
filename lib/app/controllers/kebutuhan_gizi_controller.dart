import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mps/app/controllers/tingkat_aktivitas_controller.dart';
import 'package:mps/app/filters/tingkat_aktivitas_filter.dart';
import 'package:mps/app/models/user_profile_model.dart';
import 'package:mps/app/serializers/hasil_kebutuhan_gizi_serializer.dart';
import 'package:mps/app/services/kebutuhan_gizi_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KebutuhanGiziController {
  final _kebutuhanGiziService = KebutuhanGiziService();

  final _tingkatAktivitasController = TingkatAktivitasController();

  var tingkatAktivitasFilter = TingkatAktivitasFilter();

  var butuhProtein = ButuhProteinModel();
  var butuhLemak = ButuhLemakModel();
  var butuhKarbo = ButuhKarboModel();

  Future get(int userId) async {
    try {
      var response = await _kebutuhanGiziService.get(userId);

      if (response == false) {
        debugPrint('fail');
        return false;
      }

      debugPrint("yey");
      debugPrint(response.message);
      debugPrint(response.statusCode.toString());
      debugPrint(response.data.gender);

      return true;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future post(UserProfile userProfile) async {
    try {
      // Ambil nilai tingkat aktivitas
      tingkatAktivitasFilter.id = userProfile.tingkatAktivitasId.toString();
      var tingkatAktivitas =
          await _tingkatAktivitasController.get(tingkatAktivitasFilter);
      var nilaiTingkatAktivitas = tingkatAktivitas.data[0]['nilai'];

      // Hitung kebutuhan gizi
      userProfile.tingkatAktivitasNilai = nilaiTingkatAktivitas;
      var getKebutuhanGizi =
          await _kebutuhanGiziService.getKebutuhanGizi(userProfile);

      if (getKebutuhanGizi == false) {
        debugPrint('fail');
        return false;
      }

      var kebutuhanGizi =
          HasilKebutuhanGiziSerializer.fromJson(jsonDecode(getKebutuhanGizi));

      debugPrint(kebutuhanGizi.message);

      // Persipan data user profil
      final prefs = await SharedPreferences.getInstance();

      userProfile.userId = int.parse(prefs.getString('userId') ?? '');
      userProfile.keseluruhanEnergi = kebutuhanGizi.data?.amb ?? 0;
      userProfile.imt = kebutuhanGizi.data?.imt ?? 0;
      userProfile.imt = kebutuhanGizi.data?.imt ?? 0;

      butuhProtein.protein10 = kebutuhanGizi.data?.butuhProtein?.protein10 ?? 0;
      butuhProtein.protein15 = kebutuhanGizi.data?.butuhProtein?.protein15 ?? 0;
      userProfile.butuhProtein = butuhProtein;

      butuhLemak.lemak10 = kebutuhanGizi.data?.butuhLemak?.lemak10 ?? 0;
      butuhLemak.lemak25 = kebutuhanGizi.data?.butuhLemak?.lemak25 ?? 0;
      userProfile.butuhLemak = butuhLemak;

      butuhKarbo.karbo60 = kebutuhanGizi.data?.butuhKarbo?.karbo60 ?? 0;
      butuhKarbo.karbo75 = kebutuhanGizi.data?.butuhKarbo?.karbo75 ?? 0;
      userProfile.butuhKarbo = butuhKarbo;

      inspect(userProfile);

      // Buat user profile jika belum ada

      // Update user profile jika sudah ada

      return true;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
