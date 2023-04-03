import 'package:farmlyfe/app/models/weather.dart';
import 'package:http/http.dart' as http;

class WeatherAPI {
  // Process the JSON data
  Future<Weather> getWeather(lat, lon, tmz) async {
    try {
      // Make the API call
      var response = await http.get(Uri.parse(weatherURL(lat, lon, tmz)));

      if (response.statusCode == 200) {
        var jsonData = response.body;

        // If the API call is successful, return the data
        return weatherFromJson(jsonData);
      } else {
        return Future.error('Error getting weather data');
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // Function to create the API URL
  String weatherURL(lat, lon, tmz) {
    String apiParam =
        'hourly=temperature_2m,relativehumidity_2m,cloudcover,precipitation_probability,weathercode,soil_temperature_6cm,soil_moisture_3_9cm&daily=temperature_2m_min,temperature_2m_max,weathercode,precipitation_probability_mean,sunrise,sunset';
    String apiUrl = 'https://api.open-meteo.com/v1';

    // Return the API URL
    return '$apiUrl/forecast?latitude=$lat&longitude=$lon&$apiParam&timezone=$tmz';
  }

  // Function to get the weather description from the weather code
  String getWeatherDescription(int weatherCode) {
    return weatherDescriptions[weatherCode] ?? "Unknown";
  }

  // Function to get the weather icon from the weather code
  String getWeatherIcon(int weatherCode) {
    return weatherIcons[weatherCode] ?? weatherIcons[0] as String;
  }

  // Weather description map
  Map<int, String> weatherDescriptions = {
    0: "Clear sky",
    1: "Mainly clear",
    2: "Partly cloudy",
    3: "Overcast",
    45: "Fog",
    48: "Depositing rime fog",
    51: "Light Drizzle",
    53: "Moderate Drizzle",
    55: "Dense Drizzle",
    56: "Light Freezing Drizzle",
    57: "Dense Freezing Drizzle",
    61: "Slight Rain",
    63: "Moderate Rain",
    65: "Heavy Rain",
    66: "Light Freezing Rain",
    67: "Heavy Freezing Rain",
    71: "Slight Snow Fall",
    73: "Moderate Snow Fall",
    75: "Heavy Snow Fall",
    77: "Snow Grains",
    80: "Slight Rain Showers",
    81: "Moderate Rain Showers",
    82: "Violent Rain Showers",
    85: "Slight Snow Showers",
    86: "Heavy Snow Showers",
    95: "Slight or Moderate Thunderstorm",
    96: "Thunderstorm with Slight Hail",
    99: "Thunderstorm with Heavy Hail",
  };

  // Weather icon map
  Map<int, String> weatherIcons = {
    0: "assets/icons/weather0.png",
    1: "assets/icons/weather1.png",
    2: "assets/icons/weather2.png",
    3: "assets/icons/weather3.png",
    45: "assets/icons/weather45.png",
    48: "assets/icons/weather48.png",
    51: "assets/icons/weather51.png",
    53: "assets/icons/weather53.png",
    55: "assets/icons/weather55.png",
    56: "assets/icons/weather56.png",
    57: "assets/icons/weather57.png",
    61: "assets/icons/weather61.png",
    63: "assets/icons/weather63.png",
    65: "assets/icons/weather65.png",
    66: "assets/icons/weather66.png",
    67: "assets/icons/weather67.png",
    71: "assets/icons/weather71.png",
    73: "assets/icons/weather73.png",
    75: "assets/icons/weather75.png",
    77: "assets/icons/weather77.png",
    80: "assets/icons/weather80.png",
    81: "assets/icons/weather81.png",
    82: "assets/icons/weather82.png",
    85: "assets/icons/weather85.png",
    86: "assets/icons/weather86.png",
    95: "assets/icons/weather95.png",
    96: "assets/icons/weather96.png",
    99: "assets/icons/weather99.png",
  };
}
