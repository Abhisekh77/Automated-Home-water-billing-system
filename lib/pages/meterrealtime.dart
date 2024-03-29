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
  String errorMessage = '';

  // Default values
  String name = 'Hari Upadhaya';
  String houseNumber = '101';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse(
          'https://majorproject-git-main-alex5748s-projects.vercel.app/get-data123')); // Replace with your actual API URL
      final responseData = json.decode(response.body) as List<dynamic>;

      if (responseData.isNotEmpty) {
        final firstEntry = responseData.first;
        final todayTotalFlow = firstEntry['total_flow'] as int;

        // Calculate today and previous units
        final previousUnit = 33;
        final todayUnit = (todayTotalFlow / 20).ceil() +
            previousUnit; // ceil() to ensure rounding up
        final totalUnits = todayUnit - previousUnit;
        final totalPrice = totalUnits * 5; // Assuming the price per unit is 5

        setState(() {
          this.previousUnit = previousUnit;
          this.todayUnit = todayUnit;
          this.totalUnits = totalUnits;
          this.totalPrice = totalPrice;
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'No data available';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error fetching data: $e';
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
          : errorMessage.isNotEmpty
              ? Center(
                  child: Text(errorMessage),
                )
              : Center(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/water_meter.png',
                        height: 250,
                      ),
                      SizedBox(height: 10),
                      _buildPriceTable(name, houseNumber, previousUnit,
                          todayUnit, totalUnits, totalPrice),
                    ],
                  ),
                ),
    );
  }

  Widget _buildPriceTable(String name, String houseNumber, int previousUnit,
      int todayUnit, int totalUnits, int totalPrice) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 10),
          DataTable(
            columns: const <DataColumn>[
              DataColumn(
                label: Text(
                  'Description',
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'Value',
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
            rows: <DataRow>[
              DataRow(
                cells: <DataCell>[
                  DataCell(Text(
                    'Name',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )),
                  DataCell(Text(name)),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text(
                    'House Number',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )),
                  DataCell(Text(houseNumber)),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text(
                    "Today's Unit",
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
                    'Total',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )),
                  DataCell(Text('Rs. $totalPrice')),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: WaterMeter123(),
  ));
}
