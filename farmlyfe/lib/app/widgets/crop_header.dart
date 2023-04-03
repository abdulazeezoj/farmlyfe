import 'package:farmlyfe/app/controllers/auth.dart';
import 'package:farmlyfe/app/controllers/global.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CropHeader extends StatelessWidget implements PreferredSizeWidget {
  CropHeader({super.key});

  // Controllers
  final GlobalController globalController = Get.put(GlobalController());
  final AuthController authController = Get.put(AuthController());

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 2,
      centerTitle: true,
      toolbarHeight: preferredSize.height,
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      shadowColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20),
        ),
      ),
      title: Container(
        padding: const EdgeInsets.only(
          left: 0,
          right: 0,
        ),
        height: preferredSize.height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Search Bar with search icon
            Expanded(
              child: Container(
                  height: 40,
                  margin: const EdgeInsets.only(
                    right: 10,
                  ),
                  child: TextField(
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.onInverseSurface,
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Search for a crop...',
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                    ),
                    textInputAction: TextInputAction.search,
                  )),
            ),
            // CircleAvatar with profile icon
            SizedBox(
              height: 40,
              width: 40,
              child: GestureDetector(
                onTap: () {
                  // Navigate to profile page
                  globalController.setPageIndex(2);
                },
                child: CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(
                    authController.getUser?.photoURL ??
                        'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
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
