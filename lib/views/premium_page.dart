import 'package:exam_app/components/premium_links.dart';
import 'package:exam_app/config/colors.dart';
import 'package:exam_app/config/icons.dart';
import 'package:exam_app/config/images.dart';
import 'package:exam_app/controllers/purchase_controller.dart';
import 'package:exam_app/services/navigator_key.dart';
import 'package:exam_app/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class PremiumPage extends StatelessWidget {
  const PremiumPage({super.key});

  @override
  Widget build(BuildContext context) {
    final purchaseController = PurchaseController.instance;

    return Scaffold(
      backgroundColor: greyColor,
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(children: [
            SizedBox(height: 20.h),
            InkWell(
              onTap: () => NavigatorKey.pop(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: Row(children: [
                  SvgPicture.asset(gradientLeftArrow),
                ]),
              ),
            ),
            SizedBox(height: 40.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: Text(
                'Try PDD For Free Quiz Unlock to all the Pro Features'.tr,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 30,
                  color: blackColor,
                ),
              ),
            ),
            SizedBox(height: 100.h),
            Image.asset(premiumBanner),
            SizedBox(height: 40.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: Text(
                'Unlock to all the Pro Features?'.tr,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                  color: blackColor,
                ),
              ),
            ),
            SizedBox(height: 25.h),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 45.h,
              margin: EdgeInsets.symmetric(horizontal: 25.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                gradient: containerGradient,
              ),
              child: ElevatedButton(
                  onPressed: () {
                    purchaseController.purchaseProduct();
                  },
                  child: Text(
                    'Yes, Activate'.tr,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: whiteColor,
                    ),
                  )),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: Text(
                '${'3 days free trial, after'.tr} ${purchaseController.storeProduct[0].priceString}/${'month'.tr}',
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: Color(0xFF6C6C6C),
                ),
              ),
            ),
            SizedBox(height: 25.h),
            const PremiumLinks()
          ]),
        ),
      ),
    );
  }
}
