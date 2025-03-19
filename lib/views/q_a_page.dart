import 'package:exam_app/components/progress_bar.dart';
import 'package:exam_app/components/quiz_appbar.dart';
import 'package:exam_app/config/colors.dart';
import 'package:exam_app/config/icons.dart';
import 'package:exam_app/config/images.dart';
import 'package:exam_app/controllers/practice_controller.dart';
import 'package:exam_app/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class QAPage extends StatelessWidget {
  const QAPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = PracticeController.instance;

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(gradient: containerGradient),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const QuizAppbar(),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Column(children: [
                const ProgressBar(),
                SizedBox(
                  height: 180.h,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(favourite, fit: BoxFit.cover),
                ),
                Obx(() {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    padding:
                        EdgeInsets.symmetric(vertical: 25.h, horizontal: 25.w),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller
                                .praciceSets[controller.currentIndex].question,
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
                              return InkWell(
                                onTap: () {
                                  controller.doAnswer(index);
                                },
                                child: Row(children: [
                                  Container(
                                    width: 40.w,
                                    height: 40.w,
                                    decoration: controller
                                                    .praciceSets[
                                                        controller.currentIndex]
                                                    .submit !=
                                                null &&
                                            controller
                                                    .submitAnswerIndex(index) ==
                                                index
                                        ? BoxDecoration(
                                            shape: BoxShape.circle,
                                            gradient: containerGradient,
                                          )
                                        : const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(0xFFD4D4D4),
                                          ),
                                    child: Center(
                                      child: Text(
                                        controller
                                            .praciceSets[
                                                controller.currentIndex]
                                            .options[index]
                                            .sl,
                                        style: const TextStyle(
                                          color: whiteColor,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  controller
                                                  .praciceSets[
                                                      controller.currentIndex]
                                                  .submit !=
                                              null &&
                                          controller.submitAnswerIndex(index) ==
                                              index
                                      ? GradientText(
                                          controller
                                              .praciceSets[
                                                  controller.currentIndex]
                                              .options[index]
                                              .qus,
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
                                          controller
                                              .praciceSets[
                                                  controller.currentIndex]
                                              .options[index]
                                              .qus,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                            color: Color(0xFF333333),
                                          ),
                                        ),
                                ]),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 15.h);
                            },
                            itemCount: controller
                                .praciceSets[controller.currentIndex]
                                .options
                                .length,
                          ),
                        ]),
                  );
                }),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  InkWell(
                    onTap: controller.nextQuestion,
                    child: Container(
                      width: 140.w,
                      height: 45.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: whiteColor,
                        border: Border.all(color: primaryColor),
                      ),
                      child: Center(
                        child: GradientText('Continue',
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
                  Container(
                    width: 45.w,
                    height: 45.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      gradient: containerGradient,
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        unSelectedFavIcon,
                        color: whiteColor,
                      ),
                    ),
                  ),
                ])
              ]),
            ),
          )
        ]),
      ),
    );
  }
}
