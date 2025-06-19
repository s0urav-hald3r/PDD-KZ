import 'package:exam_app/config/colors.dart';
import 'package:exam_app/config/icons.dart';
import 'package:exam_app/controllers/home_controller.dart';
import 'package:exam_app/controllers/locale_controller.dart';
import 'package:exam_app/controllers/purchase_controller.dart';
import 'package:exam_app/services/navigator_key.dart';
import 'package:exam_app/utils/extension.dart';
import 'package:exam_app/views/premium_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static const String shareText =
      'PDD KZ - A helpful application designed to prepare users for the driving license exam in Kazaksthan:\nhttps://apps.apple.com/app/id6743699602';

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
            child: Text(
              'Settings'.tr,
              style: const TextStyle(
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
                  _card(1),
                  const Divider(height: 1),
                  _card(2),
                  const Divider(height: 1),
                  _card(3),
                  const Divider(height: 1),
                  _card(4),
                  if (!PurchaseController.instance.isPremium) ...[
                    const Divider(height: 1),
                    _card(5),
                  ]
                  // const Spacer(),
                  // const Text(
                  //   'Connect Now',
                  //   style: TextStyle(
                  //     fontSize: 18,
                  //     fontWeight: FontWeight.w700,
                  //   ),
                  // ),
                  // SizedBox(height: 20.h),
                  // Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  //   Image.asset(whatsapp, width: 40.w),
                  //   SizedBox(width: 15.w),
                  //   Image.asset(telegram, width: 40.w),
                  //   SizedBox(width: 15.w),
                  //   Image.asset(instagram, width: 40.w),
                  // ]),
                  // const Spacer(),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  String getTitle(int index) {
    switch (index) {
      case 1:
        return 'Language'.tr;
      case 2:
        return 'About the App'.tr;
      case 3:
        return 'Share'.tr;
      case 4:
        return 'Rate'.tr;
      case 5:
        return 'Get the full version'.tr;
      default:
        return '';
    }
  }

  Widget _card(int index) {
    return InkWell(
      onTap: () async {
        if (index == 1) {
          _showLanguageBottomSheet();
        }
        if (index == 2) {
          _showAboutAppBottomSheet();
        }
        if (index == 3) {
          try {
            await SharePlus.instance.share(
              ShareParams(
                subject: 'PDD KZ',
                text: shareText,
              ),
            );
          } catch (e) {
            debugPrint('Failed to share with friends');
          }
        }
        if (index == 4) {
          if (await InAppReview.instance.isAvailable()) {
            InAppReview.instance.requestReview();
          }
        }
        if (index == 5) {
          Get.to(() => const PremiumPage());
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
        child: Row(children: [
          Text(
            getTitle(index),
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: textColor,
            ),
          ),
          const Spacer(),
          SvgPicture.asset(gradientRightArrow, width: 20.w)
        ]),
      ),
    );
  }

  void _showLanguageBottomSheet() {
    showModalBottomSheet(
      context: NavigatorKey.context,
      backgroundColor: Colors.transparent,
      builder: (context) => const LanguageBottomSheet(),
    );
  }

  void _showAboutAppBottomSheet() {
    showModalBottomSheet(
      context: NavigatorKey.context,
      backgroundColor: Colors.transparent,
      builder: (context) => const AboutAppBottomSheet(),
    );
  }
}

class LanguageBottomSheet extends GetView<LocaleController> {
  const LanguageBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final currentLocale = Get.locale;

    return Container(
      decoration: const BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Language'.tr,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: textColor,
            ),
          ),
          SizedBox(height: 20.h),
          _languageOption(
            'English',
            'en',
            'US',
            isSelected: currentLocale?.languageCode == 'en',
            context: context,
            localeController: controller,
          ),
          SizedBox(height: 15.h),
          _languageOption(
            'Қазақша',
            'kk',
            'KZ',
            isSelected: currentLocale?.languageCode == 'kk',
            context: context,
            localeController: controller,
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _languageOption(
    String language,
    String languageCode,
    String countryCode, {
    required bool isSelected,
    required BuildContext context,
    required LocaleController localeController,
  }) {
    return InkWell(
      onTap: () {
        localeController.changeLocale(languageCode, countryCode);
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 15.w),
        decoration: BoxDecoration(
          color: isSelected ? Colors.grey.shade100 : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? primaryColor : Colors.grey.shade300,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Text(
              language,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: textColor,
              ),
            ),
            const Spacer(),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: primaryColor,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}

class AboutAppBottomSheet extends GetView<HomeController> {
  const AboutAppBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About the App'.tr,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: textColor,
            ),
          ),
          SizedBox(height: 25.h),
          const Text(
            'PDD KZ',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: primaryColor,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            '${'Version'.tr}: ${controller.version}+${controller.buildNumber}',
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: textColor,
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            '${'Description'.tr}:',
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: textColor,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            'PDD KZ Description'.tr,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: textColor,
            ),
          ),
          SizedBox(height: 30.h),
        ],
      ),
    );
  }
}
