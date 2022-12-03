/*
  ! Contoh data yang diambil
{
    "message": "Berhasil mengambil rencana diet makanan",
    "statusCode": 200,
    "data": [
        {
            "id": 229,
            "waktu_makan": "PH",
            "status": 2,
            "makanan_id": 138,
            "rencana_diet_id": 67,
            "created_at": "2022-12-01T14:30:31.817885Z",
            "updated_at": "2022-12-01T14:30:31.817939Z"
        },
    ]
}

*/

class Data {
  final int? id;
  final String? waktuMakan;
  final int? status;
  final int? makananId;
  final int? rencanaDietId;
  final String? createdAt;
  final String? updatedAt;

  Data({
    required this.id,
    required this.waktuMakan,
    required this.status,
    required this.makananId,
    required this.rencanaDietId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      waktuMakan: json['waktu_makan'],
      status: json['status'],
      makananId: json['makanan_id'],
      rencanaDietId: json['rencana_diet_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class RencanaDietMakananSerializer {
  final String? message;
  final int? statusCode;
  final dynamic data;

  RencanaDietMakananSerializer({this.message, this.statusCode, this.data});

  factory RencanaDietMakananSerializer.fromJson(Map<String, dynamic> json) {
    if (json['data'] is List) {
      return RencanaDietMakananSerializer(
        message: json['message'],
        statusCode: json['statusCode'],
        data: json['data'].map((e) => Data.fromJson(e)).toList(),
      );
    } else {
      return RencanaDietMakananSerializer(
        message: json['message'],
        statusCode: json['statusCode'],
        data: Data.fromJson(json['data']),
      );
    }
  }
}
