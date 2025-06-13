import 'package:exam_app/config/colors.dart';
import 'package:exam_app/config/icons.dart';
import 'package:exam_app/config/images.dart';
import 'package:exam_app/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

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
              MediaQuery.of(context).padding.top + 15.h,
              0,
              15.h,
            ),
            child: const Text(
              'Settings',
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
              child: Column(
                children: [
                  _card(),
                  const Divider(height: 1),
                  _card(),
                  const Divider(height: 1),
                  _card(),
                  const Divider(height: 1),
                  _card(),
                  const Spacer(),
                  const Text(
                    'Connect Now',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Image.asset(whatsapp, width: 40.w),
                    SizedBox(width: 15.w),
                    Image.asset(telegram, width: 40.w),
                    SizedBox(width: 15.w),
                    Image.asset(instagram, width: 40.w),
                  ]),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Container _card() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
      child: Row(children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            'Country',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: blackColor,
            ),
          ),
          Container(
            color: Colors.transparent,
            width: 275.w,
            child: const Text(
              'Lorem the dummy text formated as per report',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Color(0xFFAFADB3),
              ),
            ),
          ),
        ]),
        const Spacer(),
        SvgPicture.asset(gradientRightArrow)
      ]),
    );
  }
}
