// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:exam_app/models/practice_set_model.dart';
import 'package:exam_app/services/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  final pageController = PageController();

  // Private variables
  final RxInt _homeIndex = 0.obs;
  final RxBool _isLoading = false.obs;
  final RxMap<int, List<PracticeSetModel>> _questionSets =
      <int, List<PracticeSetModel>>{}.obs;
  final RxList<PracticeSetModel> _favoriteSets = <PracticeSetModel>[].obs;

  final RxString _version = ''.obs;
  final RxString _buildNumber = ''.obs;

  // Getters
  int get homeIndex => _homeIndex.value;
  bool get isLoading => _isLoading.value;
  Map<int, List<PracticeSetModel>> get questionSets => _questionSets;
  List<PracticeSetModel> get favoriteSets => _favoriteSets;

  String get version => _version.value;
  String get buildNumber => _buildNumber.value;

  // Setters
  set homeIndex(value) => _homeIndex.value = value;
  set isLoading(value) => _isLoading.value = value;
  set questionSets(value) => _questionSets.value = value;
  set favoriteSets(value) => _favoriteSets.value = value;

  set version(value) => _version.value = value;
  set buildNumber(value) => _buildNumber.value = value;

  @override
  void onInit() {
    fetchQuestionSet();
    fetchFavorite();
    fetchPackageInfo();
    super.onInit();
  }

  void fetchPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    version = packageInfo.version;
    buildNumber = packageInfo.buildNumber;
  }

  void addToFavorite(PracticeSetModel set) {
    favoriteSets.add(set);

    final practiceSetData = favoriteSets.map((e) => e.toJson()).toList();
    LocalStorage.setData('favorite', jsonEncode(practiceSetData));
  }

  void removeFromFavorite(PracticeSetModel set) {
    favoriteSets.removeWhere((e) => e.question == set.question);

    final practiceSetData = favoriteSets.map((e) => e.toJson()).toList();
    LocalStorage.setData('favorite', jsonEncode(practiceSetData));
  }

  Future<void> fetchFavorite() async {
    final favorite = await LocalStorage.getData('favorite');
    if (favorite != null) {
      favoriteSets = (jsonDecode(favorite) as List)
          .map((e) => PracticeSetModel.fromJson(e))
          .toList();
    }
  }

  // Methods
  Future<void> fetchQuestionSet() async {
    isLoading = true;
    try {
      final response = await http.get(
        Uri.parse('https://pdd-kz-murex.vercel.app/api/question'),
      );
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        for (var element in jsonData) {
          final temp = <PracticeSetModel>[];
          for (var e in element['data']) {
            temp.add(PracticeSetModel.fromJson(e));
          }
          questionSets[element['questionSet']] = temp;
        }
      }
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
    } finally {
      isLoading = false;
    }
  }
}
