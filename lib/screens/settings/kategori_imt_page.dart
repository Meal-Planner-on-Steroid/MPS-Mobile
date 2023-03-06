import 'package:flutter/material.dart';

class KategoriImt extends StatelessWidget {
  final String fromPage;
  const KategoriImt({
    super.key,
    required this.fromPage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(fromPage),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context)
                    .size
                    .width, // replace with your desired maximum width
              ),
              child: DataTable(
                columnSpacing: 4,
                columns: const <DataColumn>[
                  DataColumn(
                    label: Text(
                      'Status',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Kategori',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Ambang IMT',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
                rows: const <DataRow>[
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('Kurus')),
                      DataCell(Text('tingkat berat')),
                      DataCell(Text('< 17.0')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('Kurus')),
                      DataCell(Text('tingkat ringan')),
                      DataCell(Text('> 17.0 - 18.5')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('Normal')),
                      DataCell(Text('')),
                      DataCell(Text('> 18.5 - 25.0')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('Obesitas')),
                      DataCell(Text('tingkat ringan')),
                      DataCell(Text('> 25.0 - 27.0')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('Obesitas')),
                      DataCell(Text('tingkat berat')),
                      DataCell(Text('> 27.0')),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
