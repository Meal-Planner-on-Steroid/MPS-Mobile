import 'package:mps/app/serializers/makanan_serializer.dart';
import 'package:mps/app/serializers/satuan_serializer.dart';

class DetailMenu {
  MakananSerializer makanan = MakananSerializer();
  SatuanSerializer satuan = SatuanSerializer();
  MakananSerializer makananTerkait = MakananSerializer();
}
