import 'package:exam_app/config/colors.dart';
import 'package:exam_app/config/store_config.dart';
import 'package:exam_app/services/local_storage.dart';
import 'package:exam_app/services/overlay_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PurchaseController extends GetxController {
  static PurchaseController get instance => Get.find();

  @override
  void onInit() {
    super.onInit();
    isPremium = LocalStorage.getData('isPremiumUser') ?? false;
    callAPIs();
  }

  Future<void> callAPIs() async {
    await checkSubscriptionStatus();
    await fetchProducts();
  }

  // Variables
  final RxBool _isPremium = false.obs;
  final RxBool _isLoading = true.obs;
  final RxBool _showAppbar = false.obs;

  final RxList<StoreProduct> _storeProduct = <StoreProduct>[].obs;

  // Getters
  bool get isPremium => _isPremium.value;
  bool get isLoading => _isLoading.value;
  bool get showAppbar => _showAppbar.value;

  List<StoreProduct> get storeProduct => _storeProduct;

  // Setters
  set isPremium(value) => _isPremium.value = value;
  set isLoading(value) => _isLoading.value = value;
  set showAppbar(value) => _showAppbar.value = value;

  set storeProduct(value) => _storeProduct.value = value;

  // Functions
  Future fetchProducts() async {
    isLoading = true;

    try {
      debugPrint('Fetching products with ID: $monthlyPlanIdentifier');
      final products = await Purchases.getProducts([monthlyPlanIdentifier]);

      debugPrint('Products fetched: ${products.length}');
      for (var product in products) {
        debugPrint(
            'Product: ${product.identifier}, Price: ${product.priceString}');
      }

      if (products.isEmpty) {
        debugPrint('Warning: No products were returned from the store');
      }

      storeProduct = products;
      isLoading = false;
    } catch (e, st) {
      isLoading = false;
      debugPrint('fetchProducts error: $e');
      debugPrint('fetchProducts stack: $st');
    }
  }

  Future purchaseProduct() async {
    OverlayLoader.show();
    try {
      final customerInfo =
          await Purchases.purchaseStoreProduct(storeProduct.first);
      debugPrint('customerInfo while purchase: $customerInfo');

      // Access customer information to verify the active subscriptions
      debugPrint("User successfully subscribed!");
      isPremium = true;
      LocalStorage.setData('isPremiumUser', true);
      OverlayLoader.hide();
      Get.back();
      Get.snackbar('', '',
          icon: const Icon(Icons.done),
          shouldIconPulse: true,
          titleText: const Text(
            'Success',
            style: TextStyle(
                fontSize: 16, color: whiteColor, fontWeight: FontWeight.bold),
          ),
          messageText: const Text(
            'Subscription purchase successfully!',
            style: TextStyle(fontSize: 14, color: whiteColor),
          ),
          backgroundColor: primaryColor,
          snackPosition: SnackPosition.BOTTOM);
    } on PlatformException catch (e) {
      debugPrint('error: $e');
      OverlayLoader.hide();
      var errorCode = PurchasesErrorHelper.getErrorCode(e);
      if (errorCode != PurchasesErrorCode.purchaseCancelledError) {
        debugPrint('PurchasesErrorCode.purchaseCancelledError');
      }
      isPremium = false;
      LocalStorage.setData('isPremiumUser', false);
    }
  }

  Future restorePurchases() async {
    OverlayLoader.show();
    await Future.delayed(const Duration(seconds: 1));
    try {
      CustomerInfo customerInfo = await Purchases.restorePurchases();
      debugPrint('customerInfo while restore: $customerInfo');

      isPremium = customerInfo.entitlements.active.containsKey(entitlementID);
      LocalStorage.setData('isPremiumUser', isPremium);

      if (isPremium) {
        OverlayLoader.hide();
        Get.back();
        Get.snackbar('', '',
            icon: const Icon(Icons.done),
            shouldIconPulse: true,
            titleText: const Text(
              'Success',
              style: TextStyle(
                fontSize: 16,
                color: whiteColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            messageText: const Text(
              'Subscription restored successfully!',
              style: TextStyle(fontSize: 14, color: whiteColor),
            ),
            backgroundColor: primaryColor,
            snackPosition: SnackPosition.BOTTOM);
      } else {
        OverlayLoader.hide();
        Get.snackbar('', '',
            icon: const Icon(Icons.error),
            shouldIconPulse: true,
            titleText: const Text(
              'Failed',
              style: TextStyle(
                fontSize: 16,
                color: whiteColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            messageText: const Text(
              'Subscription not found !',
              style: TextStyle(fontSize: 14, color: whiteColor),
            ),
            backgroundColor: primaryColor,
            snackPosition: SnackPosition.BOTTOM);
      }
    } on PlatformException catch (e) {
      OverlayLoader.hide();
      debugPrint('error: $e');
      var errorCode = PurchasesErrorHelper.getErrorCode(e);
      if (errorCode == PurchasesErrorCode.receiptAlreadyInUseError) {
        debugPrint('PurchasesErrorCode.receiptAlreadyInUseError');
      }
      if (errorCode == PurchasesErrorCode.missingReceiptFileError) {
        debugPrint('PurchasesErrorCode.missingReceiptFileError');
      }
      isPremium = false;
      LocalStorage.setData('isPremiumUser', false);
    }
  }

  Future checkSubscriptionStatus() async {
    try {
      CustomerInfo customerInfo = await Purchases.getCustomerInfo();
      debugPrint('customerInfo while check: $customerInfo');

      EntitlementInfo? entitlement =
          customerInfo.entitlements.all[entitlementID];
      if (entitlement != null && entitlement.isActive) {
        isPremium = true;
        LocalStorage.setData('isPremiumUser', true);
      } else {
        isPremium = false;
        LocalStorage.setData('isPremiumUser', false);
      }
      debugPrint('isPremiumUser: $isPremium');
    } catch (e) {
      debugPrint("Error fetching subscription status: $e");
      isPremium = false;
      LocalStorage.setData('isPremiumUser', false);
    }
  }
}
