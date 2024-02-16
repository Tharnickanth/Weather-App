// ignore_for_file: file_names

import 'package:flutter/material.dart';

class WeatherForecastCard extends StatelessWidget {
  final IconData icon;
  final String time;
  final String lable;
  const WeatherForecastCard({
    super.key,
    required this.icon,
    required this.time,
    required this.lable,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                time,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Icon(
                icon,
                size: 36,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(lable)
            ],
          ),
        ),
      ),
    );
  }
}
