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
      return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: 15.h),
          SizedBox(
            height: 160.h,
            width: MediaQuery.of(context).size.width,
            child: CachedNetworkImage(
                imageUrl:
                    controller.praciceSets[controller.currentIndex].mediaFile,
                fit: BoxFit.cover),
          ),
          SizedBox(height: 15.h),
          Text(
            controller.praciceSets[controller.currentIndex].question,
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
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final currentQuestion =
                  controller.praciceSets[controller.currentIndex];
              final option = currentQuestion.options[index];
              final isSelected = controller.submitAnswerIndex() == index;
              final isCorrect = controller.correctAnswerIndex() == index;

              return Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.5.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: isSelected || isCorrect
                      ? option.answer
                          ? Colors.green.shade200
                          : Colors.red.shade200
                      : null,
                ),
                child: InkWell(
                  onTap: () => controller.doAnswer(index),
                  child: Row(
                    children: [
                      // Option indicator circle
                      Container(
                        width: 30.w,
                        height: 30.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isSelected ? null : const Color(0xFFD4D4D4),
                          gradient: isSelected ? containerGradient : null,
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
                        child: isSelected
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
                ),
              );
            },
            separatorBuilder: (context, index) => SizedBox(height: 15.h),
            itemCount: 4,
          ),
          Visibility.maintain(
            visible:
                controller.praciceSets[controller.currentIndex].isSubmitted,
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (_) {
                      return Container(
                        decoration: const BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                          ),
                        ),
                        padding: EdgeInsets.fromLTRB(
                          25.w,
                          25.h,
                          25.w,
                          25.h + MediaQuery.of(context).padding.bottom,
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Explanation! 🔭',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: Color(0xFF333333),
                                ),
                              ),
                              SizedBox(height: 10.h),
                              const Text(
                                'Symbols in text, especially in informal settings like texting and social media, are often used to express emotions, indicate tone, or add a visual element to a message. They range from simple emoticons to more complex symbols, and their meanings can vary depending on the context.',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                  color: Color(0xFF333333),
                                ),
                              ),
                            ]),
                      );
                    });
              },
              child: Container(
                height: 74.h,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(vertical: 15.h),
                padding:
                    EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.5.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.green.shade200,
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Explanation! 🔭',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Color(0xFF333333),
                        ),
                      ),
                      SizedBox(height: 5.h),
                      const Text(
                        'Symbols in text, especially in informal settings like texting and social media, are often used to express emotions, indicate tone, or add a visual element to a message. They range from simple emoticons to more complex symbols, and their meanings can vary depending on the context.',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 10,
                          color: Color(0xFF333333),
                        ),
                      ),
                    ]),
              ),
            ),
          )
        ]),
      );
    });
  }
}
