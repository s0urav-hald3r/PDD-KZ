import 'dart:io';

import 'package:exam_app/config/colors.dart';
import 'package:exam_app/config/store_config.dart';
import 'package:exam_app/controllers/home_controller.dart';
import 'package:exam_app/controllers/locale_controller.dart';
import 'package:exam_app/controllers/purchase_controller.dart';
import 'package:exam_app/services/navigator_key.dart';
import 'package:exam_app/views/navbar_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

Future<void> _configureSDK() async {
  if (kReleaseMode) {
    await Purchases.setLogLevel(LogLevel.info);
  } else {
    await Purchases.setLogLevel(LogLevel.debug);
  }

  PurchasesConfiguration configuration;

  configuration = PurchasesConfiguration(StoreConfig.instance.apiKey);

  await Purchases.configure(configuration);
}

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await GetStorage.init();

  // Configure store for in-app purchase
  if (Platform.isIOS) {
    StoreConfig(store: Store.appStore, apiKey: appleApiKey);
  }

  await _configureSDK();

  // Dependency injection
  Get.lazyPut(() => HomeController());
  Get.lazyPut(() => LocaleController());
  Get.put(PurchaseController());

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  FlutterNativeSplash.remove();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final localeController = Get.find<LocaleController>();

    return GetMaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Nunito Sans',
        scaffoldBackgroundColor: whiteColor,
        splashFactory: NoSplash.splashFactory,
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            minimumSize: Size.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        ),
      ),
      locale: localeController.currentLocale ?? const Locale('en', 'US'),
      translations: localeController,
      navigatorKey: NavigatorKey.navigatorKey,
      home: const NavBarPage(),
    );
  }
}
