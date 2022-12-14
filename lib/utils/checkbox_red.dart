import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CheckboxRed extends StatefulWidget {
  bool? checked = false;
  CheckboxRed({
    Key? key,
    this.checked,
  }) : super(key: key);

  @override
  State<CheckboxRed> createState() => _CheckboxRedState();
}

class _CheckboxRedState extends State<CheckboxRed> {
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
      _checkColor = Colors.red;
      _checkIcon = Icons.cancel_rounded;
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
      onTap: () {
        setState(() {
          checked = !checked!;
          if (checked == true) {
            _checkColor = Colors.red;
            _checkIcon = Icons.cancel_rounded;
          } else {
            _checkColor = Colors.blue;
            _checkIcon = Icons.crop_square_outlined;
          }
          debugPrint("checked adalah $checked");
        });
      },
    );
  }
}
