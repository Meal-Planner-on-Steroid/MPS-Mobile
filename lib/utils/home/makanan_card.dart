import 'package:flutter/material.dart';
import 'package:mps/app/controllers/pages/home_controller.dart';

class MakananCard extends StatefulWidget {
  final int rencanaMakanId;
  final int statusRencanaMakan;
  final String waktuMakan;
  final String namaMakanan;
  final double protein;
  final double karbo;
  final double fat;
  final double energi;

  const MakananCard({
    Key? key,
    this.rencanaMakanId = 0,
    this.statusRencanaMakan = 2,
    this.waktuMakan = 'Waktu makan',
    this.namaMakanan = 'Nama makanan',
    this.protein = 0,
    this.karbo = 0,
    this.fat = 0,
    this.energi = 0,
  }) : super(key: key);

  @override
  State<MakananCard> createState() => _MakananCardState();
}

class _MakananCardState extends State<MakananCard> {
  // Module & page controller
  final _homeController = HomeController();

  // Variable state
  Color? _checkColor;
  IconData? _checkIcon;
  bool? checked;

  void createState() {
    debugPrint('create sate dipanggil ${widget.rencanaMakanId}');
    debugPrint('Dengan status ${widget.statusRencanaMakan}');
    if (widget.statusRencanaMakan == 2) {
      _checkColor = Colors.blue;
      _checkIcon = Icons.crop_square_outlined;
      checked = false;
    } else {
      _checkColor = Colors.green;
      _checkIcon = Icons.check_circle;
      checked = true;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    createState();
  }

  @override
  Widget build(BuildContext context) {
    // debugPrint("rencana makan id: ${widget.rencanaMakanId}");
    // debugPrint("status: ${widget.statusRencanaMakan}");
    // createState();

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(9),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Title & Gambar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(9),
                        child: SizedBox.fromSize(
                          size: const Size.fromRadius(40),
                          child: Image.asset(
                            'assets/images/makanan_random.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.waktuMakan,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              widget.namaMakanan,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Checkbox
                GestureDetector(
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

                    debugPrint("dari makanan card");
                    debugPrint("Rencana makanan id: ${widget.rencanaMakanId}");
                    checked = !checked!;

                    if (widget.rencanaMakanId > 0) {
                      debugPrint("Rencana makan valid");
                      if (checked!) {
                        debugPrint("status diubah jadi 1");
                        if (await _homeController.updateProgresMakanan(
                            widget.rencanaMakanId, 1)) {
                          _checkColor = Colors.green;
                          _checkIcon = Icons.check_circle;
                        }
                      } else {
                        debugPrint("status diubah jadi 2");
                        if (await _homeController.updateProgresMakanan(
                            widget.rencanaMakanId, 2)) {
                          _checkColor = Colors.blue;
                          _checkIcon = Icons.crop_square_outlined;
                        }
                      }
                    } else {
                      debugPrint("Rencana makan tidak valid");
                    }

                    setState(() {});
                  },
                )

                // GestureDetector(
                //   child: Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: Icon(
                //       _checkIcon,
                //       color: _checkColor,
                //       size: 30,
                //     ),
                //   ),
                //   onTap: () async {
                //     // Update checked di awal
                //     setState(() => checked = !checked!);

                //     if (checked!) {
                //       setState(() {
                //         _checkColor = Colors.green;
                //         _checkIcon = Icons.check_circle;
                //       });
                //     } else {
                //       setState(() {
                //         _checkColor = Colors.blue;
                //         _checkIcon = Icons.crop_square_outlined;
                //       });
                //     }
                //   },
                // )
              ],
            ),

            // Divider
            Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                child: Container(
                  height: 2,
                  color: Colors.yellow.shade700,
                )),

            // Detail & kalori
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Detail
                Text(
                    "Pro ${widget.protein.toStringAsFixed(1)}, Karb ${widget.karbo.toStringAsFixed(1)}, Fat ${widget.fat.toStringAsFixed(1)}"),

                // Kalori
                Text(
                  "${widget.energi.toStringAsFixed(2)} kcal",
                  style: const TextStyle(color: Colors.blue),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
