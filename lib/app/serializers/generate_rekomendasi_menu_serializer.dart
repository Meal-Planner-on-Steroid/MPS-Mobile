/*
! contoh data
{
    "message": "Berhasil membuat rekomendasi",
    "data": {
        "kebutuhan_gizi": {
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

class KebutuhanGizi {
  final double? amb;
  final double? keseluruhanEnergi;
  final double? imt;
  final ButuhProtein? butuhProtein;
  final ButuhLemak? butuhLemak;
  final ButuhKarbo? butuhKarbo;

  KebutuhanGizi({
    required this.amb,
    required this.keseluruhanEnergi,
    required this.imt,
    required this.butuhProtein,
    required this.butuhLemak,
    required this.butuhKarbo,
  });

  factory KebutuhanGizi.fromJson(Map<String, dynamic> json) {
    return KebutuhanGizi(
      imt: json['imt'],
      keseluruhanEnergi: json['total_energi'],
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
          "protein_10": butuhProtein!.protein10,
          "protein_15": butuhProtein!.protein15
        },
        "kebutuhan_lemak": {
          "lemak_10": butuhLemak!.lemak10,
          "lemak_25": butuhLemak!.lemak25
        },
        "kebutuhan_karbo": {
          "karbo_60": butuhKarbo!.karbo60,
          "karbo_75": butuhKarbo!.karbo75
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
