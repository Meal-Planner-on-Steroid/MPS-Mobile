class ButuhProteinModel {
  double? protein10;
  double? protein15;
}

class ButuhKarboModel {
  double? karbo60;
  double? karbo75;
}

class ButuhLemakModel {
  double? lemak10;
  double? lemak25;
}

class UserProfile {
  int id = 0;
  int userId = 0;
  String avatar = '';
  int tingkatAktivitasId = 0;
  double tingkatAktivitasNilai = 0;
  double beratBadan = 0;
  double tinggiBadan = 0;
  int usia = 0;
  String gender = '';
  double imt = 0;
  double keseluruhanEnergi = 0;
  ButuhProteinModel? butuhProtein;
  ButuhLemakModel? butuhLemak;
  ButuhKarboModel? butuhKarbo;
}
