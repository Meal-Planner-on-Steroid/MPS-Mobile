import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mps/app/filters/rencana_diet_minum_filter.dart';
import 'package:mps/app/serializers/rencana_diet_minum_serializer.dart';

class RencanaDietMinumService {
  final String? _baseUrl = dotenv.env['BASE_URL'];
  final String endpoint = "/api/rencana-diet-minum/"; // Alamat endpoint

  Future get(RencanaDietMinumFilter rencanaDietMinumFilter) async {
    try {
      final queryParams = {
        "jumlah_minum": rencanaDietMinumFilter.jumlahMinum,
        "jumlah_minum__gt": rencanaDietMinumFilter.jumlahMinumGt,
        "jumlah_minum__lt": rencanaDietMinumFilter.jumlahMinumLt,
        "banyak_minum": rencanaDietMinumFilter.banyakMinum,
        "banyak_minum__gt": rencanaDietMinumFilter.banyakMinumGt,
        "banyak_minum__lt": rencanaDietMinumFilter.banyakMinumLt,
        "progress": rencanaDietMinumFilter.progress,
        "progress__gt": rencanaDietMinumFilter.progressGt,
        "progress__lt": rencanaDietMinumFilter.progressLt,
        "rencana_diet_id": rencanaDietMinumFilter.rencanaDietId,
        "rencana_diet_id__in": rencanaDietMinumFilter.rencanaDietIdIn,
        "limit": rencanaDietMinumFilter.limit,
        "page": rencanaDietMinumFilter.page,
        "order_by": rencanaDietMinumFilter.orderBy,
      };

      var url = Uri.http(_baseUrl.toString(), endpoint, queryParams);
      var decodeUrl = Uri.decodeFull(url.toString());

      url = Uri.parse(decodeUrl);

      // debugPrint(url.toString());

      var request = await http.get(url);

      final response = jsonDecode(request.body);
      return RencanaDietMinumSerializer.fromJson(response);
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
