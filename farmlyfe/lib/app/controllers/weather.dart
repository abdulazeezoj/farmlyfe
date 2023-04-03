import 'package:farmlyfe/app/apis/weather.dart';
import 'package:farmlyfe/app/models/weather.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class WeatherController extends GetxController {
  // Observable variables
  final RxBool _isLoading = RxBool(true);
  final Rx<WeatherHourly?> _weatherHourly = Rx<WeatherHourly?>(null);
  final Rx<WeatherHourlyUnits?> _weatherHourlyUnits =
      Rx<WeatherHourlyUnits?>(null);
  final Rx<WeatherDaily?> _weatherDaily = Rx<WeatherDaily?>(null);
  final Rx<WeatherDailyUnits?> _weatherDailyUnits =
      Rx<WeatherDailyUnits?>(null);
  final RxString _timezone = RxString('');
  final Rx<DateTime> _datetime = DateTime.now().obs;
  final Rx<Location> _location = Location(
    latitude: 0.0,
    longitude: 0.0,
    timestamp: DateTime.now(),
  ).obs;
  final Rx<Placemark> _address = Placemark(
    name: 'Unknown',
    subLocality: 'Unknown',
    locality: 'Unknown',
    administrativeArea: 'Unknown',
    postalCode: 'Unknown',
    country: 'Unknown',
    isoCountryCode: 'Unknown',
    subAdministrativeArea: 'Unknown',
    subThoroughfare: 'Unknown',
    thoroughfare: 'Unknown',
  ).obs;

  // Getters

  // Get the loading state
  bool get getLoading => _isLoading.value;

  // Get the weather hourly
  WeatherHourly? get getWeatherHourly => _weatherHourly.value;

  // Get the weather hourly units
  WeatherHourlyUnits? get getWeatherHourlyUnits => _weatherHourlyUnits.value;

  // Get the weather daily
  WeatherDaily? get getWeatherDaily => _weatherDaily.value;

  // Get the weather daily units
  WeatherDailyUnits? get getWeatherDailyUnits => _weatherDailyUnits.value;

  // Get the timezone
  String get getTimezone => _timezone.value;

  // Get the date
  DateTime get getDateTime => _datetime.value;

  // Get the current location
  Location get getLocation => _location.value;

  // Get the current address
  Placemark get getAddress => _address.value;

  // Setters

  // Set the loading state
  void setIsLoading(bool isLoading) {
    _isLoading.value = isLoading;
  }

  // Set the weather hourly
  void setWeatherHourly(WeatherHourly weatherHourly) {
    _weatherHourly.value = weatherHourly;
  }

  // Set the weather hourly units
  void setWeatherHourlyUnits(WeatherHourlyUnits weatherHourlyUnits) {
    _weatherHourlyUnits.value = weatherHourlyUnits;
  }

  // Set the weather daily
  void setWeatherDaily(WeatherDaily weatherDaily) {
    _weatherDaily.value = weatherDaily;
  }

  // Set the weather daily units
  void setWeatherDailyUnits(WeatherDailyUnits weatherDailyUnits) {
    _weatherDailyUnits.value = weatherDailyUnits;
  }

  // Set the timezone
  void setTimezone(String timezone) {
    _timezone.value = timezone;
  }

  // Set the current location
  void setLocation(Location location) {
    _location.value = location;
  }

  // Set the current address
  void setAddress(Placemark placemark) {
    _address.value = placemark;
  }

  @override
  void onInit() {
    // Get the weather and address
    if (_isLoading.value) {
      // get the address
      fetchAddress();

      // get the weather
      fetchWeather();
    }

    super.onInit();
  }

  // function to get the current location
  fetchLocation() async {
    bool serviceEnabled;
    LocationPermission locationPermission;

    // check service
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    // return if service is not enabled
    if (!serviceEnabled) {
      return Future.error(
        'Location services are disabled.',
      );
    }

    // check permission
    locationPermission = await Geolocator.checkPermission();

    // request permission if permission is denied
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();

      // return if permission is denied
      if (locationPermission == LocationPermission.denied) {
        return Future.error(
          'Location permissions are denied',
        );
      }
    }

    // return if permission is denied forever
    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    // get and set current location
    await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    ).then((position) {
      setLocation(Location(
        latitude: position.latitude,
        longitude: position.longitude,
        timestamp: position.timestamp as DateTime,
      ));
    });
  }

  // function to get the current timezone
  fetchTimezone() async {
    // get the current timezone
    await FlutterNativeTimezone.getLocalTimezone().then((timezone) {
      setTimezone(timezone);
    });
  }

  // function to get the current address from the current location
  fetchAddress() async {
    // get the current location
    Location location = getLocation;

    // if location is valid then get the current address
    if (location.latitude != 0.0 && location.longitude != 0.0) {
      // get and set the current address
      await placemarkFromCoordinates(
        location.latitude,
        location.longitude,
      ).then((placemarks) {
        setAddress(Placemark(
          name: placemarks[0].name,
          subAdministrativeArea: placemarks[0].subAdministrativeArea,
          administrativeArea: placemarks[0].administrativeArea,
          country: placemarks[0].country,
          isoCountryCode: placemarks[0].isoCountryCode,
          postalCode: placemarks[0].postalCode,
          subLocality: placemarks[0].subLocality == ''
              ? placemarks[0].locality
              : placemarks[0].subLocality,
          locality: placemarks[0].locality,
          subThoroughfare: placemarks[0].subThoroughfare,
          thoroughfare: placemarks[0].thoroughfare,
        ));
      });
    } else {
      // else get the current location
      await fetchLocation();

      // get the current location
      location = getLocation;

      // get and set the current address
      await placemarkFromCoordinates(
        location.latitude,
        location.longitude,
      ).then((placemarks) {
        setAddress(Placemark(
          name: placemarks[0].name,
          subAdministrativeArea: placemarks[0].subAdministrativeArea,
          administrativeArea: placemarks[0].administrativeArea,
          country: placemarks[0].country,
          isoCountryCode: placemarks[0].isoCountryCode,
          postalCode: placemarks[0].postalCode,
          subLocality: placemarks[0].subLocality == ''
              ? placemarks[0].locality
              : placemarks[0].subLocality,
          locality: placemarks[0].locality,
          subThoroughfare: placemarks[0].subThoroughfare,
          thoroughfare: placemarks[0].thoroughfare,
        ));
      });
    }
  }

  // function to get the current weather from the current location
  fetchWeather() async {
    // get the current location
    Location location = getLocation;

    // get the current timezone
    String timezone = getTimezone;

    // if location and timezone is valid then get the current weather
    if (location.latitude != 0.0 &&
        location.longitude != 0.0 &&
        timezone != '') {
      // get and set the current weather
      await WeatherAPI()
          .getWeather(
        location.latitude,
        location.longitude,
        timezone,
      )
          .then((weather) {
        // Filter weather data
        weather = filterWeather(weather);

        // set the weather hourly
        setWeatherHourly(weather.hourly);

        // set the weather hourly unit
        setWeatherHourlyUnits(weather.hourlyUnits);
      
        // set the weather daily
        setWeatherDaily(weather.daily);

        // set the weather daily unit
        setWeatherDailyUnits(weather.dailyUnits);

        // set the loading state to false
        setIsLoading(false);
      });
    } else {
      // else get the current location
      await fetchLocation();

      // get the current timezone
      await fetchTimezone();

      // get the current location
      location = getLocation;

      // get the current timezone
      timezone = getTimezone;

      // get and set the current weather
      await WeatherAPI()
          .getWeather(
        location.latitude,
        location.longitude,
        timezone,
      )
          .then((weather) {
        // Filter weather data
        weather = filterWeather(weather);

        // set the weather hourly
        setWeatherHourly(weather.hourly);

        // set the weather hourly unit
        setWeatherHourlyUnits(weather.hourlyUnits);

        // set the weather daily
        setWeatherDaily(weather.daily);

        // set the weather daily unit
        setWeatherDailyUnits(weather.dailyUnits);

        // set the loading state to false
        setIsLoading(false);
      });
    }
  }

  // function to filter the weather data
  Weather filterWeather(Weather weather) {
    // Filter from current hour and above all the weather.hourly data
    for (int i = 0; i < weather.hourly.time.length; i++) {
      if (weather.hourly.time[i].hour >= DateTime.now().hour) {
        weather.hourly.time = weather.hourly.time.sublist(i);
        weather.hourly.temperature2M = weather.hourly.temperature2M.sublist(i);
        weather.hourly.relativehumidity2M =
            weather.hourly.relativehumidity2M.sublist(i);
        weather.hourly.cloudcover = weather.hourly.cloudcover.sublist(i);
        weather.hourly.precipitationProbability =
            weather.hourly.precipitationProbability.sublist(i);
        weather.hourly.weathercode = weather.hourly.weathercode.sublist(i);
        weather.hourly.soilTemperature6Cm =
            weather.hourly.soilTemperature6Cm.sublist(i);
        weather.hourly.soilMoisture39Cm =
            weather.hourly.soilMoisture39Cm.sublist(i);
        break;
      }
    }

    // Take the first 24 hours of weather.hourly data
    weather.hourly.time = weather.hourly.time.sublist(0, 24);
    weather.hourly.temperature2M = weather.hourly.temperature2M.sublist(0, 24);
    weather.hourly.relativehumidity2M =
        weather.hourly.relativehumidity2M.sublist(0, 24);
    weather.hourly.cloudcover = weather.hourly.cloudcover.sublist(0, 24);
    weather.hourly.precipitationProbability =
        weather.hourly.precipitationProbability.sublist(0, 24);
    weather.hourly.weathercode = weather.hourly.weathercode.sublist(0, 24);
    weather.hourly.soilTemperature6Cm =
        weather.hourly.soilTemperature6Cm.sublist(0, 24);
    weather.hourly.soilMoisture39Cm =
        weather.hourly.soilMoisture39Cm.sublist(0, 24);

    return weather;
  }
}
