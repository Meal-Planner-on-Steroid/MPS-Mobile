import 'package:flutter/material.dart';
import 'package:mps/app/filters/makanan_filter.dart';
import 'package:mps/app/filters/rekomendasi_makanan_diet_filter.dart';
import 'package:mps/app/filters/rekomendasi_rencana_diet_filter.dart';
import 'package:mps/app/models/makanan_model.dart';
import 'package:mps/app/models/page/riwayat_detail_model.dart';
import 'package:mps/app/services/modules/makanan_service.dart';
import 'package:mps/app/services/modules/rekomendasi_makanan_diet_service.dart';
import 'package:mps/app/services/modules/rekomendasi_rencana_diet_service.dart';
import 'package:mps/app/services/modules/riwayat_rekomendasi_rencana_diet_service.dart';

class RiwayatDetailController {
  final _riwayatRekomendasiRencanaDietService =
      RiwayatRekomendasiRencanaDietService();
  final _rekomendasiRencanaDietService = RekomendasiRencanaDietService();
  final _rekomendasiMakananDietService = RekomendasiMakananDietService();
  final _makananService = MakananService();

  Future get(MakananFilter makananFilter) async {
    try {
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future getObject(String id) async {
    try {
      RiwayatDetail riwayatDetail = RiwayatDetail();
      RekomendasiRencanaDietFilter rekomendasiRencanaDietFilter =
          RekomendasiRencanaDietFilter();
      RekomendasiMakananDietFilter rekomendasiMakananDietFilter =
          RekomendasiMakananDietFilter();
      MakananFilter makananFilter = MakananFilter();

      // GET riwayat rencana (id dan statusnya)
      var riwayatRekomendasi =
          await _riwayatRekomendasiRencanaDietService.getObject(id);
      riwayatDetail.riwayatRekomendasi = riwayatRekomendasi;

      // GET rekomendasi rencana diet (list hari)
      rekomendasiRencanaDietFilter.orderBy = "created_at";
      rekomendasiRencanaDietFilter.riwayatRekomendasiId = id;
      var rekomendasiRencana = await _rekomendasiRencanaDietService
          .get(rekomendasiRencanaDietFilter);
      riwayatDetail.rekomendasiRencana = rekomendasiRencana;

      // Buat list id rekomendasi rencana diet
      List<int> listIdRekomendasiRencana = [];
      for (var itemRencana in rekomendasiRencana.data) {
        listIdRekomendasiRencana.add(itemRencana.id);
      }

      debugPrint(listIdRekomendasiRencana.join(',').toString());

      // GET rekomendasi makanan diet (referensi makanan)
      rekomendasiMakananDietFilter.orderBy = "created_at";
      rekomendasiMakananDietFilter.rekomendasiRencanaDietIdIn =
          listIdRekomendasiRencana.join(',').toString();
      var rekomendasiMakanan = await _rekomendasiMakananDietService
          .get(rekomendasiMakananDietFilter);
      riwayatDetail.rekomendasiMakanan = rekomendasiMakanan;

      // Buat list id makanan dari rekomendasi makanan diet
      List<int> listIdMakananDiRekomendasiMakanan = [];
      for (var itemMakanan in rekomendasiMakanan.data) {
        listIdMakananDiRekomendasiMakanan.add(itemMakanan.makananId);
      }

      debugPrint(listIdMakananDiRekomendasiMakanan.join(',').toString());

      // GET makanan berdasarkan listIdMakananDiRekomendasiMakanan
      makananFilter.idIn =
          listIdMakananDiRekomendasiMakanan.join(',').toString();
      makananFilter.limit = '50';
      var makanans = await _makananService.get(makananFilter);
      riwayatDetail.makanan = makanans;

      return riwayatDetail;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future post(Makanan makanan) async {
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
