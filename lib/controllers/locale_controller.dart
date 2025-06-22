import 'package:exam_app/services/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocaleController extends GetxController implements Translations {
  final String _localeKey = 'locale';

  Locale? get currentLocale => _getStoredLocale();

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          // home page
          'Welcome to PDD Kz': 'Welcome to PDD Kz',
          // favourite page
          'No question added as favourite yet':
              'No question added as favourite yet',
          // settings page
          'Language': 'Language',
          'About the App': 'About the App',
          'Share': 'Share',
          'Rate': 'Rate',
          'Get the full version': 'Get the full version',
          // premium page
          'Try PDD For Free Quiz Unlock to all the Pro Features':
              'Try PDD For Free Quiz Unlock to all the Pro Features',
          'Unlock to all the Pro Features?': 'Unlock to all the Pro Features?',
          'Yes, Activate': 'Yes, Activate',
          'Restore Purchase': 'Restore Purchase',
          'Privacy Policy': 'Privacy Policy',
          'Terms of Use': 'Terms of Use',
          '3 days free trial, after': '3 days free trial, after',
          'month': 'month',
          // bottomnav bar
          'Home': 'Home',
          'Practice': 'Practice',
          'Favourite': 'Favourite',
          'Settings': 'Settings',
          'In Progress': 'In Progress',
          'Answered': 'Answered',
          'Locked': 'Locked',
          'Version': 'Version',
          'Description': 'Description',
          'PDD KZ Description':
              'PDD Kz – A helpful application designed to prepare users for the driving license exam in Kazaksthan',
        },
        'kk_KZ': {
          // home page
          'Welcome to PDD Kz': 'PDD Kz-ге қош келдіңіз',
          // favourite page
          'No question added as favourite yet':
              'Бірде-бір сұрақ қолданбаға қосылмаған',
          // settings page
          'Language': 'Тіл',
          'About the App': 'Қолданба туралы',
          'Share': 'Бөлісу',
          'Rate': 'Бағалау',
          'Get the full version': 'Қолданба толық нұсқасын алу',
          // premium page
          'Try PDD For Free Quiz Unlock to all the Pro Features':
              'PDD сынағын 3 күн тегін өтіңіз Барлық Про мүмкіндіктерді ашыңыз',
          'Unlock to all the Pro Features?':
              'Барлық Про мүмкіндіктерді ашыңыз?',
          'Yes, Activate': 'Иә, Қолдану',
          'Restore Purchase': 'Сатып алынғандарды қалпына келтіру',
          'Privacy Policy': 'Жекелік саясаты',
          'Terms of Use': 'Қолданба шарттары',
          '3 days free trial, after': '3 күн тегін сынақтан кейін',
          'month': 'ай',
          // bottomnav bar
          'Home': 'Үй',
          'Practice': 'Практика',
          'Favourite': 'Бекітілген',
          'Settings': 'Баптаулар',
          'In Progress': 'Жүргізіліп жатыр',
          'Answered': 'Жауап берілген',
          'Locked': 'Блокировка',
          'Version': 'Нұсқасы',
          'Description': 'Сипаттама',
          'PDD KZ Description':
              'PDD Kz – Қазақстанда жүргізуші куәлігін алуға дайындалуға арналған пайдалы қосымша',
        },
      };

  void changeLocale(String languageCode, String countryCode) {
    final locale = Locale(languageCode, countryCode);
    LocalStorage.setData(_localeKey, {
      'languageCode': languageCode,
      'countryCode': countryCode,
    });
    Get.updateLocale(locale);
  }

  Locale? _getStoredLocale() {
    final localeData = LocalStorage.getData(_localeKey);
    if (localeData != null) {
      return Locale(
        localeData['languageCode'],
        localeData['countryCode'],
      );
    }
    return null;
  }
}
