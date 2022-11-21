/*
  ! Contoh data yang diambil
{
    "message": "Berhasil mengambil preferensi makanan",
    "statusCode": 200,
    "data": [
        {
            "id": 2,
            "user_id": 44,
            "makanan_id": 9,
            "jenis": "BL"
        },
    ]
}
*/

class Data {
  final int? id;
  final String? userId;
  final String? makananId;
  final String? jenis;

  Data({
    required this.id,
    required this.userId,
    required this.makananId,
    required this.jenis,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      userId: json['userId'],
      makananId: json['makananId'],
      jenis: json['jenis'],
    );
  }
}

class PreferensiMakananSeralizer {
  final String? message;
  final int? statusCode;
  final dynamic data;

  PreferensiMakananSeralizer({this.message, this.statusCode, this.data});

  factory PreferensiMakananSeralizer.fromJson(Map<String, dynamic> json) {
    if (json['data'] is List) {
      return PreferensiMakananSeralizer(
        message: json['message'],
        statusCode: json['statusCode'],
        data: json['data'].map((e) => Data.fromJson(e)).toList(),
      );
    } else {
      return PreferensiMakananSeralizer(
        message: json['message'],
        statusCode: json['statusCode'],
        data: Data.fromJson(json['data']),
      );
    }
  }
}
