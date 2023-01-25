/*
! contoh data
{
    "message": "Berhasil menentukan kebutuhan gizi",
    "data": {
        "amb": 1958.0,
        "total_energi": 3230.7,
        "energi_sesuai": 2730.7,
        "imt": 35.59985760056959,
        "kebutuhan_protein": {
            "protein_15": 102.40124999999999,
            "protein_20": 136.535
        },
        "kebutuhan_lemak": {
            "lemak_20": 60.68222222222222,
            "lemak_25": 75.85277777777777
        },
        "kebutuhan_karbo": {
            "karbo_55": 375.47125,
            "karbo_65": 443.73875
        }
    }
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

    return ButuhProtein(
      protein15: protein15,
      protein20: protein20,
    );
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

    return ButuhLemak(
      lemak20: lemak20,
      lemak25: lemak25,
    );
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

    return ButuhKarbo(
      karbo55: karbo55,
      karbo65: karbo65,
    );
  }
}

class Data {
  final double? amb;
  final double? keseluruhanEnergi;
  final double? energiSesuai;
  final double? imt;
  final ButuhProtein? butuhProtein;
  final ButuhLemak? butuhLemak;
  final ButuhKarbo? butuhKarbo;

  Data({
    required this.amb,
    required this.keseluruhanEnergi,
    required this.energiSesuai,
    required this.imt,
    required this.butuhProtein,
    required this.butuhLemak,
    required this.butuhKarbo,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    final imt = json['imt'];
    final keseluruhanEnergi = json['total_energi'];
    final energiSesuai = json['energi_sesuai'];
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
      energiSesuai: energiSesuai,
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
