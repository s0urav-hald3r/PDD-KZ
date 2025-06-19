import 'dart:convert';

import 'package:exam_app/components/quiz_completion_dialog.dart';
import 'package:exam_app/controllers/home_controller.dart';
import 'package:exam_app/controllers/timer_controller.dart';
import 'package:exam_app/models/practice_set_model.dart';
import 'package:exam_app/services/navigator_key.dart';
import 'package:exam_app/services/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PracticeController extends GetxController {
  late TabController tabController;

  final RxInt _currentSetIndex = 0.obs;
  final RxInt _currentIndex = 0.obs;
  final RxInt _questionAnswered = 0.obs;
  final RxList<PracticeSetModel> _praciceSets = <PracticeSetModel>[].obs;

  int get currentSetIndex => _currentSetIndex.value;
  int get currentIndex => _currentIndex.value;
  int get questionAnswered => _questionAnswered.value;
  List<PracticeSetModel> get praciceSets => _praciceSets;

  int get practiceSetLen => _praciceSets.length;
  bool get isLastQuestion => currentIndex == practiceSetLen - 1;
  bool get isPracticeSetComplete =>
      LocalStorage.getData('complete_set_$currentSetIndex') ?? false;

  set currentSetIndex(int value) => _currentSetIndex.value = value;
  set currentIndex(int value) => _currentIndex.value = value;
  set questionAnswered(int value) => _questionAnswered.value = value;
  set praciceSets(List<PracticeSetModel> value) => _praciceSets.value = value;

  @override
  void onInit() {
    super.onInit();
    currentIndex = LocalStorage.getData('current_index_$currentSetIndex') ?? 0;
    questionAnswered = LocalStorage.getData('answered_$currentSetIndex') ?? 0;
  }

  void initializeController(TickerProvider vsync) {
    tabController = TabController(
      initialIndex: currentIndex,
      length: practiceSetLen,
      vsync: vsync,
    );
  }

  void initializePracticeSet(int index) {
    currentSetIndex = index;
    var temp = <PracticeSetModel>[];

    String? savedPracticeSet = LocalStorage.getData('set_$currentSetIndex');

    if (savedPracticeSet != null) {
      // Load saved practice state
      temp = (jsonDecode(savedPracticeSet) as List)
          .map((e) => PracticeSetModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      // Initialize new practice set
      temp = HomeController.instance.questionSets[index + 1] ?? [];

      currentIndex = 0;
      questionAnswered = 0;
    }

    praciceSets = temp;
  }

  void changeTab(int index) {
    currentIndex = index;
    tabController.index = index;
    LocalStorage.setData('current_index_$currentSetIndex', currentIndex);
  }

  void submitQuestion() async {
    if (isPracticeSetComplete) return;

    if (!isLastQuestion) {
      currentIndex = currentIndex + 1;
      tabController.index = tabController.index + 1;
      await LocalStorage.setData(
          'current_index_$currentSetIndex', currentIndex);
    } else {
      final controller =
          Get.find<TimerController>(tag: 'controller_$currentSetIndex');
      controller.stopTimer();

      showDialog(
        context: NavigatorKey.context,
        barrierDismissible: false,
        builder: (context) => const QuizCompletionDialog(isTimeUp: false),
      ).then((_) {
        LocalStorage.setData('complete_set_$currentSetIndex', true);
      });
    }
  }

  void doAnswer(int index) async {
    if (isPracticeSetComplete) return;
    if (praciceSets[currentIndex].isSubmitted) return;

    questionAnswered = questionAnswered + 1;
    praciceSets[currentIndex] = praciceSets[currentIndex].copyWith(
      submit: praciceSets[currentIndex].options[index],
      isSubmitted: true,
    );

    final practiceSetData = praciceSets.map((e) => e.toJson()).toList();
    await LocalStorage.setData(
        'set_$currentSetIndex', jsonEncode(practiceSetData));
    await LocalStorage.setData('answered_$currentSetIndex', questionAnswered);
  }

  int submitAnswerIndex() {
    if (praciceSets[currentIndex].submit == null) {
      return -1;
    }

    return praciceSets[currentIndex]
        .options
        .indexOf(praciceSets[currentIndex].submit!);
  }

  int correctAnswerIndex() {
    if (praciceSets[currentIndex].submit == null) {
      return -1;
    }

    return praciceSets[currentIndex].options.indexWhere((opt) => opt.answer);
  }

  void toggleFavorite() async {
    praciceSets[currentIndex] = praciceSets[currentIndex].copyWith(
      isFavorite: !praciceSets[currentIndex].isFavorite,
    );

    if (praciceSets[currentIndex].isFavorite) {
      HomeController.instance.addToFavorite(praciceSets[currentIndex]);
    } else {
      HomeController.instance.removeFromFavorite(praciceSets[currentIndex]);
    }

    final practiceSetData = praciceSets.map((e) => e.toJson()).toList();
    await LocalStorage.setData(
        'set_$currentSetIndex', jsonEncode(practiceSetData));
  }
}
