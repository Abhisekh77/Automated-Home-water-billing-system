import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyButton extends StatefulWidget {
  const MyButton({Key? key}) : super(key: key);

  @override
  _MyButtonState createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  String selectedButton = '';

  void sendSwitchState(String state) async {
    try {
      final response = await http.post(
        Uri.parse(
            'http://172.130.101.208:3000/switch'), // Update with your IPv4 address
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: '{"switchState": "$state"}',
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
            Image.asset("assets/solenoid_valve.jpg"),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedButton = 'ON';

                      sendSwitchState('on');
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary:
                        selectedButton == 'ON' ? Colors.green : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Container(
                    height: 140,
                    width: 140,
                    child: Center(
                      child: Text(
                        "ON",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 80,
                          color: selectedButton == 'ON'
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
                      selectedButton = 'OFF';
                      sendSwitchState('off');
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary:
                        selectedButton == 'OFF' ? Colors.red : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Container(
                    height: 140,
                    width: 140,
                    child: Center(
                      child: Text(
                        "OF",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 80,
                          color: selectedButton == 'OFF'
                              ? Colors.white
                              : Colors.green,
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
