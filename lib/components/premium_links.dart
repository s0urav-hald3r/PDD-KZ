import 'package:exam_app/config/store_config.dart';
import 'package:exam_app/controllers/purchase_controller.dart';
import 'package:exam_app/utils/utility_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PremiumLinks extends StatelessWidget {
  const PremiumLinks({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      InkWell(
        onTap: () {
          PurchaseController.instance.restorePurchases();
        },
        child: Text(
          'Restore Purchase'.tr,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 10,
            color: Color(0xFF6C6C6C),
            decoration: TextDecoration.underline,
          ),
        ),
      ),
      InkWell(
        onTap: () {
          UtilityFunctions.openUrl(privacyPolicyUrl);
        },
        child: Text(
          'Privacy Policy'.tr,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 10,
            color: Color(0xFF6C6C6C),
            decoration: TextDecoration.underline,
          ),
        ),
      ),
      InkWell(
        onTap: () {
          UtilityFunctions.openUrl(termsOfUseUrl);
        },
        child: Text(
          'Terms of Use'.tr,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 10,
            color: Color(0xFF6C6C6C),
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    ]);
  }
}
