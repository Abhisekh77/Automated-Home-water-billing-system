import 'package:flutter/material.dart';
import 'package:my_first_project/pages/admincopy.dart';
import 'package:my_first_project/pages/admin_login.dart';
import 'package:my_first_project/utils/routes.dart';
import 'package:my_first_project/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formkey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';

  // Add fixed username and password here
  static const String fixedUsername = '111111';
  static const String fixedPassword = '111111';

  moveToHome(BuildContext context) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: SingleChildScrollView(
            child: Form(
      key: _formkey,
      child: Column(
        children: [
          Image.asset(
            "assets/login_image.png",
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            "Welcome User",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10.0,
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a username';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _username = value!;
                  },
                ),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Enter Password",
                    labelText: "Password",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    } else if (value.length < 6) {
                      return "password length must exceed 6";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _password = value!;
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formkey.currentState?.validate() ?? false) {
                      _formkey.currentState?.save();

                      // Check if entered credentials match the fixed values
                      if (_username == fixedUsername &&
                          _password == fixedPassword) {
                        // Proceed to the home page or any other action you want here
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      } else {
                        // Display error message for incorrect credentials
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text("Invalid Username or Password"),
                            content: Text(
                                "Please enter valid username and password."),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("OK"),
                              ),
                            ],
                          ),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.blueAccent[700], // Set the primary color to red
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 17),
                  ),
                  // style: TextButton.styleFrom(minimumSize: Size(130, 40)),
                ),
                // SizedBox(
                //   height: 20,
                // ),
                // Text(
                //   "Admin Page",
                //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                // ),
                SizedBox(
                  height: 10,
                ),
                Text(
                    "-------------------------------OR------------------------------"),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AdminPage1()));
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AdminPage()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors
                          .blueAccent[700], // Set the primary color to red
                    ),
                    child: Text(
                      "Login to Admin",
                      style: TextStyle(fontSize: 17),
                    ))
              ],
            ),
          ),
        ],
      ),
    )));
  }
}
