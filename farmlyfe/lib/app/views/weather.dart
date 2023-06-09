import 'package:farmlyfe/app/controllers/weather.dart';
import 'package:farmlyfe/app/widgets/bottombar.dart';
import 'package:farmlyfe/app/widgets/weather_header.dart';
import 'package:farmlyfe/app/widgets/weather_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WeatherView extends StatelessWidget {
  WeatherView({Key? key}) : super(key: key);

  // Controllers
  final WeatherController weatherController = Get.put(WeatherController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // WeatherHeader widget is the top bar
      appBar: WeatherHeader(),
      body: const SafeArea(
        child: WeatherList(),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
