/*
  ! Contoh data yang diambil
{
    "message": "Berhasil mengambil makanan terkait",
    "statusCode": 200,
    "data": [
        {
            "id": 10,
            "berat": 10.0,
            "satuan_id": 15,
            "bahan_makanan_id": 1640,
            "menu_makanan_id": 12
        },
    ]
}

*/

class Data {
  final int? id;
  final int? berat;
  final int? satuanId;
  final int? bahanMakananId;
  final int? menuMakananId;

  Data({
    required this.id,
    required this.berat,
    required this.satuanId,
    required this.bahanMakananId,
    required this.menuMakananId,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      berat: json['berat'],
      satuanId: json['satuan_id'],
      bahanMakananId: json['bahan_makanan_id'],
      menuMakananId: json['menu_makanan_id'],
    );
  }
}

class BahanMakananSerializer {
  final String? message;
  final int? statusCode;
  final dynamic data;

  BahanMakananSerializer({this.message, this.statusCode, this.data});

  factory BahanMakananSerializer.fromJson(Map<String, dynamic> json) {
    if (json['data'] is List) {
      return BahanMakananSerializer(
        message: json['message'],
        statusCode: json['statusCode'],
        data: json['data'].map((e) => Data.fromJson(e)).toList(),
      );
    } else {
      return BahanMakananSerializer(
        message: json['message'],
        statusCode: json['statusCode'],
        data: Data.fromJson(json['data']),
      );
    }
  }
}
