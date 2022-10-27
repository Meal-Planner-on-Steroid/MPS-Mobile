import 'package:flutter/material.dart';
// import '../makanan_card.dart';
import 'slider_rencana_diet_item.dart';
import 'checkbox_gelas.dart';

class SliderRencanaDietPage extends StatefulWidget {
  final String hari;
  final List makanans;
  final PageController controller;

  const SliderRencanaDietPage({
    Key? key,
    required this.hari,
    required this.makanans,
    required this.controller,
  }) : super(key: key);

  @override
  State<SliderRencanaDietPage> createState() => _SliderRencanaDietPageState();
}

class _SliderRencanaDietPageState extends State<SliderRencanaDietPage> {
  final List<ListMinum> listMinum = [
    ListMinum(id: '1', isDone: true),
    ListMinum(id: '1', isDone: true),
    ListMinum(id: '1', isDone: true),
    ListMinum(id: '1', isDone: false),
    ListMinum(id: '1', isDone: false),
    ListMinum(id: '1', isDone: false),
    ListMinum(id: '1', isDone: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 24,
        left: 24,
        right: 24,
      ),
      child: Column(
        children: [
          // Navigation hari
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  widget.controller.previousPage(
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeInOut);
                },
                icon: const Icon(Icons.arrow_circle_left),
              ),
              Text(widget.hari),
              IconButton(
                onPressed: () {
                  widget.controller.nextPage(
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeInOut);
                },
                icon: const Icon(Icons.arrow_circle_right),
              ),
            ],
          ),

          // Rencana minum air
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromRGBO(127, 209, 174, 1),
                width: 2,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(9),
              ),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: listMinum
                    .map((item) => CheckboxGelas(
                          isDone: item.isDone,
                        ))
                    .toList(),
              ),
            ),
          ),

          // List rencana diet
          SliderRencanaDietItem(makanans: widget.makanans)
        ],
      ),
    );
  }
}

class ListMinum {
  final String id;
  final bool isDone;

  ListMinum({
    required this.id,
    required this.isDone,
  });
}
