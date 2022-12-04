import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CheckboxGreen extends StatefulWidget {
  final bool checked;
  const CheckboxGreen({
    Key? key,
    this.checked = false,
  }) : super(key: key);

  @override
  State<CheckboxGreen> createState() => _CheckboxGreenState();
}

class _CheckboxGreenState extends State<CheckboxGreen> {
  // Color _checkColor = Colors.blue;
  // IconData _checkIcon = Icons.crop_square_outlined;
  // bool checked = false;

  Color? _checkColor;
  IconData? _checkIcon;
  bool? checked;

  @override
  void initState() {
    super.initState();

    if (widget.checked == false) {
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
        // Update checked di awal
        setState(() => checked = !checked!);

        debugPrint('dari checkbox green');

        if (checked!) {
          // POST untuk create preferensi makanan
          setState(() {
            _checkColor = Colors.green;
            _checkIcon = Icons.check_circle;
          });
        } else {
          // DELETE untuk hapus preferensi makanan
          setState(() {
            _checkColor = Colors.blue;
            _checkIcon = Icons.crop_square_outlined;
          });
        }
      },
    );
  }
}
