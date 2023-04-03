import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmlyfe/app/models/crop.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CropController extends GetxController {
  // Services
  ScrollController scrollController = ScrollController();

  // Variables
  int cropsLimit = 8;

  // Observable variables
  final RxBool _isLoading = RxBool(true);
  final RxList<Crop> _cropsList = RxList<Crop>([]);
  final RxList<Crop> _cropFavorites = RxList<Crop>([]);

  // Getters
  // Get the loading state
  bool get getLoading => _isLoading.value;

  // Get the list of crops
  List<Crop> get getCrops => _cropsList;

  // Get the list of favorite crops
  List<Crop> get getCropFavorites => _cropFavorites;


  // Setters
  // Set the loading state
  void setLoading(bool isLoading) {
    _isLoading.value = isLoading;
  }

  // Add a crop to the list of favorites
  void addCropToFavorites(Crop crop) {
    _cropFavorites.add(crop);
  }

  // Remove a crop from the list of favorites
  void removeCropFromFavorites(Crop crop) {
    _cropFavorites.remove(crop);
  }

  @override
  void onInit() {
    // Get all crops from firebase firestore
    fetchCrops();

    // Listen for scroll events
    onScroll();

    super.onInit();
  }

  // Function to get all crops from firestore using limit
  fetchCrops() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('crops')
        .orderBy('crop_name')
        .limit(cropsLimit)
        .get();

    // Add the new crops to the list
    _cropsList.addAll(querySnapshot.docs
        .map((e) => Crop.fromJson(e.data() as Map<String, dynamic>))
        .toList());

    // Set the loading state to false
    setLoading(false);
  }

  // function to get a number of crops from firestore using offset and limit
  fetchMoreCrops({required int limit}) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('crops')
        .orderBy('crop_name')
        .startAfter([_cropsList.last.cropName])
        .limit(limit)
        .get();

    // Add the new crops to the list
    _cropsList.addAll(querySnapshot.docs
        .map((e) => Crop.fromJson(e.data() as Map<String, dynamic>))
        .toList());
  }

  // Function to fetch more crops from firestore when the user scrolls to the end of the page
  onScroll() async {
    // Listen to the scroll controller
    scrollController.addListener(() {
      // Check if the scroll controller has reached the end of the page
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        // Get more crops from firebase firestore
        fetchMoreCrops(limit: cropsLimit);
      }
    });
  }
}
