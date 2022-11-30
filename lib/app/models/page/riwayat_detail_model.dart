import 'package:mps/app/serializers/makanan_serializer.dart';
import 'package:mps/app/serializers/rekomendasi_makanan_diet_serializer.dart';
import 'package:mps/app/serializers/rekomendasi_rencana_diet_serializer.dart';
import 'package:mps/app/serializers/riwayat_rekomendasi_rencana_diet_serializer.dart';

class RiwayatDetail {
  RiwayatRekomendasiRencanaDietSerializer riwayatRekomendasi =
      RiwayatRekomendasiRencanaDietSerializer();
  RekomendasiRencanaDietSerializer rekomendasiRencana =
      RekomendasiRencanaDietSerializer();
  RekomendasiMakananDietSerializer rekomendasiMakanan =
      RekomendasiMakananDietSerializer();
  MakananSerializer makanan = MakananSerializer();
}
