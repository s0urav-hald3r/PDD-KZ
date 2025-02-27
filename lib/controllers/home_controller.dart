// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum Plan { WEEKLY, MONTHLY, LIFETIME }

class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  final pageController = PageController();

  // Private variables
  final RxInt _homeIndex = 0.obs;
  final RxBool _isProUser = false.obs;

  // Getters
  int get homeIndex => _homeIndex.value;
  bool get isProUser => _isProUser.value;

  // Setters
  set homeIndex(value) => _homeIndex.value = value;
  set isProUser(value) => _isProUser.value = value;
}
