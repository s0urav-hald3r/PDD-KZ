import 'package:exam_app/config/colors.dart';
import 'package:exam_app/config/icons.dart';
import 'package:exam_app/controllers/home_controller.dart';
import 'package:exam_app/controllers/practice_controller.dart';
import 'package:exam_app/utils/extension.dart';
import 'package:exam_app/views/favourite_page.dart';
import 'package:exam_app/views/home_page.dart';
import 'package:exam_app/views/practice_page.dart';
import 'package:exam_app/views/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:skeletonizer/skeletonizer.dart';

class NavBarPage extends StatelessWidget {
  const NavBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = HomeController.instance;

    return Obx(() {
      return Scaffold(
        body: PageView(
          controller: controller.pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Skeletonizer(
                enabled: controller.isLoading, child: const HomePage()),
            Skeletonizer(
                enabled: controller.isLoading, child: const PracticePage()),
            Skeletonizer(
                enabled: controller.isLoading, child: const FavouritePage()),
            Skeletonizer(
                enabled: controller.isLoading, child: const SettingsPage())
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          height: 60.h,
          color: greyColor,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            _navItem(0, selectedHomeIcon, unSelectedHomeIcon, 'Home'.tr, () {
              controller.homeIndex = 0;
              controller.pageController.jumpToPage(0);
            }),
            _navItem(1, selectedPracIcon, unSelectedPracIcon, 'Practice'.tr,
                () {
              controller.homeIndex = 1;
              controller.pageController.jumpToPage(1);
            }),
            _navItem(2, selectedFavIcon, unSelectedFavIcon, 'Favourite'.tr, () {
              controller.homeIndex = 2;
              controller.pageController.jumpToPage(2);
              Get.put(PracticeController(), tag: 'controller_fav');
            }),
            _navItem(
                3, selectedSettingsIcon, unSelectedSettingsIcon, 'Settings'.tr,
                () {
              controller.homeIndex = 3;
              controller.pageController.jumpToPage(3);
            }),
          ]),
        ),
      );
    });
  }

  Widget _navItem(
    int index,
    String seletedIcon,
    String unseletedIcon,
    String title,
    Function callBack,
  ) {
    return InkWell(
      onTap: () {
        callBack();
      },
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SvgPicture.asset(
          HomeController.instance.homeIndex == index
              ? seletedIcon
              : unseletedIcon,
        ),
        SizedBox(height: 6.h),
        HomeController.instance.homeIndex == index
            ? GradientText(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
                colors: const [primaryColor, primaryColor, secondaryColor],
              )
            : Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              )
      ]),
    );
  }
}
