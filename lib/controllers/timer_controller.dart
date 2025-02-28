import 'dart:async';
import 'package:get/get.dart';

class TimerController extends GetxController {
  static TimerController get instance => Get.find();

  RxInt min = 19.obs;
  RxInt sec = 59.obs;

  Timer? _timer;

  int get minute => min.value;
  int get second => sec.value;

  String get formattedTime =>
      '${minute.toString().padLeft(2, '0')}:${second.toString().padLeft(2, '0')}';

  void startTimer() {
    min.value = 19;
    sec.value = 59;

    _timer?.cancel(); // Cancel any existing timer before starting a new one

    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (sec.value > 0) {
        sec.value = sec.value - 1;
      } else if (min.value > 0) {
        min.value = min.value - 1;
        sec.value = 59;
      } else {
        stopTimer();
      }
    });
  }

  void stopTimer() {
    _timer?.cancel(); // Cancel the timer when stopping
    min.value = 0;
    sec.value = 0;
  }

  bool get isTimerStop => min.value == 0 && sec.value == 0;
}
