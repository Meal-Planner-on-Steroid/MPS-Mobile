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
                  "protein_15": 61.88000000000001,
                  "protein_20": 92.82000000000001
              },
              "butuh_karbo": {
                  "lemak_20": 371.28000000000003,
                  "lemak_25": 464.1
              },
              "butuh_lemak": {
                  "karbo_55": 27.502222222222226,
                  "karbo_65": 68.75555555555556
              }
          }
      ]
  }

*/

class ButuhProtein {
  final double? protein15;
  final double? protein20;

  ButuhProtein({
    required this.protein15,
    required this.protein20,
  });

  factory ButuhProtein.fromJson(Map<String, dynamic> json) {
    final protein15 = json['protein_15'];
    final protein20 = json['protein_20'];

    return ButuhProtein(protein15: protein15, protein20: protein20);
  }
}

class ButuhKarbo {
  final double? karbo55;
  final double? karbo65;

  ButuhKarbo({
    required this.karbo55,
    required this.karbo65,
  });

  factory ButuhKarbo.fromJson(Map<String, dynamic> json) {
    final karbo55 = json['karbo_55'];
    final karbo65 = json['karbo_65'];

    return ButuhKarbo(karbo55: karbo55, karbo65: karbo65);
  }
}

class ButuhLemak {
  final double? lemak20;
  final double? lemak25;

  ButuhLemak({
    required this.lemak20,
    required this.lemak25,
  });

  factory ButuhLemak.fromJson(Map<String, dynamic> json) {
    final lemak20 = json['lemak_20'];
    final lemak25 = json['lemak_25'];

    return ButuhLemak(lemak20: lemak20, lemak25: lemak25);
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
  final String? createdAt;
  final String? updatedAt;

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
    required this.createdAt,
    required this.updatedAt,
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
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
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
