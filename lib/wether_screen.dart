import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:osofio/additionalInformation.dart';
import 'package:osofio/wetherForecast.dart';
import 'package:osofio/secretFile.dart';
import 'package:http/http.dart' as http;

class WetherScreen extends StatefulWidget {
  const WetherScreen({super.key});

  @override
  State<WetherScreen> createState() => _WetherScreenState();
}

class _WetherScreenState extends State<WetherScreen> {
  late Future<Map<String, dynamic>> weather = getCurrentWeather();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    weather = getCurrentWeather();
  }

  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      final response = await http.get(Uri.parse(API_key));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data; // Return weather data
      } else {
        throw "Failed to fetch weather data: ${response.statusCode}";
      }
    } catch (e) {
      throw "error: $e";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Wether App",
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                weather = getCurrentWeather();
              });
            },
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: FutureBuilder(
        future: weather,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }

          final data = snapshot.data!;

          final currentTemp = data['list'][0]['main']['temp'];
          final currentSky = data['list'][0]['weather'][0]['main'];
          final currentPressure = data['list'][0]['main']['pressure'];
          final currentHumidity = data['list'][0]['main']['humidity'];
          final currentWind = data['list'][0]['wind']['speed'];

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Main Card
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Text(
                                '$currentTemp K',
                                style: const TextStyle(
                                  fontSize: 36,
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Icon(
                                currentSky == 'Clouds' || currentSky == 'Rain'
                                    ? Icons.cloud
                                    : Icons.sunny,
                                size: 48,
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Text(
                                '$currentSky',
                                style: const TextStyle(fontSize: 24),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                //Weather forecast
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Weather forecast",
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                SizedBox(
                  height: 125,
                  child: ListView.builder(
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return WeatherForecastCard(
                        icon: data['list'][index + 1]['weather'][0]['main'] ==
                                    'Clouds' ||
                                data['list'][index + 1]['weather'][0]['main'] ==
                                    'Rain'
                            ? Icons.cloud
                            : Icons.sunny,
                        lable:
                            data['list'][index + 1]['main']['temp'].toString(),
                        time: DateFormat.j().format(DateTime.parse(
                            (data['list'][index + 1]['dt_txt']))),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),

                //additional informatation
                const Text(
                  "Additional Information",
                  style: TextStyle(fontSize: 24),
                ),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AdditionalInformationCard(
                        data: "Humidity",
                        temp: currentHumidity.toString(),
                        icon: Icons.water_drop,
                      ),
                      AdditionalInformationCard(
                          data: "Wind Speed",
                          temp: currentWind.toString(),
                          icon: Icons.cloud),
                      AdditionalInformationCard(
                        data: "Pressure",
                        temp: currentPressure.toString(),
                        icon: Icons.beach_access,
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
