import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  Map<String, dynamic>? weatherData;

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  Future<void> fetchWeatherData() async {
    final response = await http.get(Uri.parse(
        'https://www.meteosource.com/api/v1/free/point?place_id=kathmandu&sections=all&timezone=UTC&language=en&units=metric&key=ygp1tzo9dfsl29vzrkk3nx8acsepc10pdy34oh1l'));

    if (response.statusCode == 200) {
      setState(() {
        weatherData = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load weather data');
    }
  }

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
              if (weatherData != null) ...[
                Icon(Icons.wb_sunny, size: 100, color: Colors.yellow),
                SizedBox(height: 16),
                Text(
                  weatherData!['current']['summary'],
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  "Temperature: ${weatherData!['current']['temperature']}°C",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 10),
                Text(
                  'Location: Kathmandu',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 20),
                Text(
                  'Daily Weather Prediction:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 150,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: (weatherData!['daily']['data'] as List).length,
                    itemBuilder: (context, index) {
                      final dailyData = weatherData!['daily']['data'][index];
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
                    itemCount: (weatherData!['hourly']['data'] as List).length,
                    itemBuilder: (context, index) {
                      final hourlyData = weatherData!['hourly']['data'][index];
                      return _buildHourlyWeatherCard(hourlyData);
                    },
                  ),
                ),
              ],
              if (weatherData == null)
                Center(
                    child:
                        CircularProgressIndicator()), // Show a loading indicator while data is being fetched
            ],
          ),
        ),
      ),
    );
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
          Text(data['day'], style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          _getWeatherIcon(data['weather']),
          SizedBox(height: 5),
          Text(
              '${data['all_day']['temperature_min']}/${data['all_day']['temperature_max']} °C'),
        ],
      ),
    );
  }

  Widget _buildHourlyWeatherCard(Map<String, dynamic> data) {
    final hour = DateTime.parse(data['date']).toLocal().hour;
    final isDaytime = hour >= 6 && hour < 18;
    final period = hour < 12 ? 'AM' : 'PM';
    final displayHour =
        hour % 12 == 0 ? 12 : hour % 12; // Convert to 12-hour format

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
          Text('$displayHour $period',
              style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          _getWeatherIcon(data['weather']),
          SizedBox(height: 5),
          Text('${data['temperature']} °C'),
        ],
      ),
    );
  }

  Widget _getWeatherIcon(String condition) {
    final hour = DateTime.now().hour;
    final isDaytime = hour >= 6 && hour < 18;

    if (isDaytime) {
      switch (condition) {
        case 'overcast':
          return Icon(Icons.cloud, color: Colors.blue);
        case 'cloudy':
          return Icon(Icons.wb_cloudy, color: Colors.blue);
        case 'mostly_cloudy':
          return Icon(Icons.wb_cloudy, color: Colors.blue);
        case 'partly_sunny':
          return Icon(Icons.wb_sunny, color: Colors.yellow);
        case 'mostly_sunny':
          return Icon(Icons.wb_sunny, color: Colors.yellow);
        case 'partly_clear':
          return Icon(Icons.wb_sunny, color: Colors.yellow);
        case 'light_rain':
          return Icon(Icons.grain);
        default:
          return Icon(Icons.wb_sunny, color: Colors.yellow);
      }
    } else {
      return Icon(Icons.nightlight_round);
    }
  }
}

void main() {
  runApp(MaterialApp(
    home: WeatherPage(),
  ));
}
