/*
! contoh data
{
    "message": "Berhasil menentukan kebutuhan gizi",
    "data": {
        "amb": 1547.0,
        "total_energi": 2475.2000000000003,
        "imt": 23.73323840037973,
        "kebutuhan_protein": {
            "protein_10": 61.88000000000001,
            "protein_15": 92.82000000000001
        },
        "kebutuhan_lemak": {
            "lemak_10": 27.502222222222226,
            "lemak_25": 68.75555555555556
        },
        "kebutuhan_karbo": {
            "karbo_60": 371.28000000000003,
            "karbo_75": 464.1
        }
    }
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
    final karbo60 = json['karbo_60'];
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
  final double? amb;
  final double? keseluruhanEnergi;
  final double? imt;
  final ButuhProtein? butuhProtein;
  final ButuhLemak? butuhLemak;
  final ButuhKarbo? butuhKarbo;

  Data({
    required this.amb,
    required this.keseluruhanEnergi,
    required this.imt,
    required this.butuhProtein,
    required this.butuhLemak,
    required this.butuhKarbo,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    final imt = json['imt'];
    final keseluruhanEnergi = json['total_energi'];
    final amb = json['amb'];

    final tempButuhProteinJson = json['kebutuhan_protein'];
    final butuhProtein = ButuhProtein.fromJson(tempButuhProteinJson);

    final tempButuhKarboJson = json['kebutuhan_karbo'];
    final butuhKarbo = ButuhKarbo.fromJson(tempButuhKarboJson);

    final tempButuhLemakJson = json['kebutuhan_lemak'];
    final butuhLemak = ButuhLemak.fromJson(tempButuhLemakJson);

    return Data(
      imt: imt,
      keseluruhanEnergi: keseluruhanEnergi,
      amb: amb,
      butuhProtein: butuhProtein,
      butuhLemak: butuhLemak,
      butuhKarbo: butuhKarbo,
    );
  }
}

class HasilKebutuhanGiziSerializer {
  final String? message;
  final Data? data;

  HasilKebutuhanGiziSerializer({this.message, this.data});

  factory HasilKebutuhanGiziSerializer.fromJson(Map<String, dynamic> json) {
    final message = json['message'];

    final tempDataJson = json['data'];
    final data = Data.fromJson(tempDataJson);

    return HasilKebutuhanGiziSerializer(
      message: message,
      data: data,
    );
  }
}
