import 'package:flutter/material.dart';
import 'package:mps/app/models/user_model.dart';
import 'package:mps/app/services/pages/profile_page_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilPageController {
  // ignore: unused_field
  // final _makananFavoritService = MakananFavoritService();
  final _profilePageService = ProfilPageService();

  Future getObject() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var userId = prefs.getString('userId') ?? '';

      var response = await _profilePageService.getObject(userId);

      if (response == false) {
        debugPrint("Gagal mengambil object user");
        return false;
      }

      debugPrint("Berhasil mengambil object user");

      return response;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future changeProfile(User userModel) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var userId = prefs.getString('userId') ?? '';

      var response = await _profilePageService.chageProfil(userId, userModel);

      if (response == false) {
        debugPrint("Gagal update user");
        return false;
      }

      debugPrint("Berhasil update user");

      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future changePassword(User userModel) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var userId = prefs.getString('userId') ?? '';

      var response =
          await _profilePageService.changePassword(userId, userModel);

      if (response == false) {
        debugPrint("Gagal update user");
        return false;
      }

      debugPrint("Berhasil update user");

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
