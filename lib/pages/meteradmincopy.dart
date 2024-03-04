import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WaterMeter123 extends StatefulWidget {
  @override
  _WaterMeterState createState() => _WaterMeterState();
}

class _WaterMeterState extends State<WaterMeter123> {
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
    try {
      final response = await http.get(Uri.parse(
          'https://majorproject-git-main-alex5748s-projects.vercel.app/get-data123'));
      final responseData = json.decode(response.body) as List<dynamic>;
      if (responseData.isNotEmpty) {
        final previousFlowRate = responseData[0]['total_flow'] as int;
        final todayFlowRate = responseData[1]['total_flow'] as int;

        previousUnit = previousFlowRate ~/ 20;
        todayUnit = todayFlowRate ~/ 20;
        totalUnits = todayUnit - previousUnit;
        totalPrice = totalUnits * 5;

        setState(() {
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        isLoading = false;
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
              child: CircularProgressIndicator(),
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
    home: WaterMeter123(),
  ));
}
