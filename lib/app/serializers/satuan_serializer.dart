/*
  ! Contoh data yang diambil
{
    "message": "Berhasil mengambil Satuan",
    "statusCode": 200,
    "data": [
      {
        "id": 71,
        "nama": "serving"
      },
      {
        "id": 71,
        "nama": "serving"
      }
    ]
}

*/

class Data {
  final int? id;
  final String? nama;

  Data({
    required this.id,
    required this.nama,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      nama: json['nama'],
    );
  }
}

class SatuanSerializer {
  final String? message;
  final int? statusCode;
  final dynamic data;

  SatuanSerializer({this.message, this.statusCode, this.data});

  factory SatuanSerializer.fromJson(Map<String, dynamic> json) {
    if (json['data'] is List) {
      return SatuanSerializer(
        message: json['message'],
        statusCode: json['statusCode'],
        data: json['data'].map((e) => Data.fromJson(e)).toList(),
      );
    } else {
      return SatuanSerializer(
        message: json['message'],
        statusCode: json['statusCode'],
        data: Data.fromJson(json['data']),
      );
    }
  }
}
