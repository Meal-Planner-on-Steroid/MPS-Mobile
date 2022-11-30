/*
  ! Contoh data yang diambil
{
    "message": "Berhasil mengambil detail rekomendasi rencana diet",
    "statusCode": 200,
    "data": [
        {
            "id": 124,
            "riwayat_rekomendasi_id": 47,
            "created_at": "2022-11-28T17:55:53.540192Z",
            "updated_at": "2022-11-28T17:55:53.540252Z"
        },
    ]
}

*/

class Data {
  final int? id;
  final int? riwayatRekomendasiId;
  final String? createdAt;
  final String? updatedAt;

  Data({
    required this.id,
    required this.riwayatRekomendasiId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      riwayatRekomendasiId: json['riwayat_rekomendasi_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class RekomendasiRencanaDietSerializer {
  final String? message;
  final int? statusCode;
  final dynamic data;

  RekomendasiRencanaDietSerializer({this.message, this.statusCode, this.data});

  factory RekomendasiRencanaDietSerializer.fromJson(Map<String, dynamic> json) {
    if (json['data'] is List) {
      return RekomendasiRencanaDietSerializer(
        message: json['message'],
        statusCode: json['statusCode'],
        data: json['data'].map((e) => Data.fromJson(e)).toList(),
      );
    } else {
      return RekomendasiRencanaDietSerializer(
        message: json['message'],
        statusCode: json['statusCode'],
        data: Data.fromJson(json['data']),
      );
    }
  }
}
