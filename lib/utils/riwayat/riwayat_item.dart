import 'package:flutter/material.dart';
import '../../screens/riwayat/riwayat_detail_page.dart';

class RiwayatItem extends StatefulWidget {
  final String title;
  final int riwayatId;
  const RiwayatItem({
    Key? key,
    required this.title,
    required this.riwayatId,
  }) : super(key: key);

  @override
  State<RiwayatItem> createState() => _RiwayatItemState();
}

class _RiwayatItemState extends State<RiwayatItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                RiwayatDetailpage(riwayatId: widget.riwayatId),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(9),
          ),
          border: Border.all(
            color: Colors.grey.shade700,
            width: 2,
          ),
        ),
        padding:
            const EdgeInsets.only(top: 10, left: 16, bottom: 10, right: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.title),
            PopupMenuButton<String>(
              icon: const Icon(Icons.arrow_drop_down_circle),
              onSelected: (String result) {
                switch (result) {
                  case 'filter1':
                    debugPrint('filter 1 clicked');
                    break;
                  case 'filter2':
                    debugPrint('filter 2 clicked');
                    break;
                  case 'clearFilters':
                    debugPrint('Clear filters');
                    break;
                  default:
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: 'filter1',
                  child: Row(
                    children: const [
                      Icon(Icons.save),
                      SizedBox(width: 8),
                      Text('Export'),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'filter2',
                  child: Row(
                    children: const [
                      Icon(Icons.forward),
                      SizedBox(width: 8),
                      Text('Share'),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'clearFilters',
                  child: Row(
                    children: const [
                      Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Delete',
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
