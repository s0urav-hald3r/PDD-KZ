import 'package:exam_app/config/colors.dart';
import 'package:exam_app/config/images.dart';
import 'package:exam_app/utils/extension.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
              'Welcome to PDD',
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
              padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 25.h),
              child: Wrap(
                spacing: 10.w,
                runSpacing: 10.h,
                children: List.generate(4, (index) {
                  return Container(
                    width: 157.w,
                    height: 170.h,
                    decoration: BoxDecoration(
                      color: greyColor,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            [homeOne, homeTwo, homeThree, homeFour][index],
                            width: 80.w,
                          ),
                          SizedBox(height: 20.h),
                          Text(
                            [
                              'Таңдаулылар',
                              'КР ЖКЕ',
                              'АвтоДром\nсабақтары',
                              'Emtihan\nTapsyru'
                            ][index],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        ]),
                  );
                }),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
