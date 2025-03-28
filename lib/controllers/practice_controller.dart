import 'dart:convert';

import 'package:exam_app/components/quiz_completion_dialog.dart';
import 'package:exam_app/controllers/timer_controller.dart';
import 'package:exam_app/models/practice_set_model.dart';
import 'package:exam_app/practice_set.dart';
import 'package:exam_app/services/navigator_key.dart';
import 'package:exam_app/services/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// A controller class that manages practice sets and their states in the exam app.
/// Handles practice set initialization, navigation, answer submission, and state persistence.
class PracticeController extends GetxController {
  /// Tab controller for managing question navigation
  late TabController tabController;

  /// Current practice set index (0-3) representing which set is active
  final RxInt _currentSetIndex = 0.obs;

  /// Current question index within the active practice set
  final RxInt _currentIndex = 0.obs;

  /// List of practice set models containing questions and their states
  final RxList<PracticeSetModel> _praciceSets = <PracticeSetModel>[].obs;

  /// Getters and setters for reactive state management
  int get currentSetIndex => _currentSetIndex.value;
  int get currentIndex => _currentIndex.value;
  List<PracticeSetModel> get praciceSets => _praciceSets;

  /// Total number of questions in the current practice set
  int get practiceSetLen => _praciceSets.length;

  /// Indicates if user is on the last question
  bool get isLastQuestion => currentIndex == practiceSetLen - 1;

  /// Checks if the current practice set is completed
  /// Returns true if either the timer has stopped or the set is marked as complete
  bool get isPracticeSetComplete {
    final controller =
        Get.find<TimerController>(tag: 'cardIndex_$currentSetIndex');
    if (controller.isTimerStop) return true;

    return LocalStorage.getData('complete_practice_set_$currentSetIndex') ??
        false;
  }

  set currentSetIndex(int value) => _currentSetIndex.value = value;
  set currentIndex(int value) => _currentIndex.value = value;
  set praciceSets(List<PracticeSetModel> value) => _praciceSets.value = value;

  /// Initializes the tab controller with saved question index
  /// @param vsync - Ticker provider for animation
  void initializeController(TickerProvider vsync) {
    tabController = TabController(
        initialIndex:
            LocalStorage.getData('current_question_$currentSetIndex') ?? 0,
        length: practiceSetLen,
        vsync: vsync);
  }

  /// Returns the practice set data based on the index
  /// @param index - Index of the practice set (0-3)
  /// @returns JSON data for the selected practice set
  getPracticeSetJson(int index) {
    switch (index) {
      case 0:
        return practiceSetOne;
      case 1:
        return practiceSetTwo;
      case 2:
        return practiceSetThree;
      case 3:
        return practiceSetFour;
      default:
        return practiceSetOne;
    }
  }

  /// Initializes or restores a practice set from local storage
  /// @param index - Index of the practice set to initialize
  void initializePracticeSet(int index) {
    currentSetIndex = index;
    var temp = <PracticeSetModel>[];

    String? savedPracticeSet =
        LocalStorage.getData('practice_set_$currentSetIndex');
    debugPrint('savedPracticeSet: $savedPracticeSet');

    if (savedPracticeSet != null) {
      // Load saved practice state
      temp = (jsonDecode(savedPracticeSet) as List)
          .map((e) => PracticeSetModel.fromJson(e as Map<String, dynamic>))
          .toList();

      currentIndex = LocalStorage.getData('current_question_$currentSetIndex');
    } else {
      // Initialize new practice set
      final josonBody = getPracticeSetJson(index);
      for (var element in josonBody) {
        temp.add(PracticeSetModel.fromJson(element));
      }

      currentIndex =
          LocalStorage.getData('current_question_$currentSetIndex') ?? 0;
    }

    praciceSets = temp;
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  /// Changes the current tab if the practice set is complete
  /// @param index - Target tab index
  void changeTab(int index) {
    if (isPracticeSetComplete) {
      tabController.index = index;
      currentIndex = index;
    } else {
      tabController.index = tabController.previousIndex;
    }
  }

  /// Handles question submission and practice set completion
  /// Saves state and shows completion dialog when all questions are answered
  void submitQuestion() {
    if (isPracticeSetComplete) return;

    if (!isLastQuestion) {
      currentIndex = currentIndex + 1;
      tabController.index = tabController.index + 1;
      _savePracticeState();
    } else {
      _savePracticeState();
      final controller =
          Get.find<TimerController>(tag: 'cardIndex_$currentSetIndex');
      controller.stopTimer();

      showDialog(
        context: NavigatorKey.context,
        barrierDismissible: false,
        builder: (context) => const QuizCompletionDialog(isTimeUp: false),
      );
      LocalStorage.setData('complete_practice_set_$currentSetIndex', true);
    }
  }

  /// Records user's answer for the current question
  /// @param index - Selected option index
  void doAnswer(int index) {
    if (isPracticeSetComplete) return;
    if (praciceSets[currentIndex].isSubmitted) return;

    praciceSets[currentIndex] = praciceSets[currentIndex].copyWith(
      submit: praciceSets[currentIndex].options[index],
      isSubmitted: true,
    );
  }

  /// Returns the index of the submitted answer
  /// @returns -1 if no answer submitted, otherwise returns the answer index
  int submitAnswerIndex() {
    if (praciceSets[currentIndex].submit == null) {
      return -1;
    }

    return praciceSets[currentIndex]
        .options
        .indexOf(praciceSets[currentIndex].submit!);
  }

  /// Returns the index of the correct answer
  /// @returns -1 if no answer submitted, otherwise returns the correct answer index
  int correctAnswerIndex() {
    if (praciceSets[currentIndex].submit == null) {
      return -1;
    }

    return praciceSets[currentIndex].options.indexWhere((opt) => opt.answer);
  }

  /// Saves the current practice state to local storage
  /// Persists both the practice set data and current question index
  void _savePracticeState() async {
    final practiceSetData = praciceSets.map((e) => e.toJson()).toList();
    await LocalStorage.setData(
        'practice_set_$currentSetIndex', jsonEncode(practiceSetData));
    await LocalStorage.setData(
        'current_question_$currentSetIndex', currentIndex);
  }
}
