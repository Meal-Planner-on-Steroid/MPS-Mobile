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

class KebutuhanGizi {
  double beratBadan = 0;
  double tinggiBadan = 0;
  int usia = 0;
  String gender = 'LA';
  double imt = 0;
  double keseluruhanEnergi = 0;
  ButuhProtein butuhProtein = ButuhProtein();
  ButuhLemak butuhLemak = ButuhLemak();
  ButuhKarbo butuhKarbo = ButuhKarbo();

  Map<String, dynamic> toJson() => {
        "berat_badan": beratBadan,
        "tinggi_badan": tinggiBadan,
        "usia": usia,
        "gender": gender,
        "imt": imt,
        "keseluruhan_energi": keseluruhanEnergi,
        "butuh_protein": {
          "protein_10": butuhProtein.protein10,
          "protein_15": butuhProtein.protein15
        },
        "butuh_lemak": {
          "lemak_10": butuhLemak.lemak10,
          "lemak_25": butuhLemak.lemak25
        },
        "butuh_karbo": {
          "karbo_60": butuhKarbo.karbo60,
          "karbo_75": butuhKarbo.karbo75
        }
      };
}

class RiwayatRekomendasiRencanaDiet {
  int userId = 0;
  KebutuhanGizi kebutuhanGizi = KebutuhanGizi();
  dynamic rekomendasi;
}
