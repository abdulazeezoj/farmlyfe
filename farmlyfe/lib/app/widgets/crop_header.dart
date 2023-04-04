import 'package:farmlyfe/app/controllers/auth.dart';
import 'package:farmlyfe/app/controllers/crop.dart';
import 'package:farmlyfe/app/controllers/global.dart';
import 'package:farmlyfe/app/models/crop.dart';
import 'package:farmlyfe/app/widgets/crop_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class CropHeader extends StatelessWidget implements PreferredSizeWidget {
  CropHeader({super.key});

  // Controllers
  final GlobalController globalController = Get.put(GlobalController());
  final AuthController authController = Get.put(AuthController());

  @override
  Size get preferredSize => const Size.fromHeight(240);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 2,
      centerTitle: true,
      toolbarHeight: preferredSize.height,
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      shadowColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
      titleSpacing: 0,
      title: SizedBox(
        height: preferredSize.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Favorite Crops
            CropFavoriteList(),
          ],
        ),
      ),
    );
  }
}

// CropFavorite
class CropFavoriteList extends StatelessWidget {
  CropFavoriteList({Key? key}) : super(key: key);

  // Controllers
  final CropController cropController = Get.put(CropController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return SizedBox(
          height: 240,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Text(
                  'Favorite Crops',
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.left,
                ),
              ),
              cropController.getCropFavorites.isEmpty
                  ? const CropFavoriteSkeleton()
                  : Obx(
                      () => SizedBox(
                        height: 220,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.only(
                            top: 15,
                            bottom: 15,
                            left: 15,
                          ),
                          itemCount: cropController.getCropFavorites.length,
                          itemBuilder: (context, index) {
                            return CropFavoriteCard(
                                crop: cropController.getCropFavorites[index]);
                          },
                        ),
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }
}

// CropFavorite Card
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
    return GestureDetector(
      onTap: () {
        // Open the crop details dialog
        Get.dialog(
          CropDetailsDialog(
            crop: crop,
          ),
        );
      },
      child: Container(
        height: 210,
        width: 130,
        margin: const EdgeInsets.only(
          right: 15,
        ),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onInverseSurface,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
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
                    alignment: Alignment.centerLeft,
                    child: Text(
                      crop.cropName,
                      style: Theme.of(context).textTheme.titleSmall,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),

            // Crop Favorite Icon
            Obx(
              () => Positioned(
                bottom: -2,
                right: -2,
                child: GestureDetector(
                  onTap: () {
                    // If the crop is already favorited, remove it from the list
                    if (cropController.isFavoriteCrop(crop)) {
                      cropController.removeCropFromFavorite(crop);
                    } else {
                      // If the crop is not favorited, add it to the list
                      cropController.addCropToFavorite(crop);
                    }
                  },
                  child: SizedBox(
                    width: 25,
                    height: 25,
                    child: Icon(
                      cropController.isFavoriteCrop(crop)
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

// CropFavorite Skeleton with shimmer effect
class CropFavoriteSkeleton extends StatelessWidget {
  const CropFavoriteSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
      highlightColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
      child: SizedBox(
        height: 210,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(
            top: 15,
            bottom: 15,
            left: 15,
          ),
          itemCount: 5,
          itemBuilder: (__, _) {
            return Container(
              height: 200,
              width: 130,
              margin: const EdgeInsets.only(
                right: 15,
              ),
              padding: const EdgeInsets.all(10),
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
