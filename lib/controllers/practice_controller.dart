import 'dart:convert';

import 'package:exam_app/components/quiz_completion_dialog.dart';
import 'package:exam_app/components/quiz_submitted.dart';
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
  final RxBool _isComplete = false.obs;
  final RxList<PracticeSetModel> _praciceSets = <PracticeSetModel>[].obs;

  int get currentSetIndex => _currentSetIndex.value;
  int get currentIndex => _currentIndex.value;
  int get questionAnswered => _questionAnswered.value;
  bool get isComplete => _isComplete.value;
  List<PracticeSetModel> get praciceSets => _praciceSets;

  int get practiceSetLen => _praciceSets.length;
  bool get isLastQuestion => currentIndex == practiceSetLen - 1;
  bool get isPracticeSetComplete =>
      LocalStorage.getData('complete_set_$currentSetIndex') ?? false;

  set currentSetIndex(int value) => _currentSetIndex.value = value;
  set currentIndex(int value) => _currentIndex.value = value;
  set questionAnswered(int value) => _questionAnswered.value = value;
  set isComplete(bool value) => _isComplete.value = value;
  set praciceSets(List<PracticeSetModel> value) => _praciceSets.value = value;

  void initializeController(TickerProvider vsync) {
    tabController = TabController(
      initialIndex: currentIndex,
      length: practiceSetLen,
      vsync: vsync,
    );
  }

  void initializePracticeSet(int index) {
    var temp = <PracticeSetModel>[];

    if (index == 13) {
      currentSetIndex = index;
      currentIndex = 0;
      isComplete = false;

      temp = HomeController.instance.sequentialFavoriteSets;

      praciceSets = temp;
    } else {
      currentSetIndex = index;

      currentIndex =
          LocalStorage.getData('current_index_$currentSetIndex') ?? 0;
      questionAnswered = LocalStorage.getData('answered_$currentSetIndex') ?? 0;
      isComplete =
          LocalStorage.getData('complete_set_$currentSetIndex') ?? false;

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
  }

  void resetPracticeSet(int index) async {
    // First clear all local storage data for this set
    await LocalStorage.removeData('current_index_$index');
    await LocalStorage.removeData('answered_$index');
    await LocalStorage.removeData('set_$index');
    await LocalStorage.removeData('complete_set_$index');
    await LocalStorage.removeData('timer_$index');

    // Set current index and answered questions to 0
    currentIndex = 0;
    questionAnswered = 0;
    isComplete = false;

    // Get fresh questions from HomeController without previous answers
    List<PracticeSetModel> freshQuestions = [];

    try {
      // Get a fresh copy of questions from the HomeController
      freshQuestions =
          HomeController.instance.questionSets[index + 1]?.map((q) {
                // Create new instances to ensure no previous state is carried over
                return PracticeSetModel(
                  no: q.no,
                  question: q.question,
                  mediaFile: q.mediaFile,
                  options: q.options,
                  explanation: q.explanation,
                  isSubmitted: false, // Reset submission state
                  isFavorite: q.isFavorite, // Preserve favorite status
                  submit: null, // Clear any submitted answer
                );
              }).toList() ??
              [];
    } catch (e) {
      debugPrint('Error resetting practice set: $e');
      freshQuestions = [];
    }

    // Update the practice sets with fresh questions
    praciceSets = freshQuestions;
  }

  void changeTab(int index) {
    currentIndex = index;
    tabController.index = index;

    if (currentSetIndex == 13) return;

    LocalStorage.setData('current_index_$currentSetIndex', currentIndex);
  }

  void submitQuestion() async {
    if (isPracticeSetComplete) return;

    if (!isLastQuestion) {
      currentIndex = currentIndex + 1;
      tabController.index = tabController.index + 1;

      if (currentSetIndex != 13) {
        await LocalStorage.setData(
            'current_index_$currentSetIndex', currentIndex);
      }
    } else {
      final controller =
          Get.find<TimerController>(tag: 'controller_$currentSetIndex');
      controller.stopTimer();

      showDialog(
        context: NavigatorKey.context,
        barrierDismissible: false,
        builder: (context) => const QuizCompletionDialog(isTimeUp: false),
      ).then((_) {
        isComplete = true;

        if (currentSetIndex != 13) {
          LocalStorage.setData('complete_set_$currentSetIndex', isComplete);
        } else {
          HomeController.instance.isNavbarHide = false;
        }
      });
    }
  }

  void doAnswer(int index) async {
    if (isPracticeSetComplete) {
      showDialog(
        context: NavigatorKey.context,
        builder: (context) => const QuizSubmitted(),
      );
      return;
    }

    if (praciceSets[currentIndex].isSubmitted) return;

    praciceSets[currentIndex] = praciceSets[currentIndex].copyWith(
      submit: praciceSets[currentIndex].options[index],
      isSubmitted: true,
    );

    if (currentSetIndex == 13) return;

    questionAnswered = questionAnswered + 1;

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
      HomeController.instance.addToFavorite(
          praciceSets[currentIndex].copyWith(isSubmitted: false, submit: null));
    } else {
      HomeController.instance.removeFromFavorite(praciceSets[currentIndex]);
    }

    if (currentSetIndex != 13) {
      final practiceSetData = praciceSets.map((e) => e.toJson()).toList();
      await LocalStorage.setData(
          'set_$currentSetIndex', jsonEncode(practiceSetData));
    }
  }
}
