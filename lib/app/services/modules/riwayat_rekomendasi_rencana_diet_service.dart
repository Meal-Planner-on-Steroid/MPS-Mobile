import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mps/app/filters/riwayat_rekomendasi_rencana_diet_filter.dart';
import 'package:http/http.dart' as http;
import 'package:mps/app/models/riwayat_rekomendasi_rencana_diet_model.dart';
import 'package:mps/app/serializers/riwayat_rekomendasi_rencana_diet_serializer.dart';

class RiwayatRekomendasiRencanaDietService {
  final String? _baseUrl = dotenv.env['BASE_URL'];
  final String endpoint =
      "/api/riwayat-rekomendasi-rencana-diet/"; // Alamat endpoint

  Future get(
      RiwayatRekomendasiRencanaDietFilter
          riwayatRekomendasiRencanaDietFilter) async {
    try {
      final queryParams = {
        "berat_badan": riwayatRekomendasiRencanaDietFilter.beratBadan,
        "tinggi_badan": riwayatRekomendasiRencanaDietFilter.tinggiBadan,
        "usia": riwayatRekomendasiRencanaDietFilter.usia,
        "gender": riwayatRekomendasiRencanaDietFilter.gender,
        "imt": riwayatRekomendasiRencanaDietFilter.imt,
        "keseluruhan_energi":
            riwayatRekomendasiRencanaDietFilter.keseluruhanEnergi,
        "butuh_protein": riwayatRekomendasiRencanaDietFilter.butuhProtein,
        "butuh_karbo": riwayatRekomendasiRencanaDietFilter.butuhKarbo,
        "butuh_lemak": riwayatRekomendasiRencanaDietFilter.butuhLemak,
        "user_id": riwayatRekomendasiRencanaDietFilter.userId,
      };

      final url = Uri.http(_baseUrl.toString(), endpoint, queryParams);

      debugPrint(url.toString());

      var request = await http.get(url);

      final response = jsonDecode(request.body);
      return RiwayatRekomendasiRencanaDietSerializer.fromJson(response);
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future getObject() async {
    try {
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future post(
      RiwayatRekomendasiRencanaDiet riwayatRekomendasiRencanaDiet) async {
    try {
      final url = Uri.http(_baseUrl.toString(), endpoint);

      // ignore: unused_local_variable
      var request = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(
          {
            "user": {"id": riwayatRekomendasiRencanaDiet.userId},
            "kebutuhan_gizi":
                riwayatRekomendasiRencanaDiet.kebutuhanGizi.toJson(),
            "rekomendasi": riwayatRekomendasiRencanaDiet.rekomendasi,
          },
        ),
      );

      var response = jsonDecode(request.body);
      debugPrint(response.toString());

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
