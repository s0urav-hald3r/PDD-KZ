import 'package:exam_app/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:exam_app/config/colors.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class QuizSubmitted extends StatelessWidget {
  const QuizSubmitted({super.key});

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
            'Quiz Submitted!',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            colors: const [primaryColor, primaryColor, secondaryColor],
          ),
          SizedBox(height: 15.h),
          const Text(
            'Your quiz has been already submitted. You can only review your answers in the practice page & not allowed to answer again.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ]),
      ),
    );
  }
}
