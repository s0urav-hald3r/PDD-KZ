import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LocaleController extends GetxController implements Translations {
  final _storage = GetStorage();
  final String _localeKey = 'locale';

  Locale? get currentLocale => _getStoredLocale();

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'Language': 'Language',
          'About the App': 'About the App',
          'Share': 'Share',
          'Rate': 'Rate',
          'Get the full version': 'Get the full version',
          'Home': 'Home',
          'Practice': 'Practice',
          'Favourite': 'Favourite',
          'Settings': 'Settings',
          'Version': 'Version',
          'Description': 'Description',
          'PDD KZ Description':
              'PDD kz – A helpful application designed to prepare users for the driving license exam in Kazaksthan',
        },
        'kk_KZ': {
          'Language': 'Тіл',
          'About the App': 'Біріктірушілігі туралы',
          'Share': 'Бөлісу',
          'Rate': 'Бағалау',
          'Get the full version': 'Қолданба толық нұсқасын алу',
          'Home': 'Үй',
          'Practice': 'Практика',
          'Favourite': 'Бекітілген',
          'Settings': 'Баптаулар',
          'Version': 'Нұсқасы',
          'Description': 'Сипаттама',
          'PDD KZ Description':
              'PDD kz – Қазақстанда жүргізуші куәлігін алуға дайындалуға арналған пайдалы қосымша',
        },
      };

  void changeLocale(String languageCode, String countryCode) {
    final locale = Locale(languageCode, countryCode);
    _storage.write(_localeKey, {
      'languageCode': languageCode,
      'countryCode': countryCode,
    });
    Get.updateLocale(locale);
  }

  Locale? _getStoredLocale() {
    final localeData = _storage.read(_localeKey);
    if (localeData != null) {
      return Locale(
        localeData['languageCode'],
        localeData['countryCode'],
      );
    }
    return null;
  }
}
