import 'package:exam_app/components/progress_bar.dart';
import 'package:exam_app/components/quiz_appbar.dart';
import 'package:exam_app/config/colors.dart';
import 'package:exam_app/config/icons.dart';
import 'package:exam_app/config/images.dart';
import 'package:exam_app/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class QAPage extends StatelessWidget {
  const QAPage({super.key});

  String getSerial(int index) {
    switch (index) {
      case 0:
        return 'A';
      case 1:
        return 'B';
      case 2:
        return 'C';
      case 3:
        return 'D';
      default:
        return '';
    }
  }

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
              child: Column(children: [
                const ProgressBar(),
                SizedBox(
                  height: 180.h,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(favourite, fit: BoxFit.cover),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding:
                      EdgeInsets.symmetric(vertical: 25.h, horizontal: 25.w),
                  child: Column(children: [
                    const Text(
                      'Lorem ipsum dolor sit amet, consectetur adi piscing elit, sed do eiusmod tempor inci didu nt ut',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Color(0xFF333333),
                      ),
                    ),
                    SizedBox(height: 15.h),
                    ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        return Row(children: [
                          Container(
                            width: 40.w,
                            height: 40.w,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFD4D4D4),
                            ),
                            child: Center(
                              child: Text(
                                getSerial(index),
                                style: const TextStyle(
                                  color: whiteColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          const Text(
                            'Lorem Ipsume the dummy text xon',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Color(0xFF333333),
                            ),
                          ),
                        ]);
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 15.h);
                      },
                      itemCount: 4,
                    ),
                  ]),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Container(
                    width: 140.w,
                    height: 45.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: whiteColor,
                      border: Border.all(color: primaryColor),
                    ),
                    child: Center(
                      child: GradientText('Continue',
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
                ])
              ]),
            ),
          )
        ]),
      ),
    );
  }
}
