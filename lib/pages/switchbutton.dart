import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyButton extends StatefulWidget {
  const MyButton({Key? key}) : super(key: key);

  @override
  _MyButtonState createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  int switchButtonState = 0; // Default ON state for switch control
  int distributionButtonStateHouse1 = 1; // Default ON state for House 1
  int distributionButtonStateHouse2 = 0; // Default OFF state for House 2
  int distributionButtonStateHouse3 = 0; // Default OFF state for House 3

  void sendSwitchState(int state) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.1.102:3000/switch'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: '{"switchState": $state}',
      );
      if (response.statusCode == 200) {
        print('Switch state updated successfully');
        print('Response body: ${response.body}');
      } else {
        print('Failed to update switch state');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void sendDistributionState(int house, int state) async {
    try {
      final response = await http.post(
        Uri.parse('http://172.130.101.208:3000/distribution'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: '{"house": $house, "distributionState": $state}',
      );
      if (response.statusCode == 200) {
        print('Distribution state for House $house updated successfully');
        print('Response body: ${response.body}');
      } else {
        print('Failed to update distribution state for House $house');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Button",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Image.asset("assets/solenoid_valve.jpg", height: 150),
            SizedBox(height: 20),
            Text(
              "Switching Control",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.blue),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      switchButtonState = 1;
                      sendSwitchState(1);
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        switchButtonState == 1 ? Colors.green : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Container(
                    height: 70,
                    width: 100,
                    child: Center(
                      child: Text(
                        "ON",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 60,
                          color: switchButtonState == 1
                              ? Colors.white
                              : Colors.green,
                        ),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      switchButtonState = 0;
                      sendSwitchState(0);
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        switchButtonState == 0 ? Colors.red : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Container(
                    height: 70,
                    width: 130,
                    child: Center(
                      child: Text(
                        "OFF",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 60,
                          color: switchButtonState == 0
                              ? Colors.white
                              : Colors.red,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              "Distribution Control",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.blue),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "House 1",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: Colors.black),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      distributionButtonStateHouse1 = 1;
                      sendDistributionState(1, 1);
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: distributionButtonStateHouse1 == 1
                        ? Colors.green
                        : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Container(
                    height: 70,
                    width: 50,
                    child: Center(
                      child: Text(
                        "ON",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: distributionButtonStateHouse1 == 1
                              ? Colors.white
                              : Colors.green,
                        ),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      distributionButtonStateHouse1 = 0;
                      sendDistributionState(1, 0);
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: distributionButtonStateHouse1 == 0
                        ? Colors.red
                        : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Container(
                    height: 70,
                    width: 50,
                    child: Center(
                      child: Text(
                        "OFF",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: distributionButtonStateHouse1 == 0
                              ? Colors.white
                              : Colors.red,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "House 2",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: Colors.black),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      distributionButtonStateHouse2 = 1;
                      sendDistributionState(2, 1);
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: distributionButtonStateHouse2 == 1
                        ? Colors.green
                        : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Container(
                    height: 70,
                    width: 50,
                    child: Center(
                      child: Text(
                        "ON",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: distributionButtonStateHouse2 == 1
                              ? Colors.white
                              : Colors.green,
                        ),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      distributionButtonStateHouse2 = 0;
                      sendDistributionState(2, 0);
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: distributionButtonStateHouse2 == 0
                        ? Colors.red
                        : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Container(
                    height: 70,
                    width: 50,
                    child: Center(
                      child: Text(
                        "OFF",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: distributionButtonStateHouse2 == 0
                              ? Colors.white
                              : Colors.red,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "House 3",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: Colors.black),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      distributionButtonStateHouse3 = 1;
                      sendDistributionState(3, 1);
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: distributionButtonStateHouse3 == 1
                        ? Colors.green
                        : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Container(
                    height: 70,
                    width: 50,
                    child: Center(
                      child: Text(
                        "ON",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: distributionButtonStateHouse3 == 1
                              ? Colors.white
                              : Colors.green,
                        ),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      distributionButtonStateHouse3 = 0;
                      sendDistributionState(3, 0);
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: distributionButtonStateHouse3 == 0
                        ? Colors.red
                        : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Container(
                    height: 70,
                    width: 50,
                    child: Center(
                      child: Text(
                        "OFF",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: distributionButtonStateHouse3 == 0
                              ? Colors.white
                              : Colors.red,
                        ),
                      ),
                    ),
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

void main() {
  runApp(MaterialApp(
    home: MyButton(),
  ));
}
