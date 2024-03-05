import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class WaterTank extends StatefulWidget {
  const WaterTank({Key? key}) : super(key: key);

  @override
  State<WaterTank> createState() => _WaterTankState();
}

class _WaterTankState extends State<WaterTank> {
  late List<WaterTankData> waterTankDataList;

  @override
  void initState() {
    super.initState();
    waterTankDataList = [];
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://majorproject-git-main-alex5748s-projects.vercel.app/get-data'));

    if (response.statusCode == 200) {
      print(response.body); // Debug print statement
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        waterTankDataList =
            data.map((item) => WaterTankData.fromJson(item)).toList();
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Water Tank'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              Image.asset(
                "assets/rainwatertank.jpg",
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20),
              SizedBox(height: 40),
              Text("Water Tank Data"),
              SizedBox(height: 20),
              Container(
                height: 200,
                width: 350,
                decoration: BoxDecoration(
                  color: Colors.blueGrey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DataTable(
                  columnSpacing: 20,
                  columns: [
                    DataColumn(label: Text("ID")),
                    DataColumn(label: Text("Tank")),
                    DataColumn(label: Text("Available water (Liters)")),
                  ],
                  rows: [
                    DataRow(cells: [
                      DataCell(Text('1')),
                      DataCell(Text('Rain Water')),
                      DataCell(Text(
                        waterTankDataList.isNotEmpty
                            ? (waterTankDataList
                                        .firstWhere((data) => data.tank == 'A',
                                            orElse: () => WaterTankData(
                                                id: '1',
                                                tank: '',
                                                waterLevelOfRainTank: 0,
                                                waterLevelNormalTank: 0))
                                        .waterLevelOfRainTank *
                                    0.19)
                                .toStringAsFixed(2)
                            : '',
                      )),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('2')),
                      DataCell(Text('Normal Water')),
                      DataCell(Text(
                        waterTankDataList.isNotEmpty
                            ? (waterTankDataList
                                        .firstWhere((data) => data.tank == 'B',
                                            orElse: () => WaterTankData(
                                                id: '2',
                                                tank: '',
                                                waterLevelOfRainTank: 0,
                                                waterLevelNormalTank: 0))
                                        .waterLevelNormalTank *
                                    0.19)
                                .toStringAsFixed(2)
                            : '',
                      )),
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WaterTankData {
  final String id;
  final String tank;
  final int waterLevelOfRainTank;
  final int waterLevelNormalTank;

  WaterTankData({
    required this.id,
    required this.tank,
    required this.waterLevelOfRainTank,
    required this.waterLevelNormalTank,
  });

  factory WaterTankData.fromJson(Map<String, dynamic> json) {
    return WaterTankData(
      id: json['_id'],
      tank: 'A', // Assuming tank A is associated with 'Water level rain tank'
      waterLevelOfRainTank: json['Water level rain tank'],
      waterLevelNormalTank: json['Water level of normal tank'],
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: WaterTank(),
  ));
}
