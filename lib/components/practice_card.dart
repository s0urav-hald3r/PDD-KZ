import 'package:exam_app/config/colors.dart';
import 'package:exam_app/config/icons.dart';
import 'package:exam_app/controllers/practice_controller.dart';
import 'package:exam_app/controllers/timer_controller.dart';
import 'package:exam_app/services/navigator_key.dart';
import 'package:exam_app/utils/extension.dart';
import 'package:exam_app/views/q_a_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class PracticeCard extends StatefulWidget {
  final int index;
  const PracticeCard({super.key, required this.index});

  @override
  State<PracticeCard> createState() => _PracticeCardState();
}

class _PracticeCardState extends State<PracticeCard> {
  late PracticeController controller;
  late TimerController timerController;

  @override
  void initState() {
    super.initState();
    controller =
        Get.find<PracticeController>(tag: 'controller_${widget.index}');
    timerController =
        Get.find<TimerController>(tag: 'controller_${widget.index}');
    controller.initializePracticeSet(widget.index);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (controller.practiceSetLen == 0) return;

        NavigatorKey.push(
          QAPage(controller: controller, timerController: timerController),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        constraints: BoxConstraints(
          minHeight: 85.h,
        ),
        margin: EdgeInsets.only(top: 10.h, left: 25.w, right: 25.w),
        decoration: BoxDecoration(
          color: greyColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(children: [
          const SizedBox(height: 13),
          Row(children: [
            if (widget.index != 0)
              SvgPicture.asset(lockTutorialsIcon)
            else
              const SizedBox(width: 5),
            const SizedBox(width: 10),
            GradientText(
              'Practice ${widget.index + 1}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              colors: const [primaryColor, primaryColor, secondaryColor],
            ),
            const Spacer(),
            Obx(() {
              return RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: '${controller.questionAnswered}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      color: blackColor,
                      fontSize: 16,
                    ),
                  ),
                  TextSpan(
                    text: '/${controller.practiceSetLen}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: blackColor,
                      fontSize: 16,
                    ),
                  )
                ]),
              );
            }),
            const SizedBox(width: 15),
          ]),
          SizedBox(height: 15.h),
          Row(
            children: [
              const SizedBox(width: 15),
              Obx(() {
                return LinearPercentIndicator(
                  width: 295.w,
                  lineHeight: 5.h,
                  percent: controller.practiceSetLen > 0
                      ? (controller.questionAnswered /
                          controller.practiceSetLen)
                      : 0.0,
                  padding: EdgeInsets.zero,
                  barRadius: const Radius.circular(10),
                  backgroundColor: whiteColor,
                  linearGradient: const LinearGradient(
                    colors: [primaryColor, secondaryColor],
                  ),
                );
              }),
              const SizedBox(width: 15),
            ],
          ),
          SizedBox(height: 15.h),
          Obx(() {
            return Row(children: [
              const SizedBox(width: 15),
              if (controller.questionAnswered > 0 &&
                  !controller.isPracticeSetComplete)
                Text(
                  'In Progress'.tr,
                  style: const TextStyle(
                    color: blackColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              if (controller.isPracticeSetComplete)
                Text(
                  'Answered'.tr,
                  style: const TextStyle(
                    color: blackColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              const Spacer(),
              if (controller.questionAnswered > 0 ||
                  controller.isPracticeSetComplete)
                InkWell(
                  onTap: () {
                    controller.resetPracticeSet();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    margin: EdgeInsets.only(right: 15.w),
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.refresh,
                      color: primaryColor,
                    ),
                  ),
                )
              else
                const SizedBox.shrink(),
            ]);
          }),
          const SizedBox(height: 15),
        ]),
      ),
    );
  }
}
