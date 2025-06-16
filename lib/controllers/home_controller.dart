// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:exam_app/models/practice_set_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  final pageController = PageController();

  // Private variables
  final RxInt _homeIndex = 0.obs;
  final RxBool _isProUser = false.obs;
  final RxBool _isLoading = false.obs;
  final RxMap<int, List<PracticeSetModel>> _questionSets =
      <int, List<PracticeSetModel>>{}.obs;

  // Getters
  int get homeIndex => _homeIndex.value;
  bool get isProUser => _isProUser.value;
  bool get isLoading => _isLoading.value;
  Map<int, List<PracticeSetModel>> get questionSets => _questionSets;

  // Setters
  set homeIndex(value) => _homeIndex.value = value;
  set isProUser(value) => _isProUser.value = value;
  set isLoading(value) => _isLoading.value = value;
  set questionSets(value) => _questionSets.value = value;

  @override
  void onInit() {
    fetchQuestionSet();
    super.onInit();
  }

  // Methods
  Future<void> fetchQuestionSet() async {
    try {
      isLoading = true;
      final response = await http.get(
        Uri.parse('https://pdd-kz-murex.vercel.app/api/question'),
      );
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        for (var element in jsonData) {
          final temp = <PracticeSetModel>[];
          for (var e in element['data']) {
            temp.add(PracticeSetModel.fromJson(e));
          }
          questionSets[element['questionSet']] = temp;
        }
      }
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
    } finally {
      isLoading = false;
    }
  }
}
