/*
  ! Contoh data yang diambil
{
    "message": "Berhasil mengambil Makanan",
    "statusCode": 200,
    "data": [
        {
            "id": 1,
            "nama": "Apple Coffee Cake - 1 piece",
            "porsi": 1,
            "lemak": 10.4,
            "protein": 3.81,
            "karbo": 51.49,
            "energi": 309.01,
            "jenis": "CA",
            "berat_porsi": 136.75,
            "besar_porsi_id": 61,
            "sumber": "nutritionix",
            "kelompok": "3"
        },
    ]
}
*/

class Data {
  final int? id;
  final String? nama;
  final String? porsi;
  final String? besarPorsiId;
  final double? beratPorsi;
  final double? lemak;
  final double? protein;
  final double? karbo;
  final double? energi;
  final String? jenis;
  final String? sumber;
  final String? kelompok;

  Data({
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

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      nama: json['nama'],
      porsi: json['porsi'],
      besarPorsiId: json['besarPorsiId'],
      beratPorsi: json['beratPorsi'],
      lemak: json['lemak'],
      protein: json['protein'],
      karbo: json['karbo'],
      energi: json['energi'],
      jenis: json['jenis'],
      sumber: json['sumber'],
      kelompok: json['kelompok'],
    );
  }
}

class MakananSerializer {
  final String? message;
  final int? statusCode;
  final dynamic data;

  MakananSerializer({this.message, this.statusCode, this.data});

  factory MakananSerializer.fromJson(Map<String, dynamic> json) {
    if (json['data'] is List) {
      return MakananSerializer(
        message: json['message'],
        statusCode: json['statusCode'],
        data: json['data'].map((e) => Data.fromJson(e)).toList(),
      );
    } else {
      return MakananSerializer(
        message: json['message'],
        statusCode: json['statusCode'],
        data: Data.fromJson(json['data']),
      );
    }
  }
}
