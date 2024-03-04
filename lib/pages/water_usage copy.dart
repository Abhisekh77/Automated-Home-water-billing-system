import 'package:flutter/material.dart';

class WaterMeter123 extends StatelessWidget {
  final int previousUnit;
  final int todayUnit;

  const WaterMeter123(
      {Key? key, required this.previousUnit, required this.todayUnit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Calculate total units and total price
    int totalUnits = todayUnit - previousUnit;
    int totalPrice = totalUnits * 5;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Water Meter",
          style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Image.asset('assets/water_meter.png'),
            // Text("Previous Unit: $previousUnit"),
            // Text("Today Unit: $todayUnit"),
            // Text("Total Units: $totalUnits"),
            // Text("Total Price: Rs. $totalPrice"),
            SizedBox(height: 20),
            _buildPriceTable(previousUnit, todayUnit, totalUnits, totalPrice),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceTable(
      int previousUnit, int todayUnit, int totalUnits, int totalPrice) {
    return DataTable(
      columns: const <DataColumn>[
        DataColumn(
            label: Text(
          'Description',
          style: TextStyle(
              color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold),
        )),
        DataColumn(
            label: Text(
          'Value',
          style: TextStyle(
              color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold),
        )),
      ],
      rows: <DataRow>[
        DataRow(
          cells: <DataCell>[
            DataCell(Text(
              'Previous Unit',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            )),
            DataCell(Text(previousUnit.toString())),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text(
              'Today Unit',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            )),
            DataCell(Text(todayUnit.toString())),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text(
              'Total Units',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            )),
            DataCell(Text(totalUnits.toString())),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text(
              'Total Price',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            )),
            DataCell(Text('Rs. $totalPrice')),
          ],
        ),
      ],
    );
  }
}
