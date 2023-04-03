import 'package:farmlyfe/app/apis/utils.dart';
import 'package:farmlyfe/app/apis/weather.dart';
import 'package:farmlyfe/app/controllers/weather.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

// WeatherDaily
class WeatherDaily extends StatelessWidget {
  WeatherDaily({
    super.key,
  });

  // Controllers
  final WeatherController weatherController = Get.find();

  // Services
  final WeatherAPI weatherAPI = WeatherAPI();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => weatherController.getLoading
          ? const WeatherDailySkeleton()
          : Container(
              height: 380,
              width: double.infinity,
              color: Theme.of(context).colorScheme.onInverseSurface,
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
                top: 20,
              ),
              child: SizedBox(
                height: 340,
                child: Row(
                  children: [
                    const WeatherDailyLabelSlip(),
                    Expanded(
                      child: Obx(
                        () => ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              weatherController.getWeatherDaily?.time.length,
                          itemBuilder: (context, index) {
                            // Values
                            final time =
                                weatherController.getWeatherDaily?.time[index];
                            final temperatureMax = weatherController
                                .getWeatherDaily?.temperature2MMax[index];
                            final temperatureMin = weatherController
                                .getWeatherDaily?.temperature2MMin[index];
                            final precipProbability = weatherController
                                .getWeatherDaily
                                ?.precipitationProbabilityMean[index];
                            final weathercode = weatherController
                                .getWeatherDaily?.weathercode[index];
                            final sunrise = weatherController
                                .getWeatherDaily?.sunrise[index];
                            final sunset = weatherController
                                .getWeatherDaily?.sunset[index];

                            // Units
                            final temperatureMaxUnit = weatherController
                                .getWeatherDailyUnits?.temperature2MMax;
                            final temperatureMinUnit = weatherController
                                .getWeatherDailyUnits?.temperature2MMax;
                            final precipProbabilityUnit = weatherController
                                .getWeatherDailyUnits
                                ?.precipitationProbabilityMean;

                            return WeatherDailySlip(
                              time: time,
                              weathercode: weathercode,
                              temperatureMax: temperatureMax,
                              temperatureMaxUnit: temperatureMaxUnit,
                              temperatureMin: temperatureMin,
                              temperatureMinUnit: temperatureMinUnit,
                              precipProbability: precipProbability,
                              precipProbabilityUnit: precipProbabilityUnit,
                              sunrise: sunrise,
                              sunset: sunset,
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

// WeatherDaily Label Slip
class WeatherDailyLabelSlip extends StatelessWidget {
  const WeatherDailyLabelSlip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            height: 40,
            width: 100,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Daily',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.left,
              ),
            ),
          ),
          SizedBox(
            height: 40,
            width: 100,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Temperature Max',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ),
          SizedBox(
            height: 40,
            width: 100,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Temperature Min',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ),
          const SizedBox(
            height: 40,
            width: 100,
          ),
          const SizedBox(
            height: 40,
            width: 100,
          ),
          SizedBox(
            height: 40,
            width: 100,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Precipitation',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ),
          SizedBox(
            height: 40,
            width: 100,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Sunrise',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ),
          SizedBox(
            height: 40,
            width: 100,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Sunset',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// WeatherDaily Slip
class WeatherDailySlip extends StatelessWidget {
  WeatherDailySlip({
    super.key,
    required this.time,
    required this.weathercode,
    required this.temperatureMax,
    required this.temperatureMaxUnit,
    required this.temperatureMin,
    required this.temperatureMinUnit,
    required this.precipProbability,
    required this.precipProbabilityUnit,
    required this.sunrise,
    required this.sunset,
  });

  final DateTime? time;
  final int? weathercode;
  final double? temperatureMax;
  final String? temperatureMaxUnit;
  final double? temperatureMin;
  final String? temperatureMinUnit;
  final int? precipProbability;
  final String? precipProbabilityUnit;
  final DateTime? sunrise;
  final DateTime? sunset;

  // Services
  final WeatherAPI weatherAPI = WeatherAPI();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          SizedBox(
            height: 40,
            width: 80,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                dateTimeToDateShort(time) as String,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
          SizedBox(
            height: 40,
            width: 80,
            child: Align(
              alignment: Alignment.center,
              child: RichText(
                text: TextSpan(
                  text: '${temperatureMax?.toStringAsFixed(1)}',
                  style: Theme.of(context).textTheme.bodyMedium,
                  children: [
                    TextSpan(
                      text: '$temperatureMaxUnit',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 40,
            width: 80,
            child: Align(
              alignment: Alignment.center,
              child: RichText(
                text: TextSpan(
                  text: '${temperatureMin?.toStringAsFixed(1)}',
                  style: Theme.of(context).textTheme.bodyMedium,
                  children: [
                    TextSpan(
                      text: '$temperatureMinUnit',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 40,
            width: 80,
            child: Align(
              alignment: Alignment.center,
              child: Image.asset(
                weatherAPI.getWeatherIcon(weathercode!),
                height: 40,
                width: 40,
              ),
            ),
          ),
          SizedBox(
            height: 40,
            width: 80,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                weatherAPI.getWeatherDescription(weathercode!),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
          SizedBox(
            height: 40,
            width: 80,
            child: Align(
              alignment: Alignment.center,
              child: RichText(
                text: TextSpan(
                  text: '${precipProbability?.toStringAsFixed(1)}',
                  style: Theme.of(context).textTheme.bodyMedium,
                  children: [
                    TextSpan(
                      text: '$precipProbabilityUnit',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 40,
            width: 80,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                dateTimeToTime(sunrise) as String,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
          SizedBox(
            height: 40,
            width: 80,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                dateTimeToTime(sunset) as String,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// WeatherDaily skeleton with Shimmer
class WeatherDailySkeleton extends StatelessWidget {
  const WeatherDailySkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 380,
      width: double.infinity,
      padding: const EdgeInsets.only(
        left: 15,
        right: 15,
        top: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Daily',
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.left,
          ),
          SizedBox(
            height: 340,
            child: Shimmer.fromColors(
              baseColor:
                  Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
              highlightColor:
                  Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          height: 20,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        Container(
                          height: 20,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        Container(
                          height: 20,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                          width: 100,
                        ),
                        const SizedBox(
                          height: 40,
                          width: 100,
                        ),
                        Container(
                          height: 20,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        Container(
                          height: 20,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        Container(
                          height: 20,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 7,
                      itemBuilder: (__, _) {
                        return Container(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                height: 20,
                                width: 80,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              Container(
                                height: 20,
                                width: 80,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              Container(
                                height: 20,
                                width: 80,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              Container(
                                height: 20,
                                width: 80,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              Container(
                                height: 20,
                                width: 80,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              Container(
                                height: 20,
                                width: 80,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              Container(
                                height: 20,
                                width: 80,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
