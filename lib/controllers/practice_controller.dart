import 'package:exam_app/models/practice_set_model.dart';
import 'package:exam_app/practice_set.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PracticeController extends GetxController {
  static PracticeController get instance => Get.find();

  late TabController tabController;

  void initializeController(TickerProvider vsync) {
    tabController = TabController(length: practiceSetLen, vsync: vsync);
  }

  getPracticeSetJson(int index) {
    switch (index) {
      case 0:
        return practiceSetOne;
    }
  }

  void initializePracticeSet(int index) {
    var temp = <PracticeSetModel>[];

    for (var element in getPracticeSetJson(index)) {
      temp.add(PracticeSetModel.fromJson(element));
    }

    praciceSets = temp;
  }

  final RxInt _currentIndex = 0.obs;
  final RxList<PracticeSetModel> _praciceSets = <PracticeSetModel>[].obs;

  int get currentIndex => _currentIndex.value;
  int get practiceSetLen => _praciceSets.length;
  List<PracticeSetModel> get praciceSets => _praciceSets;

  set currentIndex(value) => _currentIndex.value = value;
  set praciceSets(value) => _praciceSets.value = value;

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  void changeTab(int index) {
    tabController.index = tabController.previousIndex;
  }

  void nextQuestion() {
    if (currentIndex < praciceSets.length) {
      currentIndex = currentIndex + 1;
      tabController.index = tabController.index + 1;
    }
  }

  void doAnswer(int index) {
    praciceSets[currentIndex] = praciceSets[currentIndex].copyWith(
      submit: praciceSets[currentIndex].options[index],
      isSubmit: true,
    );
  }

  int submitAnswerIndex(int index) {
    if (praciceSets[currentIndex].submit == null) {
      return 0;
    }

    return praciceSets[currentIndex]
        .options
        .indexOf(praciceSets[currentIndex].submit!);
  }
}
