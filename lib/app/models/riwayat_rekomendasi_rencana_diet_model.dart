class ButuhProtein {
  double protein15 = 0;
  double protein20 = 0;
}

class ButuhLemak {
  double lemak20 = 0;
  double lemak25 = 0;
}

class ButuhKarbo {
  double karbo55 = 0;
  double karbo65 = 0;
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
          "protein_15": butuhProtein.protein15,
          "protein_20": butuhProtein.protein20
        },
        "butuh_lemak": {
          "lemak_20": butuhLemak.lemak20,
          "lemak_25": butuhLemak.lemak25
        },
        "butuh_karbo": {
          "karbo_55": butuhKarbo.karbo55,
          "karbo_65": butuhKarbo.karbo65
        }
      };
}

class RiwayatRekomendasiRencanaDiet {
  int userId = 0;
  KebutuhanGizi kebutuhanGizi = KebutuhanGizi();
  dynamic rekomendasi;
}
