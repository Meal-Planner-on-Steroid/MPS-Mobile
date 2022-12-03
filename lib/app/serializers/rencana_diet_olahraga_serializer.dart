/*
  ! Contoh data yang diambil
{
    "message": "Berhasil mengambil rencana diet olahraga",
    "statusCode": 200,
    "data": [
        {
            "id": 59,
            "nama": "",
            "status": 2,
            "rencana_diet_id": 67,
            "created_at": "2022-12-01T14:30:31.881278Z",
            "updated_at": "2022-12-01T14:30:31.881340Z"
        }
    ]
}

*/

class Data {
  final int? id;
  final String? nama;
  final int? status;
  final int? rencanaDietId;
  final String? createdAt;
  final String? updatedAt;

  Data({
    required this.id,
    required this.nama,
    required this.status,
    required this.rencanaDietId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      nama: json['nama'],
      status: json['status'],
      rencanaDietId: json['rencana_diet_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class RencanaDietOlahragaSerializer {
  final String? message;
  final int? statusCode;
  final dynamic data;

  RencanaDietOlahragaSerializer({this.message, this.statusCode, this.data});

  factory RencanaDietOlahragaSerializer.fromJson(Map<String, dynamic> json) {
    if (json['data'] is List) {
      return RencanaDietOlahragaSerializer(
        message: json['message'],
        statusCode: json['statusCode'],
        data: json['data'].map((e) => Data.fromJson(e)).toList(),
      );
    } else {
      return RencanaDietOlahragaSerializer(
        message: json['message'],
        statusCode: json['statusCode'],
        data: Data.fromJson(json['data']),
      );
    }
  }
}
