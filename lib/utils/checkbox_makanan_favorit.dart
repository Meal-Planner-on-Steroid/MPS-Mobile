import 'package:flutter/material.dart';
import 'package:mps/app/controllers/modules/preferensi_makanan_controller.dart';
import 'package:mps/app/models/preferensi_makanan_model.dart';

// ignore: must_be_immutable
class CheckboxMakananFavorit extends StatefulWidget {
  final int makananId;
  final int? preferensiMakananId;
  bool? checked = false;

  CheckboxMakananFavorit({
    Key? key,
    required this.makananId,
    this.preferensiMakananId,
    this.checked,
  }) : super(key: key);

  @override
  State<CheckboxMakananFavorit> createState() => _CheckboxMakananFavoritState();
}

class _CheckboxMakananFavoritState extends State<CheckboxMakananFavorit> {
  final _preferensiMakananController = PreferensiMakananController();
  var preferensiMakananModel = PreferensiMakanan();

  Color? _checkColor;
  IconData? _checkIcon;
  bool? checked;

  @override
  void initState() {
    super.initState();

    if (widget.checked == false || widget.checked == null) {
      _checkColor = Colors.blue;
      _checkIcon = Icons.crop_square_outlined;
      checked = false;
    } else {
      _checkColor = Colors.green;
      _checkIcon = Icons.check_circle;
      checked = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          _checkIcon,
          color: _checkColor,
          size: 30,
        ),
      ),
      onTap: () async {
        // Setstate dipecah agar lebih mudah dibaca

        preferensiMakananModel.makananId = widget.makananId;
        preferensiMakananModel.jenis = 'FV';

        // Update checked di awal
        setState(() => checked = !checked!);

        if (checked!) {
          // POST untuk create preferensi makanan
          if (await _preferensiMakananController.post(preferensiMakananModel)) {
            setState(() {
              _checkColor = Colors.green;
              _checkIcon = Icons.check_circle;
            });
          } else {
            setState(() => checked = !checked!);
          }
        } else {
          // DELETE untuk hapus preferensi makanan
          if (await _preferensiMakananController
              .delete(preferensiMakananModel)) {
            setState(() {
              _checkColor = Colors.blue;
              _checkIcon = Icons.crop_square_outlined;
            });
          } else {
            setState(() => checked = !checked!);
          }
        }

        debugPrint('Checked adalah ${widget.checked}');
      },
    );
  }
}
