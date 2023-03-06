import 'dart:math';

double hitungImt(double beratBadan, double tinggiBadan) {
  double imt = beratBadan / pow((tinggiBadan / 100), 2);
  return imt;
}
