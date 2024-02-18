import 'package:flutter/material.dart';

import '../widgets/drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final days = 30;
    final String name = "Abhi";
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Center(
            child: Text(
              "Weather Prediction and Watermeter",
              style: TextStyle(color: Colors.purple),
            ),
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(
                20.0), //mobile ko 4 kuna ma tassekothiyo,side side ko hatako ani
            child: Column(
              children: [
                Container(
                  child: Text(
                      " Weather forecast typically includes information about the expected weather conditions for a specific location and time frame. It covers various elements such as temperature, precipitation, humidity, wind speed, and atmospheric pressure. The forecast is usually provided for different periods, such as the current day, the next few days, or even the upcoming week. weather forecast typically includes information about the expected weather conditions for a specific location and time frame. It covers various elements such as temperature, precipitation, humidity, wind speed, and atmospheric pressure. The forecast is usually provided for different periods, such as the current day, the next few days, or even the upcoming week."),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  child: Text(
                      "Temperature: The predicted high and low temperatures for the day or week. It is usually given in degrees Celsius or Fahrenheit."),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  child: Text(
                      "Humidity: The amount of moisture in the air, expressed as a percentage."),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  child: Text(
                      "Wind Speed: The expected speed of the wind, often given in miles per hour or kilometers per hour."),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  child: Text(
                      "Weather Conditions: A summary of the overall weather for the day, such as sunny, partly cloudy,cloudy, showers,thunderstorms,etc."),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(child: Image.asset("assets/sunnyicon.png")),
                SizedBox(
                  height: 3.0,
                ),
                Text(
                    "Sunny in a weather forecast describes a condition where the sky is mostly clear, and the sun is shining brightly. When the weather is sunny, there are few or no clouds in the sky, and the sun's rays are visible and illuminating the surroundings."),
                // stack is here used to write paragraph above picture
                // Stack(
                //   children: [
                //     Image.asset("assets/back_image.jpg"),
                //     Container(
                //       child: Text(
                //         "My name is Abhisekh Khanal, and I am currently in the seventh semester of my Bachelor's in Electronics Communication and Information Engineering. I wanted to share a bit more about myself and my passions.First and foremost, I must say that I absolutely love studying. The world of electronics and communication has always fascinated me. From the very beginning of my academic journey, I knew that this field was the right fit for me. I find joy in exploring the intricacies of electronic circuits, understanding communication protocols, and delving into the realm of information technology. Every new concept I learn feels like unraveling a fascinating mystery, and this excitement drives me to keep learning more.Throughout my time in college, I have actively engaged in my studies. I participate in class discussions, collaborate with classmates on projects, and seek guidance from my professors whenever I face challenges.I believe that asking questions and seeking clarification is crucial to deepening one's knowledge, and I am never hesitant to do so. It fills me with satisfaction to see my hard work pay off in the form of good grades and positive feedback from my instructors.But as much as I love my studies, cricket is my ultimate source of entertainment and joy. I can't imagine a life without the sport. Cricket has been a part of my life for as long as I can remember.",
                //         style: TextStyle(color: Colors.white),
                //       ),
                //     ),
                //   ],
                // ),

                SizedBox(
                  height: 10.0,
                ),
                Container(child: Image.asset("assets/cloud.jpeg")),
                SizedBox(
                  height: 3.0,
                ),
                Text(
                    "A cloudy weather forecast describes a condition where the sky is covered with clouds, and the sun may be partially or completely obscured. Clouds are formed when water vapor in the air condenses into tiny water droplets or ice crystals due to cooling or rising air. The type and amount of clouds in the sky can vary, and each type of cloud can have different implications for the weather."),
                SizedBox(
                  height: 10.0,
                ),
                Container(child: Image.asset("assets/rainy.jpg")),
                Text(
                    "A rainy weather forecast describes a condition where precipitation, specifically rain, is expected or occurring. Rain is one of the most common forms of precipitation, and it is caused by the condensation of water vapor in the atmosphere into droplets that become heavy enough to fall to the ground."),

                SizedBox(
                  height: 10.0,
                ),
                Container(child: Image.asset("assets/water_meter.png")),
                SizedBox(
                  height: 3.0,
                ),
                Text(
                    "A water meter is a device used to measure the volume of water that flows through a pipe or water supply system. It is commonly installed in residential, commercial, and industrial properties to monitor water consumption accurately and help in billing customers for their water usage."),
                SizedBox(
                  height: 4.0,
                ),
                Text(
                    "Water meters play a crucial role in water conservation efforts, as they provide an accurate measurement of water usage, allowing consumers to monitor their consumption and identify potential leaks or wastage. They also help utilities manage water resources efficiently and ensure fair billing for customers based on their actual usage."),

                // Container(
                //   child: Text(
                //     "I believe that asking questions and seeking clarification is crucial to deepening one's knowledge, and I am never hesitant to do so. It fills me with satisfaction to see my hard work pay off in the form of good grades and positive feedback from my instructors.But as much as I love my studies, cricket is my ultimate source of entertainment and joy. I can't imagine a life without the sport. Cricket has been a part of my life for as long as I can remember.",
                //     style: TextStyle(color: Colors.green),
                //   ),
                // ),
                // SizedBox(
                //   height: 10.0,
                // ),
              ],
            ),
          ),
        ),
      ),
      drawer: MyDrawer(),
      //  appbar ma aaune tripleline wala drawer vaneko
    );
  }
}
