import 'package:cached_network_image/cached_network_image.dart';
import 'package:exam_app/config/colors.dart';
import 'package:exam_app/controllers/practice_controller.dart';
import 'package:exam_app/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class Question extends StatelessWidget {
  final PracticeController controller;
  const Question({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      int index = controller.isPracticeSetComplete
          ? controller.tabController.index
          : controller.currentIndex;

      return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 25.w),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 180.h,
            width: MediaQuery.of(context).size.width,
            child: CachedNetworkImage(
                imageUrl: controller.praciceSets[index].mediaFile,
                fit: BoxFit.cover),
          ),
          SizedBox(height: 25.h),
          Text(
            controller.praciceSets[index].question,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Color(0xFF333333),
            ),
          ),
          SizedBox(height: 15.h),
          ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              final currentQuestion = controller.praciceSets[index];
              final option = currentQuestion.options[index];
              final isSubmitted = currentQuestion.submit != null;
              final isSelected = controller.submitAnswerIndex() == index;
              final isSelectedAfterSubmit = isSubmitted && isSelected;

              return InkWell(
                onTap: () => controller.doAnswer(index),
                child: Row(
                  children: [
                    // Option indicator circle
                    Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSelectedAfterSubmit
                            ? null
                            : const Color(0xFFD4D4D4),
                        gradient:
                            isSelectedAfterSubmit ? containerGradient : null,
                      ),
                      child: Center(
                        child: Text(
                          option.slNo,
                          style: const TextStyle(
                            color: whiteColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: 10.w),

                    // Option text content
                    Expanded(
                      child: isSelectedAfterSubmit
                          ? GradientText(
                              option.value,
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                              colors: const [
                                primaryColor,
                                primaryColor,
                                secondaryColor
                              ],
                            )
                          : Text(
                              option.value,
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Color(0xFF333333),
                              ),
                            ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => SizedBox(height: 15.h),
            itemCount: 4,
          ),
        ]),
      );
    });
  }
}
