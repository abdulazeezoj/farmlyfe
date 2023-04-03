import 'package:farmlyfe/app/controllers/crop.dart';
import 'package:farmlyfe/app/models/crop.dart';
import 'package:farmlyfe/app/widgets/crop_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class CropFavorite extends StatelessWidget {
  CropFavorite({Key? key}) : super(key: key);

  // Controllers
  final CropController cropController = Get.put(CropController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return cropController.getCropFavorites.isEmpty
            ? const CropFavoriteSkeleton()
            : Container(
                height: 270,
                color: Colors.red,
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                  top: 20,
                  bottom: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Favorite Crops',
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 200,
                      child: Obx(
                        () {
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: cropController.getCrops.length,
                            itemBuilder: (context, index) {
                              return CropFavoriteCard(
                                  crop: cropController.getCrops[index]);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
      },
    );
  }
}

class CropFavoriteCard extends StatelessWidget {
  CropFavoriteCard({
    super.key,
    required this.crop,
  });

  final Crop crop;

  // Controllers
  final CropController cropController = Get.put(CropController());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {
          // Open the crop details dialog
          Get.dialog(
            CropDetailsDialog(
              crop: crop,
            ),
          );
        },
        child: Container(
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
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  'https://placeimg.com/640/480/any',
                  fit: BoxFit.cover,
                  height: 100,
                ),
              ),
              SizedBox(
                height: 40,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    crop.cropName,
                    style: Theme.of(context).textTheme.titleSmall,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              GestureDetector(
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
                  height: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.favorite,
                        color: Theme.of(context).colorScheme.primary,
                        size: 15,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Favorite',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                    ],
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

// CropFavorite Skeleton with shimmer effect
class CropFavoriteSkeleton extends StatelessWidget {
  const CropFavoriteSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 270,
      padding: const EdgeInsets.only(
        left: 15,
        right: 15,
        top: 20,
        bottom: 20,
      ),
      child: Shimmer.fromColors(
        baseColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
        highlightColor:
            Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Favorite Crops',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.left,
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (__, _) {
                  return Container(
                    width: 130,
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
