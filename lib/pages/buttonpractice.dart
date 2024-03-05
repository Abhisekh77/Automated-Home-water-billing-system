import 'package:flutter/material.dart';

class MyButton123 extends StatefulWidget {
  const MyButton123({Key? key}) : super(key: key);

  @override
  _MyButtonState createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton123> {
  String selectedButton = ''; // 'ON' or 'OFF'

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Valve control",
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
            Text(
              "Switching Control",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.blue,
              ),
            ),
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
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.resolveWith<Color>((states) {
                      if (states.contains(MaterialState.pressed)) {
                        return Colors.green; // color when pressed
                      }
                      return selectedButton == 'ON'
                          ? Colors.green
                          : Colors.white; // default color
                    }),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  child: Container(
                    height: 150,
                    width: 120,
                    child: Center(
                      child: Text(
                        "ON",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 60,
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
                      print("123");
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.resolveWith<Color>((states) {
                      if (states.contains(MaterialState.pressed)) {
                        return Colors.green; // color when pressed
                      }
                      return selectedButton == 'OFF'
                          ? Colors.green
                          : Colors.white; // default color
                    }),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  child: Container(
                    height: 150,
                    width: 140,
                    child: Center(
                      child: Text(
                        "OFF",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 60,
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
