import 'dart:async';
import 'package:exam_app/services/navigator_key.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exam_app/services/local_storage.dart';
import 'package:exam_app/components/quiz_completion_dialog.dart';

class TimerController extends GetxController {
  RxInt min = 04.obs;
  RxInt sec = 59.obs;

  Timer? _timer;

  int get minute => min.value;
  int get second => sec.value;

  String get formattedTime =>
      '${minute.toString().padLeft(2, '0')}:${second.toString().padLeft(2, '0')}';

  void startTimer({int? setIndex}) {
    if (setIndex != null) {
      // Try to restore saved timer state
      final savedMin = LocalStorage.getData('timer_min_$setIndex');
      final savedSec = LocalStorage.getData('timer_sec_$setIndex');

      if (savedMin != null && savedSec != null) {
        min.value = savedMin;
        sec.value = savedSec;
      } else {
        min.value = 04;
        sec.value = 59;
      }
    } else {
      min.value = 04;
      sec.value = 59;
    }

    _timer?.cancel(); // Cancel any existing timer before starting a new one

    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (sec.value > 0) {
        sec.value = sec.value - 1;
      } else if (min.value > 0) {
        min.value = min.value - 1;
        sec.value = 59;
      } else {
        // Use Get.find to get the current context and show dialog
        showDialog(
          context: NavigatorKey.context,
          barrierDismissible: false,
          builder: (context) => const QuizCompletionDialog(),
        );

        stopTimer();
        LocalStorage.setData('complete_practice_set_$setIndex', true);
      }
    });
  }

  void stopTimer({int? setIndex}) {
    _timer?.cancel(); // Cancel the timer when stopping

    if (setIndex != null) {
      // Save current timer state
      LocalStorage.setData('timer_min_$setIndex', min.value);
      LocalStorage.setData('timer_sec_$setIndex', sec.value);
    }

    min.value = 0;
    sec.value = 0;
  }

  void clearSavedTimer(int setIndex) {
    LocalStorage.removeData('timer_min_$setIndex');
    LocalStorage.removeData('timer_sec_$setIndex');
  }

  bool get isTimerStop => min.value == 0 && sec.value == 0;
}
