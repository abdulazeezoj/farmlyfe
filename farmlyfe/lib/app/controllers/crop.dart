import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmlyfe/app/controllers/auth.dart';
import 'package:farmlyfe/app/models/crop.dart';
import 'package:farmlyfe/app/widgets/snackbar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CropController extends GetxController {
  // Services
  Reference storageRef = FirebaseStorage.instance.ref().child('crops');

  // Controllers
  AuthController authController = Get.put(AuthController());
  ScrollController scrollController = ScrollController();

  // Variables
  int cropsLimit = 8;

  // Observable variables
  final RxBool _cropsLoading = RxBool(true);
  final RxBool _cropFavoritesLoading = RxBool(true);
  final RxList<Crop> _cropsList = RxList<Crop>([]);
  final RxList<Crop> _cropFavorites = RxList<Crop>([]);

  // Getters
  // Get the crop loading state
  bool get getCropsLoading => _cropsLoading.value;

  // Get the crop favorites loading state
  bool get getCropFavoritesLoading => _cropFavoritesLoading.value;

  // Get the list of crops
  List<Crop> get getCrops => _cropsList;

  // Get the list of favorite crops
  List<Crop> get getCropFavorites => _cropFavorites;

  // Setters
  // Set the crops loading state
  void setCropsLoading(bool isLoading) {
    _cropsLoading.value = isLoading;
  }

  // Set the favorite crops loading state
  void setCropFavoritesLoading(bool isLoading) {
    _cropFavoritesLoading.value = isLoading;
  }

  // Set the list of favorite crops
  void setCropFavorites(List<Crop> crops) {
    _cropFavorites.value = crops;
  }

  @override
  void onInit() {
    // Get all crops from firebase firestore
    fetchCrops();

    // Get all favorite crops from firebase firestore
    fetchFavoriteCrops();

    // Listen for scroll events
    // onScroll();

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
    _cropsList.addAll(cropFromDocumentSnapshot(querySnapshot.docs));

    // Set the loading state to false
    setCropsLoading(false);
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
    _cropsList.addAll(cropFromDocumentSnapshot(querySnapshot.docs));
  }

  // Function to get all favorite crops from firestore
  fetchFavoriteCrops() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('favorites')
        .where('email', isEqualTo: authController.getUser?.email)
        .get();

    // Get the list of crops from the favorites
    List<DocumentReference> cropRefs =
        await querySnapshot.docs.first.get('crops').cast<DocumentReference>();

    // Fetch the crops from the crops collection if the list is not empty
    if (cropRefs.isNotEmpty) {
      QuerySnapshot cropQuerySnapshot = await FirebaseFirestore.instance
          .collection('crops')
          .where(FieldPath.documentId,
              whereIn: cropRefs.map((e) => e.id).toList())
          .get();

      // Add the crops to the list of favorites preventing duplicates
      setCropFavorites(cropFromDocumentSnapshot(cropQuerySnapshot.docs));
    } else {
      // Set the list of favorites to an empty list
      setCropFavorites([]);
    }

    // Set the loading state to false
    setCropFavoritesLoading(false);
  }

  // Function to add a crop to the list of favorites
  addCropToFavorite(Crop crop) async {
    // Add the crop to the user's favorites
    await FirebaseFirestore.instance
        .collection('favorites')
        .where('email', isEqualTo: authController.getUser?.email)
        .get()
        .then(
      (value) {
        value.docs.first.reference.update({
          'crops': FieldValue.arrayUnion(
              [FirebaseFirestore.instance.collection('crops').doc(crop.cropId)])
        });

        // Add the crop to the list of favorites
        fetchFavoriteCrops();
      },
    ).catchError(
      (e) {
        SnackbarWidget.showError(e.toString());
      },
    );
  }

  // Function to remove a crop from the list of favorites
  removeCropFromFavorite(Crop crop) async {
    // Remove the crop from the user's favorites
    await FirebaseFirestore.instance
        .collection('favorites')
        .where('email', isEqualTo: authController.getUser?.email)
        .get()
        .then(
      (value) {
        value.docs.first.reference.update(
          {
            'crops': FieldValue.arrayRemove([
              FirebaseFirestore.instance.collection('crops').doc(crop.cropId),
            ])
          },
        );

        // Remove the crop from the list of favorites
        fetchFavoriteCrops();
      },
    ).catchError((e) {
      SnackbarWidget.showError(e.toString());
    });
  }

  // Function to check if crop is in list of avorites
  bool isFavoriteCrop(Crop crop) {
    List<String?> favoriteCropsRefs =
        _cropFavorites.map((e) => e.cropId).toList();

    return favoriteCropsRefs.contains(crop.cropId);
  }

  // Function to get crop image crops folder in firebase storage
  Future<String> getCropImage(String cropName) async {
    String imageUrl = await storageRef.child('${cropName.toLowerCase()}.jpeg').getDownloadURL();
    return imageUrl;
  }
}
