import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TestPageController {
  final String baseUrl = "loripsum.net";
  final String endpoint = "/api/plaintext/short/1";

  Future get() async {
    try {
      var url = Uri.https(baseUrl, endpoint);
      var request = await http.get(url);

      inspect(request.body);

      // return request.body.toString();
      return 'true';
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
