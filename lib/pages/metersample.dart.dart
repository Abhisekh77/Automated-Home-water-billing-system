import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WaterMeter1 extends StatefulWidget {
  @override
  _WaterMeterState createState() => _WaterMeterState();
}

class _WaterMeterState extends State<WaterMeter1> {
  late int previousUnit;
  late int todayUnit;
  late int totalUnits;
  late int totalPrice;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http
        .get(Uri.parse('https://watermeterbackend.vercel.app/api/bill'));
    final responseData = json.decode(response.body);
    final myData = responseData['myData'] as List<dynamic>;
    if (myData.isNotEmpty) {
      setState(() {
        previousUnit = myData[0]['PreviousUnit'];
        todayUnit = myData[0]['CurrentUnit'];
        totalUnits = myData[0]['TotalUnit'];
        totalPrice = myData[0]['TotalPrice'];
        isLoading = false; // Set loading to false when data is fetched
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Water Meter",
          style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
        ),
      ),
      body: isLoading
          ? Center(
              child:
                  CircularProgressIndicator(), // Display circular progress indicator while loading
            )
          : Center(
              child: Column(
                children: [
                  Image.asset('assets/water_meter.png'),
                  SizedBox(height: 20),
                  _buildPriceTable(
                      previousUnit, todayUnit, totalUnits, totalPrice),
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
          ),
        ),
        DataColumn(
          label: Text(
            'Value',
            style: TextStyle(
                color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ],
      rows: <DataRow>[
        DataRow(
          cells: <DataCell>[
            DataCell(Text(
              'Today Unit',
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
              'Previous Unit',
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

void main() {
  runApp(MaterialApp(
    home: WaterMeter1(),
  ));
}
