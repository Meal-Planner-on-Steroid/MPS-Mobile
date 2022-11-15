import 'package:flutter/material.dart';
import 'package:mps/app/models/user_profile_model.dart';
import 'package:mps/app/services/kebutuhan_gizi_service.dart';

class KebutuhanGiziController {
  final _kebutuhanGiziService = KebutuhanGiziService();

  Future get(int userId) async {
    try {
      var response = await _kebutuhanGiziService.get(userId);

      if (response == false) {
        debugPrint('fail');
        return false;
      }

      debugPrint("yey");
      debugPrint(response.message);
      debugPrint(response.statusCode.toString());
      debugPrint(response.data.gender);

      return true;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future post(UserProfile userProfile) async {
    try {
      // var response = await _kebutuhanGiziService.post(userProfile);

      // if (response == false) {
      //   debugPrint('fail');
      //   return false;
      // }

      // debugPrint("yey");

      debugPrint(userProfile.beratBadan.toString());
      debugPrint(userProfile.tinggiBadan.toString());
      debugPrint(userProfile.usia.toString());
      debugPrint(userProfile.gender.toString());
      debugPrint(userProfile.tingkatAktivitasId.toString());

      return true;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
