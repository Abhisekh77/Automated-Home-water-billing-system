import 'package:flutter/material.dart';
import 'package:my_first_project/pages/home_page.dart';
import 'package:my_first_project/utils/routes.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Column(
      children: [
        Padding(
          // padding: const EdgeInsets.all(10.0),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Image.asset("assets/admin_page.png"),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "Welcome to Admin Page",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 25),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Enter Username",
                  labelText: "Username",
                ),
              ),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Enter password",
                  labelText: "Password",
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.blueAccent[700], // Set the primary color to red
                  ),
                  child: Text(
                    "Login",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ))
            ],
          ),
        )
      ],
    ));
  }
}
