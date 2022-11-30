/*
  ! Contoh data yang diambil
{
    "message": "Berhasil mengambil detail hari riwayat rekomendasi rencana diet",
    "statusCode": 200,
    "data": [
        {
            "id": 463,
            "makanan_id": 274,
            "waktu_makan": "PH",
            "rekomendasi_rencana_diet_id": 124,
            "created_at": "2022-11-28T17:55:53.546740Z",
            "updated_at": "2022-11-28T17:55:53.546792Z"
        },
    ]
}

*/

class Data {
  final int? id;
  final int? makananId;
  final String? waktuMakan;
  final int? rekomendasiRencanaDietId;
  final String? createdAt;
  final String? updatedAt;

  Data({
    required this.id,
    required this.makananId,
    required this.waktuMakan,
    required this.rekomendasiRencanaDietId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      makananId: json['makanan_id'],
      waktuMakan: json['waktu_makan'],
      rekomendasiRencanaDietId: json['rekomendasi_rencana_diet_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class RekomendasiMakananDietSerializer {
  final String? message;
  final int? statusCode;
  final dynamic data;

  RekomendasiMakananDietSerializer({this.message, this.statusCode, this.data});

  factory RekomendasiMakananDietSerializer.fromJson(Map<String, dynamic> json) {
    if (json['data'] is List) {
      return RekomendasiMakananDietSerializer(
        message: json['message'],
        statusCode: json['statusCode'],
        data: json['data'].map((e) => Data.fromJson(e)).toList(),
      );
    } else {
      return RekomendasiMakananDietSerializer(
        message: json['message'],
        statusCode: json['statusCode'],
        data: Data.fromJson(json['data']),
      );
    }
  }
}
