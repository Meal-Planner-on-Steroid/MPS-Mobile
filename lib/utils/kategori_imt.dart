String kategoriImt(double imt) {
  String hasil = '???';

  if (imt < 17.0) {
    return "Kurus berat";
  } else if (imt >= 17.0 && imt <= 18.5) {
    return "Kurus ringan";
  } else if (imt > 18.5 && imt <= 25.0) {
    return "Normal";
  } else if (imt > 25.0 && imt <= 27.0) {
    return "Obesitas ringan";
  } else if (imt > 27.0) {
    return "Obesitas berat";
  }

  return hasil;
}
