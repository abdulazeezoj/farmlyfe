// To parse this JSON data, do
//
//     final crop = cropFromJson(jsonString);

import 'dart:convert';

List<Crop> cropFromJson(String str) =>
    List<Crop>.from(json.decode(str).map((x) => Crop.fromJson(x)));

String cropToJson(List<Crop> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Crop {
  Crop({
    required this.cropName,
    required this.imgUrl,
    required this.generalInformation,
    required this.temperature,
    required this.rainfall,
    required this.sowingTemperature,
    required this.harvestingTemperature,
    required this.soil,
    required this.landPreparation,
    required this.sowing,
    required this.seed,
    required this.fertilizer,
    required this.weedControl,
    required this.irrigation,
    required this.plantDisease,
    required this.plantPest,
    required this.harvesting,
  });

  String cropName;
  String imgUrl;
  String generalInformation;
  HarvestingTemperature temperature;
  HarvestingTemperature rainfall;
  HarvestingTemperature sowingTemperature;
  HarvestingTemperature harvestingTemperature;
  String soil;
  String landPreparation;
  String sowing;
  String seed;
  String fertilizer;
  String weedControl;
  String irrigation;
  List<Plant> plantDisease;
  List<Plant> plantPest;
  String harvesting;

  factory Crop.fromJson(Map<String, dynamic> json) => Crop(
        cropName: json["crop_name"],
        imgUrl: json["img_url"],
        generalInformation: json["general_information"],
        temperature: HarvestingTemperature.fromJson(json["temperature"]),
        rainfall: HarvestingTemperature.fromJson(json["rainfall"]),
        sowingTemperature:
            HarvestingTemperature.fromJson(json["sowing_temperature"]),
        harvestingTemperature:
            HarvestingTemperature.fromJson(json["harvesting_temperature"]),
        soil: json["soil"],
        landPreparation: json["land_preparation"],
        sowing: json["sowing"],
        seed: json["seed"],
        fertilizer: json["fertilizer"],
        weedControl: json["weed_control"],
        irrigation: json["irrigation"],
        plantDisease: List<Plant>.from(
            json["plant_disease"].map((x) => Plant.fromJson(x))),
        plantPest:
            List<Plant>.from(json["plant_pest"].map((x) => Plant.fromJson(x))),
        harvesting: json["harvesting"],
      );

  Map<String, dynamic> toJson() => {
        "crop_name": cropName,
        "img_url": imgUrl,
        "general_information": generalInformation,
        "temperature": temperature.toJson(),
        "rainfall": rainfall.toJson(),
        "sowing_temperature": sowingTemperature.toJson(),
        "harvesting_temperature": harvestingTemperature.toJson(),
        "soil": soil,
        "land_preparation": landPreparation,
        "sowing": sowing,
        "seed": seed,
        "fertilizer": fertilizer,
        "weed_control": weedControl,
        "irrigation": irrigation,
        "plant_disease":
            List<dynamic>.from(plantDisease.map((x) => x.toJson())),
        "plant_pest": List<dynamic>.from(plantPest.map((x) => x.toJson())),
        "harvesting": harvesting,
      };
}

class HarvestingTemperature {
  HarvestingTemperature({
    required this.minimum,
    required this.maximum,
    required this.unit,
  });

  String minimum;
  String maximum;
  String unit;

  factory HarvestingTemperature.fromJson(Map<String, dynamic> json) =>
      HarvestingTemperature(
        minimum: json["minimum"],
        maximum: json["maximum"],
        unit: json["unit"],
      );

  Map<String, dynamic> toJson() => {
        "minimum": minimum,
        "maximum": maximum,
        "unit": unit,
      };
}

class Plant {
  Plant({
    required this.name,
    required this.symptoms,
    required this.control,
  });

  String name;
  String symptoms;
  String control;

  factory Plant.fromJson(Map<String, dynamic> json) => Plant(
        name: json["name"],
        symptoms: json["symptoms"],
        control: json["control"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "symptoms": symptoms,
        "control": control,
      };
}
