/*
  ! Contoh data yang diambil
  {
      "message": "Berhasil mengambil profile User",
      "statusCode": 200,
      "data": [
          {
              "id": 1,
              "user_id": 44,
              "avatar": "32412",
              "tingkat_aktivitas_id": 9,
              "berat_badan": 34.0,
              "tinggi_badan": 21.0,
              "usia": 32,
              "gender": "LA",
              "imt": 43.0,
              "keseluruhan_energi": 3434.0,
              "butuh_protein": {
                  "protein_10": 61.88000000000001,
                  "protein_15": 92.82000000000001
              },
              "butuh_karbo": {
                  "karbo_60": 371.28000000000003,
                  "karbo_75": 464.1
              },
              "butuh_lemak": {
                  "lemak_10": 27.502222222222226,
                  "lemak_25": 68.75555555555556
              }
          }
      ]
  }

*/

class ButuhProtein {
  final double? protein10;
  final double? protein15;

  ButuhProtein({
    required this.protein10,
    required this.protein15,
  });

  factory ButuhProtein.fromJson(Map<String, dynamic> json) {
    final protein10 = json['protein_10'];
    final protein15 = json['protein_15'];

    return ButuhProtein(protein10: protein10, protein15: protein15);
  }
}

class ButuhKarbo {
  final double? karbo60;
  final double? karbo75;

  ButuhKarbo({
    required this.karbo60,
    required this.karbo75,
  });

  factory ButuhKarbo.fromJson(Map<String, dynamic> json) {
    final karbo60 = json['karbo_75'];
    final karbo75 = json['karbo_75'];

    return ButuhKarbo(karbo60: karbo60, karbo75: karbo75);
  }
}

class ButuhLemak {
  final double? lemak10;
  final double? lemak25;

  ButuhLemak({
    required this.lemak10,
    required this.lemak25,
  });

  factory ButuhLemak.fromJson(Map<String, dynamic> json) {
    final lemak10 = json['lemak_10'];
    final lemak25 = json['lemak_25'];

    return ButuhLemak(lemak10: lemak10, lemak25: lemak25);
  }
}

class Data {
  final int? id;
  final double? beratBadan;
  final double? tinggiBadan;
  final int? usia;
  final String? gender;
  final double? imt;
  final double? keseluruhanEnergi;
  final ButuhProtein? butuhProtein;
  final ButuhLemak? butuhLemak;
  final ButuhKarbo? butuhKarbo;
  final int? userId;

  Data({
    required this.id,
    required this.beratBadan,
    required this.tinggiBadan,
    required this.usia,
    required this.gender,
    required this.imt,
    required this.keseluruhanEnergi,
    required this.butuhProtein,
    required this.butuhLemak,
    required this.butuhKarbo,
    required this.userId,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      beratBadan: json['berat_badan'],
      tinggiBadan: json['tinggi_badan'],
      usia: json['usia'],
      gender: json['gender'],
      imt: json['imt'],
      keseluruhanEnergi: json['keseluruhan_energi'],
      butuhProtein: ButuhProtein.fromJson(json['butuh_protein']),
      butuhLemak: ButuhLemak.fromJson(json['butuh_lemak']),
      butuhKarbo: ButuhKarbo.fromJson(json['butuh_karbo']),
      userId: json['user_id'],
    );
  }
}

class RiwayatRekomendasiRencanaDietSerializer {
  final String? message;
  final int? statusCode;
  final dynamic data;

  RiwayatRekomendasiRencanaDietSerializer(
      {this.message, this.statusCode, this.data});

  factory RiwayatRekomendasiRencanaDietSerializer.fromJson(
      Map<String, dynamic> json) {
    if (json['data'] is List) {
      return RiwayatRekomendasiRencanaDietSerializer(
        message: json['message'],
        statusCode: json['statusCode'],
        data: json['data'].map((e) => Data.fromJson(e)).toList(),
      );
    } else {
      return RiwayatRekomendasiRencanaDietSerializer(
        message: json['message'],
        statusCode: json['statusCode'],
        data: Data.fromJson(json['data']),
      );
    }
  }
}
