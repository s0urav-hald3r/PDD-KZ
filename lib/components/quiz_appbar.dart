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

class QuizAppbar extends StatefulWidget {
  final PracticeController practiceController;
  final TimerController timerController;
  const QuizAppbar({
    super.key,
    required this.practiceController,
    required this.timerController,
  });

  @override
  State<QuizAppbar> createState() => _QuizAppbarState();
}

class _QuizAppbarState extends State<QuizAppbar> {
  @override
  void initState() {
    super.initState();
    widget.timerController
        .startTimer(setIndex: widget.practiceController.currentSetIndex);
  }

  @override
  void dispose() {
    super.dispose();
    widget.timerController
        .stopTimer(setIndex: widget.practiceController.currentSetIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          25.w, MediaQuery.of(context).padding.top + 20.h, 25.w, 20.h),
      child: Row(children: [
        InkWell(
            onTap: () {
              NavigatorKey.pop();
            },
            child: SvgPicture.asset(backArrowIcon)),
        const Spacer(flex: 5),
        const Text(
          'Quiz',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: whiteColor,
          ),
        ),
        const Spacer(flex: 3),
        Container(
          width: 72.w,
          height: 24.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: whiteColor,
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            SvgPicture.asset(timerIcon),
            SizedBox(width: 5.w),
            Obx(() {
              return GradientText(
                widget.timerController.formattedTime,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
                colors: const [primaryColor, primaryColor, secondaryColor],
              );
            })
          ]),
        )
      ]),
    );
  }
}
