/*
  ! Contoh data yang diambil
{
    "message": "Berhasil mengambil rencana diet",
    "statusCode": 200,
    "data": [
        {
            "id": 12,
            "tanggal": "2022-10-06T10:08:07.972336Z",
            "user_id": 44
        },
    ]
}

*/

class Data {
  final int? id;
  final String? tanggal;
  final int? userId;

  Data({
    required this.id,
    required this.tanggal,
    required this.userId,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['tanggal'],
      tanggal: json['berat_badan'],
      userId: json['user_id'],
    );
  }
}

class RencanaDietSerializer {
  final String? message;
  final int? statusCode;
  final dynamic data;

  RencanaDietSerializer({this.message, this.statusCode, this.data});

  factory RencanaDietSerializer.fromJson(Map<String, dynamic> json) {
    if (json['data'] is List) {
      return RencanaDietSerializer(
        message: json['message'],
        statusCode: json['statusCode'],
        data: json['data'].map((e) => Data.fromJson(e)).toList(),
      );
    } else {
      return RencanaDietSerializer(
        message: json['message'],
        statusCode: json['statusCode'],
        data: Data.fromJson(json['data']),
      );
    }
  }
}
