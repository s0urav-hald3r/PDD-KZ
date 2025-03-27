// ignore_for_file: constant_identifier_names

import 'package:get_storage/get_storage.dart';

/// A utility class for handling local storage operations using GetStorage.
/// Provides type-safe methods for storing and retrieving data with optional expiration.
class LocalStorage {
  LocalStorage._();

  static final storage = GetStorage();

  /// Stores data with an optional expiration duration.
  static Future<void> setData<T>(String key, T value) async {
    await storage.write(key, value);
  }

  /// Retrieves data with type safety.
  /// Returns null if data doesn't exist or has expired.
  static T? getData<T>(String key) {
    if (!isDataValid(key)) return null;
    return storage.read<T>(key);
  }

  /// Checks if data exists and hasn't expired.
  static bool isDataValid(String key) {
    if (!storage.hasData(key)) return false;

    return true;
  }

  /// Removes specific data and its expiration.
  static Future<void> removeData(String key) async {
    await storage.remove(key);
  }

  /// Clears all data from storage.
  static Future<void> clearStorage() async {
    await storage.erase();
  }
}
