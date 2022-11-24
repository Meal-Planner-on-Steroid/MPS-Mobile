import 'package:flutter/material.dart';
import 'package:mps/app/controllers/modules/preferensi_makanan_controller.dart';
import 'package:mps/app/models/preferensi_makanan_model.dart';

class CheckboxMakananFavorit extends StatefulWidget {
  final int userId;
  final int makananId;
  final int? preferensiMakananId;

  const CheckboxMakananFavorit({
    Key? key,
    required this.userId,
    required this.makananId,
    this.preferensiMakananId,
  }) : super(key: key);

  @override
  State<CheckboxMakananFavorit> createState() => _CheckboxMakananFavoritState();
}

class _CheckboxMakananFavoritState extends State<CheckboxMakananFavorit> {
  final _preferensiMakananController = PreferensiMakananController();
  var preferensiMakananModel = PreferensiMakanan();

  Color _checkColor = Colors.blue;
  IconData _checkIcon = Icons.crop_square_outlined;
  bool checked = false;

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
        if (checked) {
          // POST untuk create preferensi makanan
          preferensiMakananModel.userId = widget.userId;
          preferensiMakananModel.makananId = widget.makananId;
          preferensiMakananModel.jenis = 'fav';
          if (await _preferensiMakananController.post(preferensiMakananModel)) {
            setState(() {
              _checkColor = Colors.green;
              _checkIcon = Icons.check_circle;
            });
          }
        } else {
          // DELETE untuk hapus preferensi makanan
          if (await _preferensiMakananController
              .delete(widget.preferensiMakananId!)) {
            setState(() {
              _checkColor = Colors.blue;
              _checkIcon = Icons.crop_square_outlined;
            });
          }
        }
        checked = !checked;
      },
    );
  }
}
