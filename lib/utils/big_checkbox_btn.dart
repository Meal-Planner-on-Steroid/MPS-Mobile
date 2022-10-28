import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BigCheckboxBtn extends StatefulWidget {
  String title;
  bool selected;

  BigCheckboxBtn({Key? key, required this.selected, required this.title})
      : super(key: key);

  @override
  State<BigCheckboxBtn> createState() => _BigCheckboxBtnState();
}

class _BigCheckboxBtnState extends State<BigCheckboxBtn> {
  late Color _btnColor = widget.selected
      ? const Color.fromRGBO(127, 209, 174, 1)
      : Colors.yellow.shade800;
  late bool _checked = widget.selected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          width: double.infinity,
          height: 80,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
              primary: _btnColor,
            ),
            onPressed: () {
              setState(() {
                if (_checked) {
                  _btnColor = Colors.yellow.shade800;
                } else {
                  _btnColor = const Color.fromRGBO(127, 209, 174, 1);
                }
                _checked = !_checked;
                debugPrint(_checked.toString());
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(11.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Visibility(
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    visible: _checked,
                    child: const Icon(
                      Icons.check_circle,
                      color: Colors.white,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Visibility(
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    visible: false,
                    child: Icon(Icons.check_circle),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
