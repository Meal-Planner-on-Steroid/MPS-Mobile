import 'package:flutter/material.dart';

class CheckboxGreen extends StatefulWidget {
  const CheckboxGreen({Key? key}) : super(key: key);

  @override
  State<CheckboxGreen> createState() => _CheckboxGreenState();
}

class _CheckboxGreenState extends State<CheckboxGreen> {
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
          if (checked) {
            _checkColor = Colors.green;
            _checkIcon = Icons.check_circle;
          } else {
            _checkColor = Colors.blue;
            _checkIcon = Icons.crop_square_outlined;
          }
          checked = !checked;
        });
      },
    );
  }
}
