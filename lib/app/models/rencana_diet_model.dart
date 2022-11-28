class RencanaDietMakanan {
  String waktuMakan = '';
  int status = 2;
  dynamic makanan;

  Map<String, dynamic> toJson() => {
        "waktu_makan": waktuMakan,
        "status": makanan,
        "makanan": makanan,
      };
}

class RencanaDiet {
  int userId = 0;
  List<RencanaDietMakanan> rencanaDietMakanan = [];
  DateTime tanggal = DateTime.now();
  Map<String, dynamic> olahraga = {
    'nama': '',
    'status': '2',
  };
  Map<String, dynamic> minum = {
    'jumlah_minum': 8,
    'banyak_minum': 2,
    'progress': 0,
  };
}
