import 'dart:async';
import 'package:exam_app/controllers/practice_controller.dart';
import 'package:exam_app/services/navigator_key.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exam_app/services/local_storage.dart';
import 'package:exam_app/components/quiz_completion_dialog.dart';

class TimerController extends GetxController {
  RxInt sec = (30 * 60).obs;

  Timer? _timer;

  int get second => sec.value;

  // Getter to format time as MM:SS
  String get formattedTime {
    final minutes = (sec.value ~/ 60).toString().padLeft(2, '0');
    final seconds = (sec.value % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  void startTimer({int? setIndex}) {
    if (setIndex != null) {
      // Try to restore saved timer state
      final savedSec = LocalStorage.getData('timer_$setIndex');

      if (savedSec != null) {
        sec.value = savedSec;
      } else {
        sec.value = 30 * 60;
      }
    } else {
      sec.value = 30 * 60;
    }

    _timer?.cancel(); // Cancel any existing timer before starting a new one

    sec.value = sec.value - 1;
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (sec.value > 0) {
        sec.value = sec.value - 1;
        LocalStorage.setData('timer_$setIndex', sec.value);
      } else {
        // Use Get.find to get the current context and show dialog
        showDialog(
          context: NavigatorKey.context,
          barrierDismissible: false,
          builder: (context) => const QuizCompletionDialog(),
        );

        stopTimer();
        Get.find<PracticeController>(tag: 'controller_$setIndex').isComplete =
            true;
        LocalStorage.setData('complete_set_$setIndex', true);
      }
    });
  }

  void stopTimer() {
    _timer?.cancel(); // Cancel the timer when stopping
    sec.value = 0;
  }

  bool get isTimerStop => sec.value == 0;

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
