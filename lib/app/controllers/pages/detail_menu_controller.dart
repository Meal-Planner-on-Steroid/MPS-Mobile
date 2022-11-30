import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mps/app/filters/bahan_makanan_filter.dart';
import 'package:mps/app/filters/makanan_filter.dart';
import 'package:mps/app/models/page/detail_menu_model.dart';
import 'package:mps/app/models/makanan_model.dart';
import 'package:mps/app/services/modules/bahan_makanan_service.dart';
import 'package:mps/app/services/modules/makanan_service.dart';
import 'package:mps/app/services/modules/satuan_service.dart';

class DetailMenuController {
  final makananService = MakananService();
  final satuanService = SatuanService();
  final bahanMakananService = BahanMakananService();

  var makananFilter = MakananFilter();
  var bahanMakananFilter = BahanMakananFilter();

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
      // Inisialisasi data
      DetailMenu detailMenu = DetailMenu();

      // Data makanan sekarang
      var dataMakanan = await makananService.getObject(id);
      detailMenu.makanan = dataMakanan;
      // debugPrint("dari getobject ${dataMakanan.data.besarPorsiId}");

      // Satuan makanan
      var dataSatuan = await satuanService
          .getObject(dataMakanan.data.besarPorsiId.toString());
      detailMenu.satuan = dataSatuan;
      // inspect(detailMenu.satuan);

      // Buat list makanan bahan/menu
      if (dataMakanan.data.jenis == 'ME' || dataMakanan.data.jenis == 'CA') {
        bahanMakananFilter.menuMakananId = id;
      } else {
        bahanMakananFilter.bahanMakananId = id;
      }
      var dataMakanaTerkait = await bahanMakananService.get(bahanMakananFilter);
      List<int> listIds = [];

      if (dataMakanan.data.jenis == 'ME' || dataMakanan.data.jenis == 'CA') {
        for (var item in dataMakanaTerkait.data) {
          listIds.add(item.bahanMakananId);
        }
      } else {
        for (var item in dataMakanaTerkait.data) {
          listIds.add(item.menuMakananId);
        }
      }

      inspect(dataMakanaTerkait);
      inspect(listIds);
      // var listIdsString = utf8.decode(listIds);

      // Makanan terkait
      makananFilter.idIn = listIds.join(",");
      if (makananFilter.idIn!.isEmpty) {
        makananFilter.id = '0';
      }
      var makananTerkait = await makananService.get(makananFilter);
      detailMenu.makananTerkait = makananTerkait;

      return detailMenu;
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
