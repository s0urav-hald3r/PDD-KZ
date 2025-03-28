import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

class NavigatorKey {
  NavigatorKey._();

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static BuildContext context = navigatorKey.currentContext!;

  static String? previousRoute;
  static String? currentRoute;
  static bool _isNavigating = false;

  static bool _canNavigate() {
    if (_isNavigating) return false;
    _isNavigating = true;
    Future.delayed(
        const Duration(milliseconds: 500), () => _isNavigating = false);
    return true;
  }

  static Future<dynamic>? push(dynamic route, {String? routeName}) {
    if (!_canNavigate()) return null;

    previousRoute = Get.currentRoute;
    currentRoute = routeName;

    return navigatorKey.currentState?.push(PageTransition(
      child: route,
      type: PageTransitionType.fade,
      duration: const Duration(milliseconds: 250),
    ));
  }

  static Future<dynamic>? pushReplacement(dynamic route, {String? routeName}) {
    if (!_canNavigate()) return null;

    previousRoute = Get.currentRoute;
    currentRoute = routeName;

    return navigatorKey.currentState?.pushReplacement(PageTransition(
      child: route,
      type: PageTransitionType.fade,
      duration: const Duration(milliseconds: 250),
    ));
  }

  static Future<dynamic>? pushAndRemoveUntil(dynamic route,
      {String? routeName}) {
    if (!_canNavigate()) return null;

    previousRoute = Get.currentRoute;
    currentRoute = routeName;

    return navigatorKey.currentState?.pushAndRemoveUntil(
        PageTransition(
          child: route,
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 250),
        ),
        (route) => false);
  }

  static bool canPop() {
    return navigatorKey.currentState?.canPop() ?? false;
  }

  static void pop([dynamic arguments]) {
    if (!_canNavigate()) return;

    if (canPop()) {
      navigatorKey.currentState?.pop(arguments);
    }
  }
}
