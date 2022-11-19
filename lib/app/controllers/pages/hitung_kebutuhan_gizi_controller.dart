import 'package:flutter/material.dart';
import 'package:mps/app/filters/tingkat_aktivitas_filter.dart';
import 'package:mps/app/models/user_profile_model.dart';
import 'package:mps/app/services/pages/hitung_kebutuhan_gizi_service.dart';

class HitungKebutuhanGiziController {
  final _hitungKebutuhanGiziService = HitungKebutuhanGiziService();

  var tingkatAktivitasFilter = TingkatAktivitasFilter();

  var butuhProtein = ButuhProteinModel();
  var butuhLemak = ButuhLemakModel();
  var butuhKarbo = ButuhKarboModel();

  Future get(int userId) async {
    try {
      var response = await _hitungKebutuhanGiziService.get(userId);

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
      debugPrint('Hasil kebutuhan gizi controller');
      // Ambil nilai tingkat aktivitas
      // tingkatAktivitasFilter.id = userProfile.tingkatAktivitasId.toString();
      // var tingkatAktivitas =
      //     await _tingkatAktivitasService.get(tingkatAktivitasFilter);
      // var nilaiTingkatAktivitas = tingkatAktivitas.data[0]['nilai'];

      // // Hitung kebutuhan gizi
      // userProfile.tingkatAktivitasNilai = nilaiTingkatAktivitas;
      // var hasilKebutuhanGizi = await _kebutuhanGiziService.post(userProfile);

      // if (hasilKebutuhanGizi == false) {
      //   debugPrint('Gagal menghitung kebutuhan gizi');
      //   return false;
      // }

      // debugPrint(hasilKebutuhanGizi.message);

      // // Persipan data user profil
      // final prefs = await SharedPreferences.getInstance();

      // userProfile.userId = int.parse(prefs.getString('userId') ?? '');
      // userProfile.keseluruhanEnergi = hasilKebutuhanGizi.data?.amb ?? 0;
      // userProfile.imt = hasilKebutuhanGizi.data?.imt ?? 0;
      // userProfile.imt = hasilKebutuhanGizi.data?.imt ?? 0;

      // butuhProtein.protein10 = hasilKebutuhanGizi.data?.butuhProtein?.protein10 ?? 0;
      // butuhProtein.protein15 = hasilKebutuhanGizi.data?.butuhProtein?.protein15 ?? 0;
      // userProfile.butuhProtein = butuhProtein;

      // butuhLemak.lemak10 = hasilKebutuhanGizi.data?.butuhLemak?.lemak10 ?? 0;
      // butuhLemak.lemak25 = hasilKebutuhanGizi.data?.butuhLemak?.lemak25 ?? 0;
      // userProfile.butuhLemak = butuhLemak;

      // butuhKarbo.karbo60 = hasilKebutuhanGizi.data?.butuhKarbo?.karbo60 ?? 0;
      // butuhKarbo.karbo75 = hasilKebutuhanGizi.data?.butuhKarbo?.karbo75 ?? 0;
      // userProfile.butuhKarbo = butuhKarbo;

      // inspect(userProfile);

      // Buat user profile jika belum ada

      // Update user profile jika sudah ada

      return true;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
