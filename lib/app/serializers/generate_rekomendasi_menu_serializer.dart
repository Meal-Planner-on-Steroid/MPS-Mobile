/*
! contoh data
{
    "message": "Berhasil membuat rekomendasi",
    "data": {
        "kebutuhan_gizi": {
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
        },
        "rekomendasi": [
            [
                {
                    "id": 1349,
                    "nama": "Tedong pallu basa, masakan",
                    "porsi": 0,
                    "lemak": 2.8,
                    "protein": 10.4,
                    "karbo": 3.4,
                    "energi": 83.0,
                    "jenis": "ME",
                    "berat_porsi": 100.0,
                    "besar_porsi_id": 39,
                    "sumber": "KZGMI-2001",
                    "kelompok": "Daging"
                }
            ],
            [
                {
                    "id": 587,
                    "nama": "Refried Beans with Meat",
                    "porsi": 0,
                    "lemak": 50.6,
                    "protein": 35.6,
                    "karbo": 74.8,
                    "energi": 888.0,
                    "jenis": "ME",
                    "berat_porsi": 460.0,
                    "besar_porsi_id": 71,
                    "sumber": "https://www.fatsecret.com/calories-nutrition/generic/refried-beans-with-meat",
                    "kelompok": "Generic"
                },
                {
                    "id": 667,
                    "nama": "Custard Pie (Individual Size or Tart)",
                    "porsi": 0,
                    "lemak": 69.25,
                    "protein": 66.67,
                    "karbo": 308.81,
                    "energi": 2129.0,
                    "jenis": "ME",
                    "berat_porsi": 1170.0,
                    "besar_porsi_id": 71,
                    "sumber": "https://www.fatsecret.com/calories-nutrition/generic/pie-custard-individual-size-or-tart",
                    "kelompok": "Generic"
                }
            ]
        ]
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

class KebutuhanGizi {
  final double? amb;
  final double? keseluruhanEnergi;
  final double? energiSesuai;
  final double? imt;
  final ButuhProtein? butuhProtein;
  final ButuhLemak? butuhLemak;
  final ButuhKarbo? butuhKarbo;

  KebutuhanGizi({
    required this.amb,
    required this.keseluruhanEnergi,
    required this.energiSesuai,
    required this.imt,
    required this.butuhProtein,
    required this.butuhLemak,
    required this.butuhKarbo,
  });

  factory KebutuhanGizi.fromJson(Map<String, dynamic> json) {
    return KebutuhanGizi(
      imt: json['imt'],
      keseluruhanEnergi: json['total_energi'],
      energiSesuai: json['energi_sesuai'],
      amb: json['amb'],
      butuhProtein: ButuhProtein.fromJson(json['kebutuhan_protein']),
      butuhLemak: ButuhLemak.fromJson(json['kebutuhan_lemak']),
      butuhKarbo: ButuhKarbo.fromJson(json['kebutuhan_karbo']),
    );
  }

  Map<String, dynamic> toJson() => {
        "amb": amb,
        "total_energi": keseluruhanEnergi,
        "imt": imt,
        "kebutuhan_protein": {
          "protein_15": butuhProtein!.protein15,
          "protein_20": butuhProtein!.protein20
        },
        "kebutuhan_lemak": {
          "lemak_20": butuhLemak!.lemak20,
          "lemak_25": butuhLemak!.lemak25
        },
        "kebutuhan_karbo": {
          "karbo_55": butuhKarbo!.karbo55,
          "karbo_65": butuhKarbo!.karbo65
        }
      };
}

class RekomendasiMakanan {
  final int? id;
  final String? nama;
  final int? porsi;
  final int? besarPorsiId;
  final double? beratPorsi;
  final double? lemak;
  final double? protein;
  final double? karbo;
  final double? energi;
  final String? jenis;
  final String? sumber;
  final String? kelompok;

  RekomendasiMakanan({
    required this.id,
    required this.nama,
    required this.porsi,
    required this.besarPorsiId,
    required this.beratPorsi,
    required this.lemak,
    required this.protein,
    required this.karbo,
    required this.energi,
    required this.jenis,
    required this.sumber,
    required this.kelompok,
  });

  factory RekomendasiMakanan.fromJson(Map<String, dynamic> json) {
    return RekomendasiMakanan(
      id: json['id'],
      nama: json['nama'],
      porsi: json['porsi'],
      besarPorsiId: json['besar_porsi_id'],
      beratPorsi: json['berat_porsi'],
      lemak: json['lemak'],
      protein: json['protein'],
      karbo: json['karbo'],
      energi: json['energi'],
      jenis: json['jenis'],
      sumber: json['sumber'],
      kelompok: json['kelompok'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "porsi": porsi,
        "lemak": lemak,
        "protein": protein,
        "karbo": karbo,
        "energi": energi,
        "jenis": jenis,
        "berat_porsi": beratPorsi,
        "besar_porsi_id": besarPorsiId,
        "sumber": sumber,
        "kelompok": kelompok,
      };
}

class Data {
  final KebutuhanGizi kebutuhanGizi;
  final dynamic rekomendasiMakanan;

  Data({
    required this.kebutuhanGizi,
    required this.rekomendasiMakanan,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      kebutuhanGizi: KebutuhanGizi.fromJson(json['kebutuhan_gizi']),
      rekomendasiMakanan: json['rekomendasi']
          .map((list) =>
              list.map((item) => RekomendasiMakanan.fromJson(item)).toList())
          .toList(),
    );
  }
}

class GenerateRekomendasiMenuSerializer {
  final String? message;
  final Data? data;

  GenerateRekomendasiMenuSerializer({this.message, this.data});

  factory GenerateRekomendasiMenuSerializer.fromJson(
      Map<String, dynamic> json) {
    final message = json['message'];

    final tempDataJson = json['data'];
    final data = Data.fromJson(tempDataJson);

    return GenerateRekomendasiMenuSerializer(
      message: message,
      data: data,
    );
  }
}
