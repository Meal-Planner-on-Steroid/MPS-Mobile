/*
  ! Contoh data yang diambil
{
    "message": "Berhasil mengambil rencana diet minum",
    "statusCode": 200,
    "data": [
        {
            "id": 59,
            "jumlah_minum": 8,
            "banyak_minum": 2,
            "progress": 0,
            "rencana_diet_id": 67,
            "created_at": "2022-12-01T14:30:31.885417Z",
            "updated_at": "2022-12-01T14:30:31.885480Z"
        }
    ]
}

*/

class Data {
  final int? id;
  final int? jumlahMinum;
  final int? banyakMinum;
  final int? progress;
  final int? rencanaDietId;
  final String? createdAt;
  final String? updatedAt;

  Data({
    required this.id,
    required this.jumlahMinum,
    required this.banyakMinum,
    required this.progress,
    required this.rencanaDietId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      jumlahMinum: json['jumlah_minum'],
      banyakMinum: json['banyak_minum'],
      progress: json['progress'],
      rencanaDietId: json['rencana_diet_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class RencanaDietMinumSerializer {
  final String? message;
  final int? statusCode;
  final dynamic data;

  RencanaDietMinumSerializer({this.message, this.statusCode, this.data});

  factory RencanaDietMinumSerializer.fromJson(Map<String, dynamic> json) {
    if (json['data'] is List) {
      return RencanaDietMinumSerializer(
        message: json['message'],
        statusCode: json['statusCode'],
        data: json['data'].map((e) => Data.fromJson(e)).toList(),
      );
    } else {
      return RencanaDietMinumSerializer(
        message: json['message'],
        statusCode: json['statusCode'],
        data: Data.fromJson(json['data']),
      );
    }
  }
}
