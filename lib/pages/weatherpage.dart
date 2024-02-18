import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:math';

class WeatherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Weather Page',
          style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.wb_sunny, size: 100, color: Colors.yellow),
              SizedBox(height: 16),
              Text(
                "Sunny",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text("Temperature: 30°C", style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              Text('Location: Kathmandu', style: TextStyle(fontSize: 18)),
              SizedBox(height: 20),
              Text(
                'Daily Weather Prediction:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount:
                      7, // Displaying 7 days of daily predictions (Sunday to Saturday)
                  itemBuilder: (context, index) {
                    final dailyData = _generateDailyWeatherData(index);
                    return _buildDailyWeatherCard(dailyData);
                  },
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Hourly Weather Prediction:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount:
                      24, // Displaying 4 hourly predictions (0 AM, 8 AM, 4 PM, 12 AM)
                  itemBuilder: (context, index) {
                    final hourlyData = _generateHourlyWeatherData(index);
                    return _buildHourlyWeatherCard(hourlyData);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Map<String, dynamic> _generateDailyWeatherData(int dayIndex) {
    final random = Random();
    final conditions = ['Sunny', 'Cloudy', 'Rainy'];
    final daysOfWeek = [
      "Sunday",
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday"
    ];

    return {
      "day": daysOfWeek[dayIndex],
      "condition": conditions[random.nextInt(conditions.length)],
      "temperature": "${random.nextInt(21) + 10}°C",
    };
  }

  Map<String, dynamic> _generateHourlyWeatherData(int hourIndex) {
    final random = Random();
    final conditions = ['Sunny', 'Cloudy', 'Rainy'];
    final hours = [
      0,
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9,
      10,
      11,
      12,
      13,
      14,
      15,
      16,
      17,
      18,
      19,
      20,
      21,
      22,
      23
    ];

    final hour = hours[hourIndex];
    final time = _getTimeIn12HourFormat(hour);

    return {
      "time": time,
      "condition": conditions[random.nextInt(conditions.length)],
      "temperature": "${random.nextInt(21) + 10}°C",
    };
  }

  String _getTimeIn12HourFormat(int hour) {
    if (hour == 0) return "12 AM";
    if (hour < 12) return "$hour AM";
    if (hour == 12) return "12 PM";
    return "${hour - 12} PM";
  }

  Widget _buildDailyWeatherCard(Map<String, dynamic> data) {
    return Container(
      width: 200,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(data['day']!, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          _getWeatherIcon(data['condition']!),
          SizedBox(height: 5),
          Text(data['temperature']!),
        ],
      ),
    );
  }

  Widget _buildHourlyWeatherCard(Map<String, dynamic> data) {
    return Container(
      width: 100,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(data['time']!, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          _getWeatherIcon(data['condition']!),
          SizedBox(height: 5),
          Text(data['temperature']!),
        ],
      ),
    );
  }

  Icon _getWeatherIcon(String condition) {
    switch (condition) {
      case 'Sunny':
        return Icon(
          Icons.wb_sunny,
          color: Colors.yellow,
          size: 60,
        );
      case 'Cloudy':
        return Icon(
          Icons.wb_cloudy,
          color: Colors.blue,
          size: 60,
        );
      case 'Rainy':
        return Icon(
          Icons.beach_access,
          color: Colors.blue,
          size: 60,
        );
      default:
        return Icon(
          Icons.wb_sunny,
          color: Colors.yellow,
          size: 60,
        );
    }
  }
}
