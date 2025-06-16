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
  final RxInt _questionAttempted = 0.obs;
  final RxList<PracticeSetModel> _praciceSets = <PracticeSetModel>[].obs;

  int get currentSetIndex => _currentSetIndex.value;
  int get currentIndex => _currentIndex.value;
  int get questionAttempted => _questionAttempted.value;
  List<PracticeSetModel> get praciceSets => _praciceSets;

  int get practiceSetLen => _praciceSets.length;
  bool get isLastQuestion => currentIndex == practiceSetLen - 1;

  bool get isPracticeSetComplete {
    return LocalStorage.getData('complete_practice_set_$currentSetIndex') ??
        false;
  }

  set currentSetIndex(int value) => _currentSetIndex.value = value;
  set currentIndex(int value) => _currentIndex.value = value;
  set questionAttempted(int value) => _questionAttempted.value = value;
  set praciceSets(List<PracticeSetModel> value) => _praciceSets.value = value;

  void initializeController(TickerProvider vsync) {
    currentIndex =
        LocalStorage.getData('current_question_$currentSetIndex') ?? 0;
    tabController = TabController(
        initialIndex:
            LocalStorage.getData('current_question_$currentSetIndex') ?? 0,
        length: practiceSetLen,
        vsync: vsync);
  }

  List<PracticeSetModel> getPracticeSetJson(int index) {
    return HomeController.instance.questionSets[index + 1] ?? [];
  }

  void initializePracticeSet(int index) {
    currentSetIndex = index;
    var temp = <PracticeSetModel>[];

    String? savedPracticeSet =
        LocalStorage.getData('practice_set_$currentSetIndex');

    if (savedPracticeSet != null) {
      // Load saved practice state
      temp = (jsonDecode(savedPracticeSet) as List)
          .map((e) => PracticeSetModel.fromJson(e as Map<String, dynamic>))
          .toList();

      currentIndex =
          LocalStorage.getData('current_question_$currentSetIndex') ?? 0;

      questionAttempted =
          LocalStorage.getData('question_attempted_$currentSetIndex') ?? 0;
    } else {
      // Initialize new practice set
      temp = getPracticeSetJson(index);

      currentIndex = 0;
      questionAttempted = 0;
    }

    praciceSets = temp;
  }

  void changeTab(int index) {
    if (isPracticeSetComplete) {
      tabController.index = index;
      currentIndex = index;
    } else {
      tabController.index = tabController.previousIndex;
    }
  }

  void submitQuestion() async {
    if (isPracticeSetComplete) return;

    if (!isLastQuestion) {
      currentIndex = currentIndex + 1;
      tabController.index = tabController.index + 1;
      await LocalStorage.setData(
          'current_question_$currentSetIndex', currentIndex);
    } else {
      final controller =
          Get.find<TimerController>(tag: 'cardIndex_$currentSetIndex');
      controller.stopTimer();

      showDialog(
        context: NavigatorKey.context,
        barrierDismissible: false,
        builder: (context) => const QuizCompletionDialog(isTimeUp: false),
      ).then((_) {
        LocalStorage.setData('complete_practice_set_$currentSetIndex', true);
      });
    }
  }

  void doAnswer(int index) {
    if (isPracticeSetComplete) return;
    if (praciceSets[currentIndex].isSubmitted) return;

    questionAttempted = questionAttempted + 1;
    praciceSets[currentIndex] = praciceSets[currentIndex].copyWith(
      submit: praciceSets[currentIndex].options[index],
      isSubmitted: true,
    );

    _savePracticeState();
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

  void _savePracticeState() async {
    final practiceSetData = praciceSets.map((e) => e.toJson()).toList();
    await LocalStorage.setData(
        'practice_set_$currentSetIndex', jsonEncode(practiceSetData));
    await LocalStorage.setData(
        'question_attempted_$currentSetIndex', questionAttempted);
  }
}
