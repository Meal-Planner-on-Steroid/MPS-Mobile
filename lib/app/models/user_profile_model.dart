class ButuhProtein {
  double protein10 = 0;
  double protein15 = 0;
}

class ButuhKarbo {
  double karbo60 = 0;
  double karbo75 = 0;
}

class ButuhLemak {
  double lemak10 = 0;
  double lemak25 = 0;
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
  String gender = 'LA';
  double imt = 0;
  double keseluruhanEnergi = 0;
  ButuhProtein butuhProtein = ButuhProtein();
  ButuhLemak butuhLemak = ButuhLemak();
  ButuhKarbo butuhKarbo = ButuhKarbo();
}
