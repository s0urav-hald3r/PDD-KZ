import 'package:flutter/material.dart';

class PremiumLinks extends StatelessWidget {
  const PremiumLinks({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      InkWell(
        onTap: () {},
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
        onTap: () {},
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
        onTap: () {},
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
