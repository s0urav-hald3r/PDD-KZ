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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Container(
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
            ElevatedButton(
              onPressed: () {
                NavigatorKey.pop();
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(120.w, 45.h),
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: const Text(
                'Review Answers',
                style: TextStyle(
                  color: whiteColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ]),
        ]),
      ),
    );
  }
}
