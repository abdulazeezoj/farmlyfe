// To parse this JSON data, do
//
//     final weather = weatherFromJson(jsonString);

import 'dart:convert';

Weather weatherFromJson(String str) => Weather.fromJson(json.decode(str));

String weatherToJson(Weather data) => json.encode(data.toJson());

class Weather {
  Weather({
    required this.latitude,
    required this.longitude,
    required this.generationtimeMs,
    required this.utcOffsetSeconds,
    required this.timezone,
    required this.timezoneAbbreviation,
    required this.hourlyUnits,
    required this.hourly,
    required this.dailyUnits,
    required this.daily,
  });

  double latitude;
  double longitude;
  double generationtimeMs;
  int utcOffsetSeconds;
  String timezone;
  String timezoneAbbreviation;
  WeatherHourlyUnits hourlyUnits;
  WeatherHourly hourly;
  WeatherDailyUnits dailyUnits;
  WeatherDaily daily;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        generationtimeMs: json["generationtime_ms"]?.toDouble(),
        utcOffsetSeconds: json["utc_offset_seconds"],
        timezone: json["timezone"],
        timezoneAbbreviation: json["timezone_abbreviation"],
        hourlyUnits: WeatherHourlyUnits.fromJson(json["hourly_units"]),
        hourly: WeatherHourly.fromJson(json["hourly"]),
        dailyUnits: WeatherDailyUnits.fromJson(json["daily_units"]),
        daily: WeatherDaily.fromJson(json["daily"]),
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
        "generationtime_ms": generationtimeMs,
        "utc_offset_seconds": utcOffsetSeconds,
        "timezone": timezone,
        "timezone_abbreviation": timezoneAbbreviation,
        "hourly_units": hourlyUnits.toJson(),
        "hourly": hourly.toJson(),
        "daily_units": dailyUnits.toJson(),
        "daily": daily.toJson(),
      };
}

class WeatherDaily {
  WeatherDaily({
    required this.time,
    required this.temperature2MMin,
    required this.temperature2MMax,
    required this.weathercode,
    required this.precipitationProbabilityMean,
    required this.sunrise,
    required this.sunset,
  });

  List<DateTime> time;
  List<double> temperature2MMin;
  List<double> temperature2MMax;
  List<int> weathercode;
  List<int> precipitationProbabilityMean;
  List<DateTime> sunrise;
  List<DateTime> sunset;

  factory WeatherDaily.fromJson(Map<String, dynamic> json) => WeatherDaily(
        time: List<DateTime>.from(json["time"].map((x) => DateTime.parse(x))),
        temperature2MMin: List<double>.from(
            json["temperature_2m_min"].map((x) => x?.toDouble())),
        temperature2MMax: List<double>.from(
            json["temperature_2m_max"].map((x) => x?.toDouble())),
        weathercode: List<int>.from(json["weathercode"].map((x) => x)),
        precipitationProbabilityMean: List<int>.from(
            json["precipitation_probability_mean"].map((x) => x)),
        sunrise: List<DateTime>.from(
            json["sunrise"].map((x) => DateTime.parse(x))),
        sunset: List<DateTime>.from(json["sunset"].map((x) => DateTime.parse(x))),
      );

  Map<String, dynamic> toJson() => {
        "time": List<dynamic>.from(time.map((x) =>
            "${x.year.toString().padLeft(4, '0')}-${x.month.toString().padLeft(2, '0')}-${x.day.toString().padLeft(2, '0')}")),
        "temperature_2m_min":
            List<dynamic>.from(temperature2MMin.map((x) => x)),
        "temperature_2m_max":
            List<dynamic>.from(temperature2MMax.map((x) => x)),
        "weathercode": List<dynamic>.from(weathercode.map((x) => x)),
        "precipitation_probability_mean":
            List<dynamic>.from(precipitationProbabilityMean.map((x) => x)),
        "sunrise": List<dynamic>.from(sunrise.map((x) => x)),
        "sunset": List<dynamic>.from(sunset.map((x) => x)),
      };
}

class WeatherDailyUnits {
  WeatherDailyUnits({
    required this.time,
    required this.temperature2MMin,
    required this.temperature2MMax,
    required this.weathercode,
    required this.precipitationProbabilityMean,
    required this.sunrise,
    required this.sunset,
  });

  String time;
  String temperature2MMin;
  String temperature2MMax;
  String weathercode;
  String precipitationProbabilityMean;
  String sunrise;
  String sunset;

  factory WeatherDailyUnits.fromJson(Map<String, dynamic> json) => WeatherDailyUnits(
        time: json["time"],
        temperature2MMin: json["temperature_2m_min"],
        temperature2MMax: json["temperature_2m_max"],
        weathercode: json["weathercode"],
        precipitationProbabilityMean: json["precipitation_probability_mean"],
        sunrise: json["sunrise"],
        sunset: json["sunset"],
      );

  Map<String, dynamic> toJson() => {
        "time": time,
        "temperature_2m_min": temperature2MMin,
        "temperature_2m_max": temperature2MMax,
        "weathercode": weathercode,
        "precipitation_probability_mean": precipitationProbabilityMean,
        "sunrise": sunrise,
        "sunset": sunset,
      };
}

class WeatherHourly {
  WeatherHourly({
    required this.time,
    required this.temperature2M,
    required this.relativehumidity2M,
    required this.cloudcover,
    required this.precipitationProbability,
    required this.weathercode,
    required this.soilTemperature6Cm,
    required this.soilMoisture39Cm,
  });

  List<DateTime> time;
  List<double> temperature2M;
  List<int> relativehumidity2M;
  List<int> cloudcover;
  List<int> precipitationProbability;
  List<int> weathercode;
  List<double> soilTemperature6Cm;
  List<double> soilMoisture39Cm;

  factory WeatherHourly.fromJson(Map<String, dynamic> json) => WeatherHourly(
        time: List<DateTime>.from(json["time"].map((x) => DateTime.parse(x))),
        temperature2M:
            List<double>.from(json["temperature_2m"].map((x) => x?.toDouble())),
        relativehumidity2M:
            List<int>.from(json["relativehumidity_2m"].map((x) => x)),
        cloudcover: List<int>.from(json["cloudcover"].map((x) => x)),
        precipitationProbability:
            List<int>.from(json["precipitation_probability"].map((x) => x)),
        weathercode: List<int>.from(json["weathercode"].map((x) => x)),
        soilTemperature6Cm: List<double>.from(
            json["soil_temperature_6cm"].map((x) => x?.toDouble())),
        soilMoisture39Cm: List<double>.from(
            json["soil_moisture_3_9cm"].map((x) => x?.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "time": List<dynamic>.from(time.map((x) => x)),
        "temperature_2m": List<dynamic>.from(temperature2M.map((x) => x)),
        "relativehumidity_2m":
            List<dynamic>.from(relativehumidity2M.map((x) => x)),
        "cloudcover": List<dynamic>.from(cloudcover.map((x) => x)),
        "precipitation_probability":
            List<dynamic>.from(precipitationProbability.map((x) => x)),
        "weathercode": List<dynamic>.from(weathercode.map((x) => x)),
        "soil_temperature_6cm":
            List<dynamic>.from(soilTemperature6Cm.map((x) => x)),
        "soil_moisture_3_9cm":
            List<dynamic>.from(soilMoisture39Cm.map((x) => x)),
      };
}

class WeatherHourlyUnits {
  WeatherHourlyUnits({
    required this.time,
    required this.temperature2M,
    required this.relativehumidity2M,
    required this.cloudcover,
    required this.precipitationProbability,
    required this.weathercode,
    required this.soilTemperature6Cm,
    required this.soilMoisture39Cm,
  });

  String time;
  String temperature2M;
  String relativehumidity2M;
  String cloudcover;
  String precipitationProbability;
  String weathercode;
  String soilTemperature6Cm;
  String soilMoisture39Cm;

  factory WeatherHourlyUnits.fromJson(Map<String, dynamic> json) => WeatherHourlyUnits(
        time: json["time"],
        temperature2M: json["temperature_2m"],
        relativehumidity2M: json["relativehumidity_2m"],
        cloudcover: json["cloudcover"],
        precipitationProbability: json["precipitation_probability"],
        weathercode: json["weathercode"],
        soilTemperature6Cm: json["soil_temperature_6cm"],
        soilMoisture39Cm: json["soil_moisture_3_9cm"],
      );

  Map<String, dynamic> toJson() => {
        "time": time,
        "temperature_2m": temperature2M,
        "relativehumidity_2m": relativehumidity2M,
        "cloudcover": cloudcover,
        "precipitation_probability": precipitationProbability,
        "weathercode": weathercode,
        "soil_temperature_6cm": soilTemperature6Cm,
        "soil_moisture_3_9cm": soilMoisture39Cm,
      };
}
