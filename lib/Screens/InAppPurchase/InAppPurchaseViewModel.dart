import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:mapsandnavigationflutter/Screens/Constents/Constent.dart';

class InAppPurchaseViewModel extends GetxController {
  InAppPurchase iAP = InAppPurchase.instance;
  final box = GetStorage();
  static const String nonConsumableId='ghalbail.maps.removeads';
 //static const String nonConsumableId='android.test.purchased';
  String price='';
  List<String> kProductIds = <String>[
    nonConsumableId,
/*  _kUpgradeId,
  _kSilverSubscriptionId,
  _kGoldSubscriptionId,*/
  ];
  /* List<String> _kProductIds = <String>[
    nonConsumableId,
*//*  _kUpgradeId,
  _kSilverSubscriptionId,
  _kGoldSubscriptionId,*//*
  ];*/
  List<ProductDetails> itemsList = <ProductDetails>[].obs;
  late StreamSubscription<dynamic> streamSubscription;

  //RxString weeklyPrice = 'Rs 0.0'.obs;
  // RxString monthlyPrice = 'Rs 0.0'.obs;
  RxString lifeTimePrice = 'Rs 0.0'.obs;

  //RxBool isWeeklyPurchased = false.obs;
  // RxBool isMonthlyPurchased = false.obs;
  RxBool isLifeTimePurchased = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    print("********Ready in app******************");

    setLastValue();
    getPurchaseHistory();
    getItemsForSale();
    super.onReady();
  }

  setLastValue() {
    // weeklyPrice.value = GetStorage().read('weeklyPrice') ?? 'PKR 0.0';
    //  monthlyPrice.value = GetStorage().read('monthlyPrice') ?? 'PKR 0.0';
    lifeTimePrice.value = GetStorage().read('lifeTimePrice') ?? 'PKR 0.0';
    price=lifeTimePrice.value;
  }

  void getItemsForSale() async {
    bool isAvailable = await iAP.isAvailable();
    if (!isAvailable) {
      print('Not Available For Sale');
    }
    print("proudct list1234:"+itemsList.length.toString());
    ProductDetailsResponse response =
    await iAP.queryProductDetails(kProductIds.toSet());

    itemsList.addAll(response.productDetails);
    print("proudct list:"+itemsList.length.toString());
    for (int i = 0; i < itemsList.length; i++) {
      print("proudct name:"+itemsList[i].title);
      // print('********** Start $i ***************');
      // print('ID : ${response.productDetails[i].id}');
      // print('Title : ${response.productDetails[i].title}');
      // print('C_Code : ${response.productDetails[i].currencyCode}');
      // print('Des : ${response.productDetails[i].description}');
      // print('Raw Price : ${response.productDetails[i].rawPrice}');
      // print('Symbol : ${response.productDetails[i].currencySymbol}');
      // print('Price : ${response.productDetails[i].price}');

      /* if (itemsList[i].id == GlobalVariable.weeklyIdAndroid) {
        weeklyPrice.value = itemsList[i].price;
        GetStorage().write('weeklyPrice', itemsList[i].price);
      }

      if (itemsList[i].id == GlobalVariable.monthlyIdAndroid) {
        monthlyPrice.value = itemsList[i].price;
        GetStorage().write('monthlyPrice', itemsList[i].price);
      }*/

      if (itemsList[i].id == nonConsumableId) {
        lifeTimePrice.value = itemsList[i].price;
        print("Price of product is:"+lifeTimePrice.value.toString());
        price= lifeTimePrice.value;
        GetStorage().write('lifeTimePrice', itemsList[i].price);
      }
    }
  }

  restorePurchase() {
    iAP.restorePurchases();
  }

  getPurchaseHistory() {
    streamSubscription =
        InAppPurchase.instance.purchaseStream.listen((purchaseList) {
          log('length : ${purchaseList.length}');

          if (purchaseList.length > 0) {
            for (int i = 0; i < purchaseList.length; i++) {
              PurchaseDetails details = purchaseList[i];
              log('******************************** Response ****************************');
              log('purchaseID : ${details.purchaseID}');
              log('status : ${details.status}');
              log('productID : ${details.productID}');
              log('pendingCompletePurchase : ${details.pendingCompletePurchase}');
              log('error : ${details.error}');

              if (!details.pendingCompletePurchase) {
                /* if (details.productID == GlobalVariable.weeklyIdAndroid) {
                  isWeeklyPurchased.value = true;
                  GlobalVariable.isPurchased.value = true;
                } else if (details.productID == GlobalVariable.monthlyIdAndroid) {
                  isMonthlyPurchased.value = true;
                  GlobalVariable.isPurchased.value = true;
                } else*/
                if (details.productID == nonConsumableId) {
                  isLifeTimePurchased.value = true;
                  // GlobalVariable.isPurchased.value = true;
                }
              } else {
                completePurchase(purchaseList[i]);
              }
            }
          } else {
            log('In App not found');
            //   GlobalVariable.isPurchased.value = false;
            //   GlobalVariable.shouldShowIAP.value = true;
          }
        }, onDone: () {
          print('done');
          streamSubscription.cancel();
        }, onError: (error) {
          print('Error');
        });

    restorePurchase();
  }

  void completePurchase(PurchaseDetails details) {
    iAP.completePurchase(details).then((value) {
      print('completed');
      restorePurchase();
      // CommonFunctions().getPurchaseHistory();

      ///Restart App
      //  Get.back();
      box.write('ispurchase', true);
      Constent.purchaseads.value=true;
      Constent.adspurchase=true;
      Get.offAllNamed('/');
      /* GetXHelper().showSnackBar(
          title: 'Successful',
          message: 'Congratulations! Item Purchase Successfully.');*/
    });
  }

/*  void buyWeeklySubscription() async {
    GlobalVariable.isInterstitialPaused = true;
    //int index =
  //  itemsList.indexWhere((e) => e.id == GlobalVariable.weeklyIdAndroid);

    if (index != -1) {
      bool res = await iAP.buyNonConsumable(
        purchaseParam: PurchaseParam(
          productDetails: itemsList[index],
        ),
      );
      print(res);
    } else {
      GetXHelper()
          .showSnackBar(title: 'Error', message: 'Item not available for sale');
    }
  }

  void buyMonthlySubscription() async {
    GlobalVariable.isInterstitialPaused = true;
    int index =
    itemsList.indexWhere((e) => e.id == GlobalVariable.monthlyIdAndroid);

    if (index != -1) {
      bool res = await iAP.buyNonConsumable(
        purchaseParam: PurchaseParam(
          productDetails: itemsList[index],
        ),
      );

      print(res);
    } else {
      GetXHelper()
          .showSnackBar(title: 'Error', message: 'Item not available for sale');
    }
  }*/

  void buyLifeTimeSubscription(BuildContext context) async {
    //GlobalVariable.isInterstitialPaused = true;
    int index =
    itemsList.indexWhere((e) => e.id == nonConsumableId);

    if (index != -1) {
      bool res = await iAP.buyNonConsumable(
        purchaseParam: PurchaseParam(
          productDetails: itemsList[index],
        ),
      );

      print(res);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Item not available for sale')));
      /* GetXHelper()
          .showSnackBar(title: 'Error', message: 'Item not available for sale');*/
    }
  }

}

