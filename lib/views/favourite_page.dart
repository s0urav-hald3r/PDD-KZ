import 'package:exam_app/components/progress_bar.dart';
import 'package:exam_app/components/question.dart';
import 'package:exam_app/config/colors.dart';
import 'package:exam_app/config/icons.dart';
import 'package:exam_app/controllers/home_controller.dart';
import 'package:exam_app/controllers/practice_controller.dart';
import 'package:exam_app/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  late PracticeController pController;
  final controller = HomeController.instance;

  @override
  void initState() {
    super.initState();
    pController = Get.find<PracticeController>(tag: 'controller_13');
    pController.initializePracticeSet(13);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(gradient: containerGradient),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
              25.w,
              MediaQuery.of(context).padding.top + 15.h,
              0,
              15.h,
            ),
            child: Text(
              'Favourite'.tr,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: whiteColor,
              ),
            ),
          ),
          Obx(() {
            return Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: controller.sequentialFavoriteSets.isEmpty
                    ? const Center(
                        child: Text(
                          'No question added as favourite yet',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: textColor,
                          ),
                        ),
                      )
                    : Column(children: [
                        SizedBox(height: 15.h),
                        ProgressBar(controller: pController),
                        Question(controller: pController),
                        Obx(() {
                          if (pController.isComplete) {
                            return const SizedBox.shrink();
                          }

                          return Padding(
                            padding: EdgeInsets.only(
                              bottom: controller.isNavbarHide
                                  ? MediaQuery.of(context).padding.bottom
                                  : 0,
                            ),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: pController.submitQuestion,
                                    child: Container(
                                      width: 140.w,
                                      height: 45.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: whiteColor,
                                        border: Border.all(color: primaryColor),
                                      ),
                                      child: Center(
                                        child: GradientText(
                                            pController.isLastQuestion
                                                ? 'Submit'
                                                : 'Continue',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16,
                                            ),
                                            colors: const [
                                              primaryColor,
                                              primaryColor,
                                              secondaryColor
                                            ]),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  InkWell(
                                    onTap: () {
                                      pController.toggleFavorite();
                                    },
                                    child: Container(
                                      width: 45.w,
                                      height: 45.w,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: pController
                                                .praciceSets[
                                                    pController.currentIndex]
                                                .isFavorite
                                            ? null
                                            : whiteColor,
                                        border: pController
                                                .praciceSets[
                                                    pController.currentIndex]
                                                .isFavorite
                                            ? null
                                            : Border.all(color: primaryColor),
                                        gradient: pController
                                                .praciceSets[
                                                    pController.currentIndex]
                                                .isFavorite
                                            ? containerGradient
                                            : null,
                                      ),
                                      child: Center(
                                        child: SvgPicture.asset(
                                          unSelectedFavIcon,
                                          color: pController
                                                  .praciceSets[
                                                      pController.currentIndex]
                                                  .isFavorite
                                              ? whiteColor
                                              : primaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                          );
                        })
                      ]),
              ),
            );
          }),
        ]),
      ),
    );
  }
}
