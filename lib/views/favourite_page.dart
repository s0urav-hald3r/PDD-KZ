import 'package:exam_app/config/colors.dart';
import 'package:exam_app/config/images.dart';
import 'package:exam_app/utils/extension.dart';
import 'package:flutter/material.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

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
              'Favourite',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: whiteColor,
              ),
            ),
          ),
          Expanded(
            child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                padding: EdgeInsets.fromLTRB(25.w, 25.h, 25.w, 0),
                child: SingleChildScrollView(
                  child: Wrap(
                    runSpacing: 10.h,
                    spacing: 10.w,
                    children: List.generate(7, (index) {
                      return Container(
                        width: 157.w,
                        height: 170.h,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F7FA),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 10.h),
                        child: Column(children: [
                          Container(
                            height: 90.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: const DecorationImage(
                                image: AssetImage(favourite),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          SizedBox(
                            width: 137.w,
                            child: const Text(
                              'A quick brown fox jumps over the lazy dog A quick brown fox jumps over the lazy dog',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: textColor,
                              ),
                            ),
                          )
                        ]),
                      );
                    }),
                  ),
                )),
          ),
        ]),
      ),
    );
  }
}
