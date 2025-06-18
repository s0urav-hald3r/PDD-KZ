import 'package:exam_app/components/progress_bar.dart';
import 'package:exam_app/components/question.dart';
import 'package:exam_app/components/quiz_appbar.dart';
import 'package:exam_app/config/colors.dart';
import 'package:exam_app/config/icons.dart';
import 'package:exam_app/controllers/practice_controller.dart';
import 'package:exam_app/controllers/timer_controller.dart';
import 'package:exam_app/services/navigator_key.dart';
import 'package:exam_app/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class QAPage extends StatelessWidget {
  final PracticeController controller;
  final TimerController timerController;
  const QAPage({
    super.key,
    required this.controller,
    required this.timerController,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(gradient: containerGradient),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          QuizAppbar(
            practiceController: controller,
            timerController: timerController,
          ),
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
                SizedBox(height: 15.h),
                ProgressBar(controller: controller),
                Question(controller: controller),
                Obx(() {
                  if (controller.isPracticeSetComplete) {
                    return InkWell(
                      onTap: () {
                        NavigatorKey.pop();
                      },
                      child: Container(
                        width: 140.w,
                        height: 45.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          gradient: containerGradient,
                        ),
                        child: const Center(
                          child: Text(
                            'Back to practice',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: whiteColor,
                            ),
                          ),
                        ),
                      ),
                    );
                  }

                  return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: controller.submitQuestion,
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
                                  controller.isLastQuestion
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
                      ]);
                }),
                // SizedBox(height: MediaQuery.of(context).padding.bottom)
              ]),
            ),
          )
        ]),
      ),
    );
  }
}
