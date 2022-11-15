/*
  ! Contoh data yang diambil
  {
      "message": "Berhasil mengambil tingkat aktivitas",
      "statusCode": 200,
      "data": [
          {
              "id": 4,
              "nama": "Sangat Ringan",
              "nilai": 1.3,
              "gender": "PE"
          },
      ]
  }

*/

class Data {
  final int? id;
  final String? nama;
  final int? nilai;
  final String? gender;

  Data({
    required this.id,
    required this.nama,
    required this.nilai,
    required this.gender,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    final nama = json['nama'];
    final nilai = json['nilai'];
    final gender = json['gender'];

    return Data(
      id: id,
      nama: nama,
      nilai: nilai,
      gender: gender,
    );
  }
}

class TingkatAktivitasSeralizer {
  final String? message;
  final int? statusCode;
  final List? data;

  TingkatAktivitasSeralizer({this.message, this.statusCode, this.data});

  factory TingkatAktivitasSeralizer.fromJson(Map<String, dynamic> json) {
    final message = json['message'];
    final statusCode = json['statusCode'];

    // final tempDataJson = json['data'][0];
    // final data = Data.fromJson(tempDataJson);
    final tempDataJson = json['data'];
    final List data = List.from(tempDataJson);

    return TingkatAktivitasSeralizer(
      message: message,
      statusCode: statusCode,
      data: data,
    );
  }
}
