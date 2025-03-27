import 'package:exam_app/config/colors.dart';
import 'package:exam_app/controllers/practice_controller.dart';
import 'package:exam_app/models/practice_set_model.dart';
import 'package:exam_app/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProgressBar extends StatefulWidget {
  final PracticeController controller;
  const ProgressBar({super.key, required this.controller});

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    widget.controller.initializeController(this);
  }

  BoxDecoration getTabDecoration(PracticeSetModel tab) {
    // Case 1: Current tab (active tab)
    if (tab.no == (widget.controller.currentIndex + 1)) {
      return BoxDecoration(
        shape: BoxShape.circle,
        gradient: containerGradient,
      );
    }
    // Case 2: Submitted tab
    else if (tab.isSubmitted) {
      // Correct answer
      if (tab.submit == tab.options.firstWhere((e) => e.answer)) {
        return const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.green,
        );
      }
      // Wrong answer
      else {
        return const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red,
        );
      }
    }
    // Case 3: Default/unselected tab
    else {
      return const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFFD4D4D4),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: Obx(() {
        return TabBar(
          controller: widget.controller.tabController,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          padding: EdgeInsets.zero,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorWeight: 2,
          labelPadding: EdgeInsets.symmetric(horizontal: 7.w),
          indicatorColor: primaryColor,
          onTap: widget.controller.changeTab,
          tabs: widget.controller.praciceSets.map((tab) {
            return Tab(
              child: Container(
                width: 32.w,
                height: 32.w,
                // Usage example:
                decoration: getTabDecoration(tab),
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
