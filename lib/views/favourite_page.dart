import 'package:cached_network_image/cached_network_image.dart';
import 'package:exam_app/config/colors.dart';
import 'package:exam_app/controllers/home_controller.dart';
import 'package:exam_app/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavouritePage extends GetView<HomeController> {
  const FavouritePage({super.key});

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
                  padding: EdgeInsets.fromLTRB(25.w, 25.h, 25.w, 0),
                  child: controller.favoriteSets.isEmpty
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
                      : SingleChildScrollView(
                          child: Wrap(
                            runSpacing: 10.h,
                            spacing: 10.w,
                            children: List.generate(
                                controller.favoriteSets.length, (index) {
                              return Container(
                                width: 157.w,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF5F7FA),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                  vertical: 10.h,
                                ),
                                child: Column(children: [
                                  SizedBox(
                                    width: 137.w,
                                    height: 90.h,
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        topRight: Radius.circular(5),
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl: controller
                                            .favoriteSets[index].mediaFile,
                                        fit: BoxFit.cover,
                                        errorWidget: (context, url, error) =>
                                            Image.network(
                                          'https://thumb.ac-illust.com/b1/b170870007dfa419295d949814474ab2_t.jpeg',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  SizedBox(
                                    width: 137.w,
                                    height: 55.h,
                                    child: Text(
                                      controller.favoriteSets[index].question,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        color: textColor,
                                      ),
                                    ),
                                  )
                                ]),
                              );
                            }),
                          ),
                        )),
            );
          }),
        ]),
      ),
    );
  }
}
