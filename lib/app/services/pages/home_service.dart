import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mps/app/models/rencana_diet_makanan_model.dart';

class HomeService {
  final String? _baseUrl = dotenv.env['BASE_URL'];
  final String endpointRencanaDiet = "/api/rencana-diet/";
  final String endpointRencanaMakanan = "/api/rencana-diet-makanan/";
  final String endpointRencanaOlahraga = "/api/rencana-diet-olahraga/";
  final String endpointRencanaMinum = "/api/rencana-diet-minum/";

  Future updateProgresMakanan(
      RencanaDietMakanan rencanaDietMakanan, int rencanaMakananId) async {
    try {
      final url = Uri.http(
          _baseUrl.toString(), ("$endpointRencanaMakanan$rencanaMakananId/"));

      debugPrint('Update progres makanan service');
      debugPrint(url.toString());

      var request = await http.put(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "status": rencanaDietMakanan.status,
        }),
      );

      var response = jsonDecode(request.body);
      debugPrint(response.toString());

      return true;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
