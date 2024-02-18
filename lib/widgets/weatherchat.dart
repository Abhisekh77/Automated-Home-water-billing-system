import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Weather123 extends StatefulWidget {
  @override
  _Weather123State createState() => _Weather123State();
}

class _Weather123State extends State<Weather123> {
  late Future<Weather> futureWeather;
  late Future<List<HourlyWeather>> futureHourlyWeather;

  @override
  void initState() {
    super.initState();
    futureWeather = WeatherService().getWeather();
    futureHourlyWeather = _loadHourlyWeather();
  }

  Future<List<HourlyWeather>> _loadHourlyWeather() async {
    try {
      return await WeatherService().getHourlyWeather();
    } catch (e) {
      print('Failed to load hourly weather data: $e');
      return []; // Return an empty list as a default value
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Page'),
        backgroundColor: Colors.purple,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Center(
              child: FutureBuilder<Weather>(
                future: futureWeather,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        Text(
                          snapshot.data!.summary,
                          style: TextStyle(fontSize: 24),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Temperature: ${snapshot.data!.temperature}°C',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Wind Speed: ${snapshot.data!.windSpeed} m/s ${snapshot.data!.windDirection}',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Cloud Cover: ${snapshot.data!.cloudCover}%',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Hourly Weather Prediction:',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 150,
                          child: FutureBuilder<List<HourlyWeather>>(
                            future: futureHourlyWeather,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    final hourlyData = snapshot.data![index];
                                    return _buildHourlyWeatherCard(hourlyData);
                                  },
                                );
                              } else if (snapshot.hasError) {
                                return Text("${snapshot.error}");
                              }
                              return CircularProgressIndicator();
                            },
                          ),
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return CircularProgressIndicator();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHourlyWeatherCard(HourlyWeather data) {
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
          Text(data.time, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          _getWeatherIcon(data.weather),
          SizedBox(height: 5),
          Text('${data.temperature}°C'),
        ],
      ),
    );
  }

  Icon _getWeatherIcon(String condition) {
    switch (condition) {
      case 'partly_clear':
        return Icon(
          Icons.wb_sunny,
          color: Colors.yellow,
          size: 60,
        );
      case 'mostly_cloudy':
        return Icon(
          Icons.wb_cloudy,
          color: Colors.blue,
          size: 60,
        );
      case 'partly_sunny':
        return Icon(
          Icons.wb_sunny_rounded,
          color: Colors.orange,
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

class Weather {
  final String summary;
  final double temperature;
  final double windSpeed;
  final String windDirection;
  final int cloudCover;

  Weather({
    required this.summary,
    required this.temperature,
    required this.windSpeed,
    required this.windDirection,
    required this.cloudCover,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      summary: json['summary'],
      temperature: json['temperature'],
      windSpeed: json['wind']['speed'],
      windDirection: json['wind']['dir'],
      cloudCover: json['cloud_cover'],
    );
  }
}

class HourlyWeather {
  final String time;
  final String weather;
  final double temperature;

  HourlyWeather({
    required this.time,
    required this.weather,
    required this.temperature,
  });

  factory HourlyWeather.fromJson(Map<String, dynamic> json) {
    return HourlyWeather(
      time: json['date'],
      weather: json['weather'],
      temperature: json['temperature'],
    );
  }
}

class WeatherService {
  final String apiUrl =
      'https://www.meteosource.com/api/v1/free/point?place_id=kathmandu&sections=all&timezone=UTC&language=en&units=metric&key=ygp1tzo9dfsl29vzrkk3nx8acsepc10pdy34oh1l';

  Future<Weather> getWeather() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final currentData = data['current'];

      return Weather.fromJson(currentData);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<List<HourlyWeather>> getHourlyWeather() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> hourlyData = data['hourly']['data'];

      return hourlyData.map((e) => HourlyWeather.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load hourly weather data');
    }
  }
}

void main() {
  runApp(MaterialApp(
    home: Weather123(),
  ));
}
