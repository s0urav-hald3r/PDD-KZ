import 'package:exam_app/components/progress_bar.dart';
import 'package:exam_app/components/quiz_appbar.dart';
import 'package:exam_app/config/colors.dart';
import 'package:flutter/material.dart';

class QAPage extends StatelessWidget {
  const QAPage({super.key});

  @override
  Widget build(BuildContext context) {
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
              child: const Column(children: [ProgressBar()]),
            ),
          )
        ]),
      ),
    );
  }
}
