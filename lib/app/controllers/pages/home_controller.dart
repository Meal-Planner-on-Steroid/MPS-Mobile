import 'package:flutter/material.dart';
import 'package:mps/app/filters/rencana_diet_filter.dart';
import 'package:mps/app/filters/rencana_diet_makanan_filter.dart';
import 'package:mps/app/filters/rencana_diet_minum_filter.dart';
import 'package:mps/app/filters/rencana_diet_olahraga_filter.dart';
import 'package:mps/app/services/modules/rencana_diet_makanan_service.dart';
import 'package:mps/app/services/modules/rencana_diet_minum_service.dart';
import 'package:mps/app/services/modules/rencana_diet_olahraga_service.dart';
import 'package:mps/app/services/modules/rencana_diet_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController {
  // final _makananFavoritService = MakananFavoritService();
  final _rencanaDietService = RencanaDietService();
  final _rencanaDietMakananService = RencanaDietMakananService();
  final _rencanaDietMinumService = RencanaDietMinumService();
  final _rencanaDietOlahragaService = RencanaDietOlahragaService();

  RencanaDietFilter rencanaDietFilter = RencanaDietFilter();
  RencanaDietMakananFilter rencanaDietMakananFilter =
      RencanaDietMakananFilter();
  RencanaDietMinumFilter rencanaDietMinumFilter = RencanaDietMinumFilter();
  RencanaDietOlahragaFilter rencanaDietOlahragaFilter =
      RencanaDietOlahragaFilter();

  Future get(String tanggal) async {
    try {
      Map<String, dynamic> result = {};
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // Ambil rencana diet di tanggal ini
      rencanaDietFilter.tanggal = tanggal;
      rencanaDietFilter.userId = prefs.getString('userId');
      var responseRencanaDiet =
          await _rencanaDietService.get(rencanaDietFilter);
      var rencanaDietId = responseRencanaDiet.data[0].id;
      result['rencana_diet'] = responseRencanaDiet;

      // Ambil rencana diet makanan
      rencanaDietMakananFilter.rencanaDietId = rencanaDietId.toString();
      var responseRencanaMakananDiet =
          await _rencanaDietMakananService.get(rencanaDietMakananFilter);
      result['rencana_diet_makanan'] = responseRencanaMakananDiet;

      // Ambil rencana diet minum
      rencanaDietMinumFilter.rencanaDietId = rencanaDietId.toString();
      var responseRencanaMinumDiet =
          await _rencanaDietMinumService.get(rencanaDietMinumFilter);
      result['rencana_diet_minum'] = responseRencanaMinumDiet;

      // Ambil rencana diet olahraga
      rencanaDietOlahragaFilter.rencanaDietId = rencanaDietId.toString();
      var responseRencanaOlahragaDiet =
          await _rencanaDietOlahragaService.get(rencanaDietOlahragaFilter);
      result['rencana_diet_olahraga'] = responseRencanaOlahragaDiet;

      // inspect(result['rencana_diet'].data[0]);
      // inspect(result['rencana_diet_makanan'].data);
      // inspect(result['rencana_diet_minum'].data[0]);
      // inspect(result['rencana_diet_olahraga'].data[0]);

      return result;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future getObject(String id) async {
    try {
      return true;
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
