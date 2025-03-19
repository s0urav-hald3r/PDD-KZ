import 'package:exam_app/config/colors.dart';
import 'package:exam_app/controllers/practice_controller.dart';
import 'package:exam_app/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProgressBar extends StatefulWidget {
  const ProgressBar({super.key});

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar>
    with SingleTickerProviderStateMixin {
  final controller = PracticeController.instance;

  @override
  void initState() {
    super.initState();
    controller.initializeController(this);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 25.h),
      child: Obx(() {
        return TabBar(
          controller: controller.tabController,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          padding: EdgeInsets.zero,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorWeight: 2,
          labelPadding: EdgeInsets.symmetric(horizontal: 7.w),
          indicatorColor: primaryColor,
          onTap: controller.changeTab,
          tabs: controller.praciceSets.map((tab) {
            return Tab(
              child: Container(
                width: 32.w,
                height: 32.w,
                decoration: tab.no == (controller.currentIndex + 1)
                    ? BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: containerGradient,
                      )
                    : tab.isSubmit
                        ? tab.submit ==
                                tab.options.firstWhere((e) => e.ans == true)
                            ? const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.green,
                              )
                            : const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red,
                              )
                        : const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFD4D4D4),
                          ),
                child: Center(
                  child: Text(
                    '${tab.no}',
                    style: const TextStyle(
                      color: whiteColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        );
      }),
    );
  }
}
