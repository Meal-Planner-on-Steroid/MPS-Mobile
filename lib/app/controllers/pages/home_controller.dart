import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mps/app/filters/makanan_filter.dart';
import 'package:mps/app/filters/rencana_diet_filter.dart';
import 'package:mps/app/filters/rencana_diet_makanan_filter.dart';
import 'package:mps/app/filters/rencana_diet_minum_filter.dart';
import 'package:mps/app/filters/rencana_diet_olahraga_filter.dart';
import 'package:mps/app/models/rencana_diet_makanan_model.dart';
import 'package:mps/app/services/modules/makanan_service.dart';
import 'package:mps/app/services/modules/rencana_diet_makanan_service.dart';
import 'package:mps/app/services/modules/rencana_diet_minum_service.dart';
import 'package:mps/app/services/modules/rencana_diet_olahraga_service.dart';
import 'package:mps/app/services/modules/rencana_diet_service.dart';
import 'package:mps/app/services/pages/home_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  final _rencanaDietService = RencanaDietService();
  final _rencanaDietMakananService = RencanaDietMakananService();
  final _rencanaDietMinumService = RencanaDietMinumService();
  final _rencanaDietOlahragaService = RencanaDietOlahragaService();
  final _makananService = MakananService();
  final _homeService = HomeService();

  RencanaDietFilter rencanaDietFilter = RencanaDietFilter();
  RencanaDietMakananFilter rencanaDietMakananFilter =
      RencanaDietMakananFilter();
  RencanaDietMinumFilter rencanaDietMinumFilter = RencanaDietMinumFilter();
  RencanaDietOlahragaFilter rencanaDietOlahragaFilter =
      RencanaDietOlahragaFilter();
  MakananFilter makananFilter = MakananFilter();

  Future getSetRencanaDiet(String mulaiDariTanggal) async {
    try {
      Map<String, dynamic> result = {};
      Map<String, dynamic> resultTemp = {};

      final prefs = await SharedPreferences.getInstance();
      var userId = prefs.getString('userId');

      debugPrint(mulaiDariTanggal);

      // ! Proses ambil data
      // GET rencana diet mulai dari tanggal
      rencanaDietFilter.tanggalGt = mulaiDariTanggal;
      rencanaDietFilter.limit = '40';
      rencanaDietFilter.orderBy = 'tanggal';
      rencanaDietFilter.userId = userId;

      var responseRencanaDiet =
          await _rencanaDietService.get(rencanaDietFilter);

      if (responseRencanaDiet.data.length <= 0) {
        debugPrint("tidak ada data");
        return result;
      }

      // ignore: unused_local_variable
      var rencanaDietId = responseRencanaDiet.data[0].id;
      resultTemp['rencana_diet'] = responseRencanaDiet.data;

      debugPrint("ada data");
      inspect(resultTemp);

      // Buat list rencana diet id
      List<int> listRencanaDietId = [];
      for (var i = 0; i < resultTemp['rencana_diet'].length; i++) {
        listRencanaDietId.add(resultTemp['rencana_diet'][i].id);
      }

      // GET list rencana diet makanan in list rencana diet id
      rencanaDietMakananFilter.rencanaDietIdIn = listRencanaDietId.join(',');
      rencanaDietMakananFilter.limit = '200';
      var responseRencanaDietMakanan =
          await _rencanaDietMakananService.get(rencanaDietMakananFilter);
      resultTemp['rencana_diet_makanan'] = responseRencanaDietMakanan.data;

      // Buat list makanan id dari rencana diet makanan
      List<int> listMakananId = [];
      for (var j = 0; j < resultTemp['rencana_diet_makanan'].length; j++) {
        listMakananId.add(resultTemp['rencana_diet_makanan'][j].makananId);
      }

      // GET list makanan in list makanan id
      makananFilter.idIn = listMakananId.join(',');
      makananFilter.limit = '200';
      var responseMakanan = await _makananService.get(makananFilter);
      resultTemp['makanans'] = responseMakanan.data;

      // GET list rencana diet minum in list rencana diet id
      rencanaDietMinumFilter.rencanaDietId = listRencanaDietId.join(',');
      rencanaDietMinumFilter.limit = '40';
      var responseRencanaDietMinum =
          await _rencanaDietMinumService.get(rencanaDietMinumFilter);
      resultTemp['rencana_diet_minum'] = responseRencanaDietMinum.data;

      // GET list rencana diet olahraga in list rencana diet id
      rencanaDietOlahragaFilter.rencanaDietId = listRencanaDietId.join(',');
      rencanaDietOlahragaFilter.limit = '40';
      var responseRencanaDietOlahraga =
          await _rencanaDietOlahragaService.get(rencanaDietOlahragaFilter);
      resultTemp['rencana_diet_olahraga'] = responseRencanaDietOlahraga.data;

      // ! Proses bentuk data
      // Untuk setiap item di rencana diet
      for (var i = 0; i < resultTemp['rencana_diet'].length; i++) {
        Map<String, dynamic> thisResult = {}; // <= Tempat result sementara

        // Pivot rencana diet & simpan sementara
        var thisRencanaDiet = resultTemp['rencana_diet'][i];
        thisResult['rencana_diet'] = thisRencanaDiet;

        // Ambil rencana_diet_makanan
        // dimana rencana_diet_makanan.rencanaDietId sama dengan thisRencanaDiet.id
        thisResult['rencana_diet_makanan'] =
            resultTemp['rencana_diet_makanan'].where((element) {
          return element.rencanaDietId == thisRencanaDiet.id;
        }).toList();

        // Ambil makanan
        // Dimana makanan.id sama dengan rencana_diet_makan.makananId
        thisResult['makanans'] = [];
        for (var j = 0; j < thisResult['rencana_diet_makanan'].length; j++) {
          thisResult['makanans']
              .add(resultTemp['makanans'].firstWhere((element) {
            return element.id ==
                thisResult['rencana_diet_makanan'][j].makananId;
          }));
        }

        // Ambil rencana_diet_minum
        // dimana rencanaDietId sama dengan thisRencanaDiet.id
        thisResult['rencana_diet_minum'] =
            resultTemp['rencana_diet_minum'].firstWhere((element) {
          return element.rencanaDietId == thisRencanaDiet.id;
        });

        // Ambil rencana_diet_olahraga
        // dimana rencanaDietId sama dengan thisRencanaDiet.id
        thisResult['rencana_diet_olahraga'] =
            resultTemp['rencana_diet_olahraga'].firstWhere((element) {
          return element.rencanaDietId == thisRencanaDiet.id;
        });

        // Buat key tanggal
        var thisTanggal =
            formatter.format(DateTime.parse(thisRencanaDiet.tanggal));
        // Simpan semuanya didalam key tanggal
        result[thisTanggal] = thisResult;

        // inspect(thisResult);
        // break;
      }

      inspect(result);

      return result;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future get(String tanggal) async {
    try {
      Map<String, dynamic> result = {};
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // Ambil rencana diet di tanggal ini
      rencanaDietFilter.tanggal = tanggal;
      rencanaDietFilter.userId = prefs.getString('userId');
      var responseRencanaDiet =
          await _rencanaDietService.get(rencanaDietFilter);

      if (responseRencanaDiet.data.length > 0) {
        var rencanaDietId = responseRencanaDiet.data[0].id;
        result['rencana_diet'] = responseRencanaDiet.data;

        // Ambil rencana diet makanan
        rencanaDietMakananFilter.rencanaDietId = rencanaDietId.toString();
        var responseRencanaMakananDiet =
            await _rencanaDietMakananService.get(rencanaDietMakananFilter);
        result['rencana_diet_makanan'] = responseRencanaMakananDiet;

        // Buat list id makanan
        List<int> listMakananIds = [];
        for (var i = 0; i < responseRencanaMakananDiet.data.length; i++) {
          listMakananIds.add(responseRencanaMakananDiet.data[i].makananId);
        }

        // Ambil list makanan di listMakananIds
        makananFilter.idIn = listMakananIds.join(',').toString();
        var responseMakanan = await _makananService.get(makananFilter);
        result['makanans'] = responseMakanan;

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
      }

      // inspect(result['rencana_diet'].data[0]);
      // inspect(result['rencana_diet_makanan'].data);
      // inspect(result['makanans'].data);
      // inspect(result['rencana_diet_minum'].data[0]);
      // inspect(result['rencana_diet_olahraga'].data[0]);

      return result;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future updateProgresMakanan(int rencanaMakanId, int status) async {
    try {
      RencanaDietMakanan rencanaDietMakanan = RencanaDietMakanan();

      rencanaDietMakanan.status = status;

      debugPrint(rencanaMakanId.toString());
      debugPrint(rencanaDietMakanan.status.toString());
      // ignore: unused_local_variable
      var requestRencanaMakanan = await _homeService.updateProgresMakanan(
          rencanaDietMakanan, rencanaMakanId);

      return true;
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
