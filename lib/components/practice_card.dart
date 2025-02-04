import 'package:exam_app/config/colors.dart';
import 'package:exam_app/config/icons.dart';
import 'package:exam_app/utils/extension.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class PracticeCard extends StatelessWidget {
  const PracticeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100.h,
      margin: EdgeInsets.only(top: 10.h),
      decoration: BoxDecoration(
        color: greyColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(children: [
        const SizedBox(height: 13),
        Row(children: [
          if (!kReleaseMode)
            SvgPicture.asset(lockTutorialsIcon)
          else
            const SizedBox(width: 5),
          const SizedBox(width: 10),
          GradientText(
            'Practice 1',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
            colors: const [primaryColor, primaryColor, secondaryColor],
          ),
          const Spacer(),
          RichText(
            text: const TextSpan(children: [
              TextSpan(
                text: '32',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: blackColor,
                  fontSize: 16,
                ),
              ),
              TextSpan(
                text: '/40',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: blackColor,
                  fontSize: 16,
                ),
              )
            ]),
          ),
          const SizedBox(width: 15),
        ]),
        const Spacer(),
        Row(
          children: [
            const SizedBox(width: 15),
            LinearPercentIndicator(
              width: 295.w,
              lineHeight: 5.h,
              percent: .67,
              padding: EdgeInsets.zero,
              barRadius: const Radius.circular(10),
              backgroundColor: whiteColor,
              linearGradient: const LinearGradient(
                colors: [primaryColor, secondaryColor],
              ),
            ),
            const SizedBox(width: 15),
          ],
        ),
        const Spacer(),
        const Row(children: [
          SizedBox(width: 15),
          Text(
            'Bastalmady',
            style: TextStyle(
              color: blackColor,
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
          Spacer(),
          Text(
            'Answered',
            style: TextStyle(
              color: blackColor,
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
          SizedBox(width: 15),
        ]),
        const SizedBox(height: 15),
      ]),
    );
  }
}
