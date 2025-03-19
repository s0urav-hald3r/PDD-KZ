import 'package:exam_app/components/practice_card.dart';
import 'package:exam_app/config/colors.dart';
import 'package:exam_app/utils/extension.dart';
import 'package:flutter/material.dart';

class PracticePage extends StatelessWidget {
  const PracticePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(gradient: containerGradient),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
              25.w,
              MediaQuery.of(context).padding.top + 20.h,
              0,
              20.h,
            ),
            child: const Text(
              'Practice',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: whiteColor,
              ),
            ),
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
              padding: EdgeInsets.fromLTRB(25.w, 15.h, 25.w, 0),
              child: ListView.builder(
                  itemCount: 2,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return PracticeCard(index: index);
                  }),
            ),
          )
        ]),
      ),
    );
  }
}
