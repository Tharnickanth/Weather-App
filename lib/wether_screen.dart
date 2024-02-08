import 'dart:ui';

import 'package:flutter/material.dart';

class Wether_Screen extends StatelessWidget {
  const Wether_Screen({super.key});

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
              print("refresh");
            },
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: Padding(
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
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            "300K",
                            style: TextStyle(
                              fontSize: 36,
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Icon(
                            Icons.cloud,
                            size: 48,
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            "Rain",
                            style: TextStyle(fontSize: 24),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            //Weather forecast
            SizedBox(
              height: 20,
            ),
            Text(
              "Weather forecast",
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  WeatherForecastCard(),
                  WeatherForecastCard(),
                  WeatherForecastCard(),
                  WeatherForecastCard(),
                  WeatherForecastCard(),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),

            //additional informatation
            Text(
              "Additional Information",
              style: TextStyle(fontSize: 24),
            ),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AdditionalInformationCard(),
                  AdditionalInformationCard(),
                  AdditionalInformationCard()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class WeatherForecastCard extends StatelessWidget {
  const WeatherForecastCard({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                "09.00",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 8,
              ),
              Icon(
                Icons.cloud,
                size: 36,
              ),
              SizedBox(
                height: 8,
              ),
              Text("307.2")
            ],
          ),
        ),
      ),
    );
  }
}

class AdditionalInformationCard extends StatelessWidget {
  const AdditionalInformationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 120,
      child: Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Icon(
                Icons.air,
                size: 32,
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "data",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "95",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
