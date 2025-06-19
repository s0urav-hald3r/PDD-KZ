import 'package:exam_app/services/navigator_key.dart';
import 'package:exam_app/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:exam_app/config/colors.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class QuizCompletionDialog extends StatelessWidget {
  final bool isTimeUp;
  const QuizCompletionDialog({super.key, this.isTimeUp = true});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 25.w),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                spreadRadius: 1,
              ),
            ]),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 25.w),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
            width: 70.w,
            height: 70.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: containerGradient,
            ),
            child: Icon(
              isTimeUp ? Icons.timer_off : Icons.check_circle,
              color: whiteColor,
              size: 40,
            ),
          ),
          SizedBox(height: 25.h),
          GradientText(
            isTimeUp ? 'Time\'s Up!' : 'Quiz Completed!',
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
            colors: const [primaryColor, secondaryColor],
          ),
          SizedBox(height: 20.h),
          Text(
            isTimeUp
                ? 'Your quiz session has ended. You can review your answers now.'
                : 'Congratulations! You have completed the quiz successfully.',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
              height: 1.5,
            ),
          ),
          SizedBox(height: 30.h),
          InkWell(
            onTap: () {
              NavigatorKey.pop();
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.6,
              height: 50.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: containerGradient,
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  const Icon(
                    Icons.assessment_outlined,
                    color: whiteColor,
                    size: 20,
                  ),
                  SizedBox(width: 10.w),
                  const Text(
                    'Review Answers',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: whiteColor,
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
