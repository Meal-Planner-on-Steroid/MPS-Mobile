import 'package:flutter/material.dart';
import 'package:mps/app/filters/makanan_filter.dart';
import 'package:mps/app/models/detail_menu_model.dart';
import 'package:mps/app/models/makanan_model.dart';
import 'package:mps/app/services/modules/makanan_service.dart';
import 'package:mps/app/services/modules/satuan_service.dart';

class DetailMenuController {
  final makananService = MakananService();
  final satuanService = SatuanService();

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
      DetailMenu detailMenu = DetailMenu();
      var dataMakanan = await makananService.getObject(id);
      detailMenu.makanan = dataMakanan;
      // debugPrint("dari getobject ${dataMakanan.data.besarPorsiId}");

      var dataSatuan = await satuanService
          .getObject(dataMakanan.data.besarPorsiId.toString());
      detailMenu.satuan = dataSatuan;
      // inspect(detailMenu.satuan);

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
