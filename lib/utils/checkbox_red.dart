import 'package:flutter/material.dart';

class CheckboxRed extends StatefulWidget {
  const CheckboxRed({Key? key}) : super(key: key);

  @override
  State<CheckboxRed> createState() => _CheckboxRedState();
}

class _CheckboxRedState extends State<CheckboxRed> {
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
      onTap: () {
        setState(() {
          checked = !checked;
          if (checked) {
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
