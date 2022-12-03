import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mps/app/filters/rencana_diet_filter.dart';
import 'package:http/http.dart' as http;
import 'package:mps/app/models/rencana_diet_model.dart';
import 'package:mps/app/serializers/rencana_diet_serializer.dart';

class RencanaDietService {
  final String? _baseUrl = dotenv.env['BASE_URL'];
  final String endpoint = "/api/rencana-diet/"; // Alamat endpoint

  Future get(RencanaDietFilter rencanaDietFilter) async {
    try {
      final queryParams = {
        "tanggal": rencanaDietFilter.tanggal,
        "tanggal__gt": rencanaDietFilter.tanggalGt,
        "tanggal__lt": rencanaDietFilter.tanggalLt,
        "user_id": rencanaDietFilter.userId,
        "order_by": rencanaDietFilter.orderBy,
      };

      final url = Uri.http(_baseUrl.toString(), endpoint, queryParams);

      debugPrint(url.toString());

      var request = await http.get(url);

      final response = jsonDecode(request.body);
      return RencanaDietSerializer.fromJson(response);
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

  Future post(RencanaDiet rencanaDiet) async {
    try {
      final url = Uri.http(_baseUrl.toString(), endpoint);

      var request = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(
          {
            "user": {"id": rencanaDiet.userId},
            "tanggal": rencanaDiet.tanggal.toIso8601String(),
            "rencana_diet_makanan": rencanaDiet.rencanaDietMakanan,
            "olahraga": rencanaDiet.olahraga,
            "minum": rencanaDiet.minum,
          },
        ),
      );

      var response = jsonDecode(request.body);
      debugPrint(response.toString());

      // debugPrint(jsonEncode(
      //   {
      //     "user": {"id": rencanaDiet.userId},
      //     "tanggal": rencanaDiet.tanggal.toIso8601String(),
      //     "rencana_diet_makanan": rencanaDiet.rencanaDietMakanan,
      //     "olahraga": rencanaDiet.olahraga,
      //     "minum": rencanaDiet.minum,
      //   },
      // ));

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
