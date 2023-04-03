// Create 2 column grid of crops widget that fetch from firebase firestore
// and display in grid view

import 'package:farmlyfe/app/controllers/crop.dart';
import 'package:farmlyfe/app/models/crop.dart';
import 'package:farmlyfe/app/widgets/crop_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class CropList extends StatelessWidget {
  CropList({Key? key}) : super(key: key);

  // Controllers
  final CropController cropController = Get.put(CropController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
      child: Obx(
        // Show Circular Progress if loading of list of crop with image crop and part of the general info
        () => cropController.getLoading
            ? const CropListSkeleton()
            : ListView.builder(
                controller: cropController.scrollController,
                itemCount: cropController.getCrops.length,
                itemBuilder: (context, index) {
                  return CropListCard(
                      crop: cropController.getCrops[index],
                      cropIndex: index,
                      cropCount: cropController.getCrops.length);
                },
              ),
      ),
    );
  }
}

class CropListCard extends StatelessWidget {
  CropListCard({
    super.key,
    required this.crop,
    required this.cropIndex,
    required this.cropCount,
  });

  // Controllers
  final CropController cropController = Get.put(CropController());

  final Crop crop;
  final int cropIndex;
  final int cropCount;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Open the crop details dialog
        Get.dialog(
          CropDetailsDialog(
            crop: crop,
          ),
        );
      },
      // Container for the crop card with floating favorite button
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        child: Stack(
          children: [
            // Crop card
            Container(
              padding: const EdgeInsets.all(8),
              height: 108,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    width: 80,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        'https://placeimg.com/640/480/any',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            crop.cropName,
                            style: GoogleFonts.openSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            crop.generalInformation,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Favorite button
            Obx(
              () => Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: () {
                    // If the crop is already favorited, remove it from the list
                    if (cropController.getCropFavorites.contains(crop)) {
                      cropController.removeCropFromFavorites(crop);
                    } else {
                      // If the crop is not favorited, add it to the list
                      cropController.addCropToFavorites(crop);
                    }
                  },
                  child: SizedBox(
                    width: 25,
                    height: 25,
                    child: Icon(
                      cropController.getCropFavorites.contains(crop)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      size: 25,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// CropList Skeleton with shimmer effect
class CropListSkeleton extends StatelessWidget {
  const CropListSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
      child: Shimmer.fromColors(
        baseColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
        highlightColor:
            Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 10,
          itemBuilder: (context, index) {
            return Container(
              height: 108,
              margin: const EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            );
          },
        ),
      ),
    );
  }
}
