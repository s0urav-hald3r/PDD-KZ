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
      child: Container(
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(15),
        ),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 25.w),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          GradientText(
            isTimeUp ? 'Time\'s Up!' : 'Quiz Completed!',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            colors: const [primaryColor, primaryColor, secondaryColor],
          ),
          SizedBox(height: 15.h),
          Text(
            isTimeUp
                ? 'Your quiz session has ended.'
                : 'You have completed the quiz.',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 20.h),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            InkWell(
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
                    'Review answers',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: whiteColor,
                    ),
                  ),
                ),
              ),
            )
          ]),
        ]),
      ),
    );
  }
}
