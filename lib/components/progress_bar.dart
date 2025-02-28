import 'package:exam_app/config/colors.dart';
import 'package:exam_app/utils/extension.dart';
import 'package:flutter/material.dart';

class ProgressBar extends StatefulWidget {
  const ProgressBar({super.key});

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar>
    with SingleTickerProviderStateMixin {
  int tabLength = 40;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabLength, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 25.h),
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        padding: EdgeInsets.zero,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorWeight: 2,
        labelPadding: EdgeInsets.symmetric(horizontal: 7.w),
        indicatorColor: primaryColor,
        tabs: List.generate(
          tabLength,
          (index) => Tab(
            child: Container(
              width: 32.w,
              height: 32.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: containerGradient,
              ),
              child: Center(
                child: Text(
                  '${index + 1}',
                  style: const TextStyle(
                    color: whiteColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
