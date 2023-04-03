import 'package:farmlyfe/app/apis/utils.dart';
import 'package:farmlyfe/app/apis/weather.dart';
import 'package:farmlyfe/app/controllers/weather.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

// WeatherHeader
class WeatherHeader extends StatelessWidget implements PreferredSizeWidget {
  WeatherHeader({
    super.key,
  });

  // Controllers
  final WeatherController weatherController = Get.put(WeatherController());

  // Services
  final WeatherAPI weatherAPI = WeatherAPI();

  @override
  Size get preferredSize => const Size.fromHeight(310);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 2,
      centerTitle: true,
      toolbarHeight: preferredSize.height,
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      shadowColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20),
        ),
      ),
      titleSpacing: 0,
      title: Obx(
        () => weatherController.getLoading
            ? const WeatherHeaderSkeleton()
            : Container(
                height: 310,
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Location and date
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          weatherController.getAddress.subLocality!,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        // Date
                        Text(
                          dateTimeToDate(weatherController.getDateTime)
                              as String,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),

                    // Current weather
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Weather icon
                        Image.asset(
                          weatherAPI.getWeatherIcon(
                            weatherController.getWeatherHourly?.weathercode[0]
                                as int,
                          ),
                          height: 80,
                          width: 80,
                        ),
                        const SizedBox(width: 10),
                        // Temperature and weather description
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Temperature
                            Text(
                              '${weatherController.getWeatherHourly?.temperature2M[0].toStringAsFixed(0)}°',
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            // Weather description
                            Text(
                              weatherAPI.getWeatherDescription(
                                weatherController
                                    .getWeatherHourly?.weathercode[0] as int,
                              ),
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ],
                    ),

                    // Current weather details
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Card 1
                        WeatherHeaderDetailsCard(
                          label: 'Humidity',
                          value: weatherController
                              .getWeatherHourly?.relativehumidity2M[0]
                              .toStringAsFixed(0) as String,
                          unit: weatherController.getWeatherHourlyUnits
                              ?.relativehumidity2M as String,
                        ),
                        // Card 2
                        WeatherHeaderDetailsCard(
                          label: 'Cloud Cover',
                          value: weatherController
                              .getWeatherHourly?.cloudcover[0]
                              .toStringAsFixed(0) as String,
                          unit: weatherController
                              .getWeatherHourlyUnits?.cloudcover as String,
                        ),
                        // Card 3
                        WeatherHeaderDetailsCard(
                          label: 'Soil Moisture',
                          value: weatherController
                              .getWeatherHourly?.soilMoisture39Cm[0]
                              .toStringAsFixed(0) as String,
                          unit: weatherController
                              .getWeatherHourlyUnits?.soilMoisture39Cm
                              .toString() as String,
                        ),
                        // Card 4
                        WeatherHeaderDetailsCard(
                          label: 'Soil Temp',
                          value: weatherController
                              .getWeatherHourly?.soilTemperature6Cm[0]
                              .toStringAsFixed(0) as String,
                          unit: weatherController
                              .getWeatherHourlyUnits?.soilTemperature6Cm
                              .toString() as String,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      ),
      toolbarTextStyle: Theme.of(context).textTheme.bodyText2,
      titleTextStyle: Theme.of(context).textTheme.headline6,
    );
  }
}

// WeatherHeader Details Card
class WeatherHeaderDetailsCard extends StatelessWidget {
  final String label;
  final String value;
  final String unit;

  const WeatherHeaderDetailsCard(
      {Key? key, required this.label, required this.value, required this.unit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 80,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onInverseSurface,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
            spreadRadius: 0.5,
            blurRadius: 2,
            offset: const Offset(0, 4), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 30,
            child: Text(
              label,
              softWrap: true,
              overflow: TextOverflow.visible,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
          Text(
            value,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Text(
            unit,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ],
      ),
    );
  }
}

// Weather Header Skeleton with shimmer effect
class WeatherHeaderSkeleton extends StatelessWidget {
  const WeatherHeaderSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 310,
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        child: Shimmer.fromColors(
          baseColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
          highlightColor:
              Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 20,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(height: 10),
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
              Row(
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 20,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      const SizedBox(height: 10),
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
                ],
              ),
              // Row of four cards
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Card 1
                  Container(
                    height: 120,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  // Card 2
                  Container(
                    height: 120,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  // Card 3
                  Container(
                    height: 120,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  // Card 4
                  Container(
                    height: 120,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
