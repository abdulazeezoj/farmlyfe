// To parse this JSON data, do
//
//     final crop = cropFromJson(jsonString);

// import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// List<Crop> cropFromJson(String str) =>
//     List<Crop>.from(json.decode(str).map((x) => Crop.fromJson(x)));

// String cropToJson(List<Crop> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


List<Crop> cropFromDocumentSnapshot(List<DocumentSnapshot> docs) {
  return docs
      .map((doc) => Crop.fromDocumentSnapshot(doc as DocumentSnapshot<Map<String, dynamic>>))
      .toList();
}

class Crop {
  Crop({
    this.cropId,
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

  String? cropId;
  String cropName;
  String imgUrl;
  String generalInformation;
  ClimateFactor temperature;
  ClimateFactor rainfall;
  ClimateFactor sowingTemperature;
  ClimateFactor harvestingTemperature;
  String soil;
  String landPreparation;
  String sowing;
  String seed;
  String fertilizer;
  String weedControl;
  String irrigation;
  List<CropProtection> plantDisease;
  List<CropProtection> plantPest;
  String harvesting;

  // factory Crop.fromJson(Map<String, dynamic> json) => Crop(
  //       cropName: json["crop_name"],
  //       imgUrl: json["img_url"],
  //       generalInformation: json["general_information"],
  //       temperature: ClimateFactor.fromMap(json["temperature"]),
  //       rainfall: ClimateFactor.fromMap(json["rainfall"]),
  //       sowingTemperature:
  //           ClimateFactor.fromMap(json["sowing_temperature"]),
  //       harvestingTemperature:
  //           ClimateFactor.fromMap(json["harvesting_temperature"]),
  //       soil: json["soil"],
  //       landPreparation: json["land_preparation"],
  //       sowing: json["sowing"],
  //       seed: json["seed"],
  //       fertilizer: json["fertilizer"],
  //       weedControl: json["weed_control"],
  //       irrigation: json["irrigation"],
  //       plantDisease: List<CropProtection>.from(
  //           json["plant_disease"].map((x) => CropProtection.fromMap(x))),
  //       plantPest:
  //           List<CropProtection>.from(json["plant_pest"].map((x) => CropProtection.fromMap(x))),
  //       harvesting: json["harvesting"],
  //     );

  factory Crop.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    return Crop(
      cropId: doc.id,
      cropName: doc['crop_name'],
      imgUrl: doc['img_url'],
      generalInformation: doc['general_information'],
      temperature: ClimateFactor.fromMap(doc['temperature']),
      rainfall: ClimateFactor.fromMap(doc['rainfall']),
      sowingTemperature: ClimateFactor.fromMap(doc['sowing_temperature']),
      harvestingTemperature:
          ClimateFactor.fromMap(doc['harvesting_temperature']),
      soil: doc['soil'],
      landPreparation: doc['land_preparation'],
      sowing: doc['sowing'],
      seed: doc['seed'],
      fertilizer: doc['fertilizer'],
      weedControl: doc['weed_control'],
      irrigation: doc['irrigation'],
      plantDisease: List<CropProtection>.from(
          doc['plant_disease'].map((x) => CropProtection.fromMap(x))),
      plantPest: List<CropProtection>.from(
          doc['plant_pest'].map((x) => CropProtection.fromMap(x))),
      harvesting: doc['harvesting'],
    );
  }

  Map<String, dynamic> toMap() => {
        "crop_name": cropName,
        "img_url": imgUrl,
        "general_information": generalInformation,
        "temperature": temperature.toMap(),
        "rainfall": rainfall.toMap(),
        "sowing_temperature": sowingTemperature.toMap(),
        "harvesting_temperature": harvestingTemperature.toMap(),
        "soil": soil,
        "land_preparation": landPreparation,
        "sowing": sowing,
        "seed": seed,
        "fertilizer": fertilizer,
        "weed_control": weedControl,
        "irrigation": irrigation,
        "plant_disease": List<dynamic>.from(plantDisease.map((x) => x.toMap())),
        "plant_pest": List<dynamic>.from(plantPest.map((x) => x.toMap())),
        "harvesting": harvesting,
      };
}

class ClimateFactor {
  ClimateFactor({
    required this.minimum,
    required this.maximum,
    required this.unit,
  });

  String minimum;
  String maximum;
  String unit;

  factory ClimateFactor.fromMap(Map<String, dynamic> climateFactorMap) =>
      ClimateFactor(
        minimum: climateFactorMap["minimum"],
        maximum: climateFactorMap["maximum"],
        unit: climateFactorMap["unit"],
      );

  Map<String, dynamic> toMap() => {
        "minimum": minimum,
        "maximum": maximum,
        "unit": unit,
      };
}

class CropProtection {
  CropProtection({
    required this.name,
    required this.symptoms,
    required this.control,
  });

  String name;
  String symptoms;
  String control;

  factory CropProtection.fromMap(Map<String, dynamic> cropProtectionMap) =>
      CropProtection(
        name: cropProtectionMap["name"],
        symptoms: cropProtectionMap["symptoms"],
        control: cropProtectionMap["control"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "symptoms": symptoms,
        "control": control,
      };
}
