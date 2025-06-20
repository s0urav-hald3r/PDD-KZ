import 'package:purchases_flutter/purchases_flutter.dart';

class StoreConfig {
  final Store store;
  final String apiKey;
  static StoreConfig? _instance;

  factory StoreConfig({required Store store, required String apiKey}) {
    _instance ??= StoreConfig._internal(store, apiKey);
    return _instance!;
  }

  StoreConfig._internal(this.store, this.apiKey);

  static StoreConfig get instance {
    return _instance!;
  }

  static bool isForAppleStore() => instance.store == Store.appStore;

  static bool isForGooglePlay() => instance.store == Store.playStore;
}

const String entitlementID = 'premium_access';

const String monthlyPlanIdentifier = 'pdd_999_1m_3d0';

const String appleApiKey = 'appl_ExmcLZoyDILwJuSwUidlIJwoKgN';

const String privacyPolicyUrl = 'https://sites.google.com/view/pddkzz/home';
const String termsOfUseUrl =
    'https://sites.google.com/view/pddkzz/terms-of-use';
const String shareText =
    'Қазақстан ПДД тестіне дайындал:\nhttps://apps.apple.com/app/id6747507183';
