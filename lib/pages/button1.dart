import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyButton123 extends StatefulWidget {
  const MyButton123({Key? key}) : super(key: key);

  @override
  _MyButtonState createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton123> {
  String buttonState = ''; // Button state received from Arduino

  void fetchButtonState() async {
    final response = await http.get(Uri.parse('http://192.168.1.102'));
    if (response.statusCode == 200) {
      setState(() {
        buttonState = response.body;
      });
    } else {
      throw Exception('Failed to load button state');
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
            Image.asset("assets/solenoid_valve.jpg"),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Send HTTP request to turn ON
                    http.get(Uri.parse('http://192.168.1.102?state=on'));
                    setState(() {
                      buttonState = '1';
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: buttonState == '1' ? Colors.green : Colors.white,
                    side: BorderSide(color: Colors.green, width: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Container(
                    height: 160,
                    width: 130,
                    child: Center(
                      child: Text(
                        "ON",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 80,
                          color:
                              buttonState == '1' ? Colors.white : Colors.green,
                        ),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Send HTTP request to turn OFF
                    http.get(Uri.parse('http://192.168.1.102?state=off'));
                    setState(() {
                      buttonState = '0';
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: buttonState == '0' ? Colors.green : Colors.white,
                    side: BorderSide(color: Colors.green, width: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Container(
                    height: 160,
                    width: 130,
                    child: Center(
                      child: Text(
                        "OF",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 80,
                          color:
                              buttonState == '0' ? Colors.white : Colors.green,
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

  @override
  void initState() {
    fetchButtonState(); // Fetch initial button state when the widget initializes
    super.initState();
  }
}
