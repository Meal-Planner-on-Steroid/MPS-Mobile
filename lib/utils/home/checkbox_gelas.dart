import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CheckboxGelas extends StatefulWidget {
  bool isDone;
  CheckboxGelas({
    super.key,
    required this.isDone,
  });

  @override
  State<CheckboxGelas> createState() => _CheckboxGelasState();
}

class _CheckboxGelasState extends State<CheckboxGelas> {
  late Color _glassColor = widget.isDone ? Colors.blue : Colors.black;
  late bool _checked = widget.isDone;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        color: Colors.transparent,
        child: Icon(
          Icons.local_drink_rounded,
          color: _glassColor,
          size: 48,
        ),
      ),
      onTap: () {
        setState(() {
          if (_checked) {
            _glassColor = Colors.blue;
          } else {
            _glassColor = Colors.black;
          }
          _checked = !_checked;
        });
      },
    );
  }
}
