import 'package:flutter/material.dart';
import 'package:my_first_project/pages/login_page.dart';
import 'package:my_first_project/pages/meterrealtime.dart';
import 'package:my_first_project/pages/watertank.dart';
import '../pages/admin.dart';

import '../pages/weatherrealtime.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    // const String imagePath = "user.png";
    return ClipRRect(
      borderRadius: BorderRadius.vertical(
          top: Radius.circular(20), bottom: Radius.circular(20)),
      child: Drawer(
        backgroundColor: Colors.white,
        width: 250,
        child: Container(
          color: Colors.white,
          child: ListView(
            children: [
              DrawerHeader(
                padding: EdgeInsets.zero,
                child: UserAccountsDrawerHeader(
                  margin: EdgeInsets.zero,
                  accountName: Text(
                    'Ram Rana',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  accountEmail: Text(
                    "ramrana50@gmail.com",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  currentAccountPicture: CircleAvatar(
                    radius: 90,
                    backgroundImage: AssetImage("assets/user.png"),
                  ),
                ),
              ),

              // to add icons like home.....
              ListTile(
                leading: Icon(Icons.home, color: Colors.black),
                title: Text("Home Page", style: TextStyle(color: Colors.black)),
              ),

              ListTile(
                leading:
                    Icon(Icons.supervised_user_circle, color: Colors.black),
                title: Text("User Page", style: TextStyle(color: Colors.black)),
              ),

              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AdminPage()),
                  );
                },
                child: ListTile(
                  leading:
                      Icon(Icons.admin_panel_settings, color: Colors.black),
                  title:
                      Text("Admin Page", style: TextStyle(color: Colors.black)),
                ),
              ),

              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WaterTank()),
                  );
                },
                child: ListTile(
                  leading:
                      Icon(Icons.admin_panel_settings, color: Colors.black),
                  title:
                      Text("WaterTank", style: TextStyle(color: Colors.black)),
                ),
              ),

              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WeatherPage()),
                  );
                },
                child: ListTile(
                  leading: Icon(Icons.wb_sunny, color: Colors.black),
                  title: Text("Weather", style: TextStyle(color: Colors.black)),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WaterMeter123()),
                  );
                },
                child: ListTile(
                  leading: Icon(Icons.water, color: Colors.black),
                  title:
                      Text("Watermeter", style: TextStyle(color: Colors.black)),
                ),
              ),
              // ListTile(
              //   leading: Icon(Icons.verified_user, color: Colors.black),
              //   title:
              //       Text("My Profile", style: TextStyle(color: Colors.black)),
              // ),
              // ListTile(
              //   leading: Icon(Icons.search, color: Colors.black),
              //   title:
              //       Text("Search here", style: TextStyle(color: Colors.black)),
              // ),
              // ListTile(
              //   leading: Icon(Icons.email, color: Colors.black),
              //   title: Text("Email me", style: TextStyle(color: Colors.black)),
              // ),

              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: ListTile(
                  leading: Icon(Icons.logout, color: Colors.black),
                  title: Text("Logout", style: TextStyle(color: Colors.black)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
