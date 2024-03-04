import 'package:flutter/material.dart';

class MyButton123 extends StatefulWidget {
  const MyButton123({Key? key}) : super(key: key);

  @override
  _MyButtonState createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton123> {
  String selectedButton = ''; // 'ON' or 'OF'

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Button123",
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
            Image.asset("assets/solenoid_valve.jpg"),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedButton = 'ON';
                      print("ABC");
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
                      selectedButton = 'OF';
                      print("123");
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary:
                        selectedButton == 'OF' ? Colors.green : Colors.white,
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
                          color: selectedButton == 'OF'
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
