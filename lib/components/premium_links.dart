import 'package:exam_app/config/store_config.dart';
import 'package:exam_app/controllers/purchase_controller.dart';
import 'package:exam_app/utils/utility_functions.dart';
import 'package:flutter/material.dart';

class PremiumLinks extends StatelessWidget {
  const PremiumLinks({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      InkWell(
        onTap: () {
          PurchaseController.instance.restorePurchases();
        },
        child: const Text(
          'Restore Purchase',
          style: TextStyle(
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
        child: const Text(
          'Privacy Policy',
          style: TextStyle(
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
        child: const Text(
          'Terms of Use',
          style: TextStyle(
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
