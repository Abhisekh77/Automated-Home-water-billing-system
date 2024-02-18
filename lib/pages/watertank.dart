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
  int idCounterNormal = 0; // Counter for generating unique IDs for Normal Tank
  int idCounterRain = 0; // Counter for generating unique IDs for Rain Tank

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
              Text("Rain Water Tank"),
              Image.asset(
                "assets/rainwatertank.jpg",
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20),
              Container(
                height: 200,
                width: 350,
                decoration: BoxDecoration(
                  color: Colors.blueGrey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    DataTable(
                      columnSpacing: 20,
                      columns: [
                        DataColumn(label: Text("ID")),
                        DataColumn(label: Text("Tank")),
                        DataColumn(label: Text("Available water")),
                      ],
                      rows: waterTankDataList
                              ?.where((data) => data.tank == "A")
                              .take(1)
                              .map(
                            (data) {
                              idCounterRain++; // Increment ID counter for Rain Tank
                              print(
                                  "Rain Water Tank Data: $data"); // Debug print statement
                              return DataRow(cells: [
                                DataCell(Text('1')),
                                DataCell(Text(data.tank)),
                                DataCell(
                                    Text(data.waterLevelOfRainTank.toString())),
                              ]);
                            },
                          ).toList() ??
                          [],
                    ),
                  ],
                ),
              ),
              Text("Normal Water Tank"),
              SizedBox(height: 20),
              Container(
                height: 400,
                width: 350,
                decoration: BoxDecoration(
                  color: Colors.blueGrey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/watertank1.jpg",
                      width: 550,
                    ),
                    SizedBox(height: 10),
                    DataTable(
                      columnSpacing: 20,
                      columns: [
                        DataColumn(label: Text("ID")),
                        DataColumn(label: Text("Tank")),
                        DataColumn(label: Text("Available water")),
                      ],
                      rows: waterTankDataList
                              ?.where((data) => data.tank == "A")
                              .take(1)
                              .map(
                            (data) {
                              idCounterNormal++; // Increment ID counter for Normal Tank
                              return DataRow(cells: [
                                DataCell(Text('1')),
                                DataCell(Text('B')),
                                DataCell(
                                    Text(data.waterLevelNormalTank.toString())),
                              ]);
                            },
                          ).toList() ??
                          [],
                    ),
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
      tank: 'A', // Assuming tank A is associated with 'Water level normal tank'
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
