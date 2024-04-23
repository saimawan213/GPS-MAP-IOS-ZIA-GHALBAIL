import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mapsandnavigationflutter/Screens/Constents/Constent.dart';
import 'package:mapsandnavigationflutter/Screens/InAppPurchase/ConsumableStore.dart';

class MyInApp extends StatefulWidget {
  @override
  State<MyInApp> createState() => InAppfile();
}

final bool _kAutoConsume = Platform.isIOS || true;

String _kConsumableId = purchaseidvalue();


Set<String> productid ={purchaseidvalue()} ;


final box = GetStorage();
/*const String _kUpgradeId = 'android.test.purchased';
const String _kSilverSubscriptionId = 'android.test.purchased';
const String _kGoldSubscriptionId = 'android.test.purchased';*/
List<String> _kProductIds = <String>[
  purchaseidvalue(),
/*  _kUpgradeId,
  _kSilverSubscriptionId,
  _kGoldSubscriptionId,*/
];
purchaseidvalue() {
  if(Platform.isAndroid){
    return 'com.mapsdirection.removeads';
    //return 'android.test.purchased';
  }
  else{

    return 'com.mapsdirection.removeads';
  }
}
class InAppfile extends State<MyInApp> {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  List<String> _notFoundIds = <String>[];
  late StreamSubscription<dynamic> streamSubscription;
  List<ProductDetails> _products = <ProductDetails>[];
  List<PurchaseDetails> _purchases = <PurchaseDetails>[];
  List<String> _consumables = <String>[];
  bool _isAvailable = false;
  bool _purchasePending = false;
  bool _loading = true;
  String? _queryProductError;

  @override
  void initState()  {
    GetStorage.init();
    //getPurchaseHistory();
    // _inAppPurchase.restorePurchases();
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        _inAppPurchase.purchaseStream;
    _subscription =
        purchaseUpdated.listen((List<PurchaseDetails> purchaseDetailsList) {
          _listenToPurchaseUpdated(purchaseDetailsList);
        }, onDone: () {
          _subscription.cancel();
        }, onError: (Object error) {
          // handle error here.
        });
    initStoreInfo();
    // callproductfile();
    super.initState();
  }

  Future<void> initStoreInfo() async {
    final bool isAvailable = await _inAppPurchase.isAvailable();
    if (!isAvailable) {
      setState(() {
        _isAvailable = isAvailable;
        _products = <ProductDetails>[];
        _purchases = <PurchaseDetails>[];
        _notFoundIds = <String>[];
        _consumables = <String>[];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
      _inAppPurchase
          .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      await iosPlatformAddition.setDelegate(ExamplePaymentQueueDelegate());
    }

    final ProductDetailsResponse productDetailResponse =
    await _inAppPurchase.queryProductDetails(_kProductIds.toSet());
    if (productDetailResponse.error != null) {
      setState(() {
        _queryProductError = productDetailResponse.error!.message;
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
        _purchases = <PurchaseDetails>[];
        _notFoundIds = productDetailResponse.notFoundIDs;
        _consumables = <String>[];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    if (productDetailResponse.productDetails.isEmpty) {
      setState(() {
        _queryProductError = null;
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
        _purchases = <PurchaseDetails>[];
        _notFoundIds = productDetailResponse.notFoundIDs;
        _consumables = <String>[];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    final List<String> consumables = await ConsumableStore.load();
    setState(() {
      _isAvailable = isAvailable;
      _products = productDetailResponse.productDetails;
      _notFoundIds = productDetailResponse.notFoundIDs;
      _consumables = consumables;
      _purchasePending = false;
      _loading = false;
    });
  }

/*  void callproductfile(){
    final Map<String, PurchaseDetails> purchases =
    Map<String, PurchaseDetails>.fromEntries(
        _purchases.map((PurchaseDetails purchase) {
          if (purchase.pendingCompletePurchase) {
            _inAppPurchase.completePurchase(purchase);
          }
          return MapEntry<String, PurchaseDetails>(purchase.productID, purchase);
        }));

   // productList.addAll(_products.map((ProductDetails productDetails));
    productList.addAll(_products.map(
          (ProductDetails productDetails) {
        final PurchaseDetails? previousPurchase = purchases[productDetails.id];


        late PurchaseParam purchaseParam;

        if (Platform.isAndroid) {
          // NOTE: If you are making a subscription purchase/upgrade/downgrade, we recommend you to
          // verify the latest status of you your subscription by using server side receipt validation
          // and update the UI accordingly. The subscription purchase status shown
          // inside the app may not be accurate.
          final GooglePlayPurchaseDetails? oldSubscription =
          _getOldSubscription(productDetails, purchases);

          purchaseParam = GooglePlayPurchaseParam(
              productDetails: productDetails,
              changeSubscriptionParam: (oldSubscription != null)
                  ? ChangeSubscriptionParam(
                oldPurchaseDetails: oldSubscription,
                prorationMode:
                ProrationMode.immediateWithTimeProration,
              )
                  : null);
        } else {
          purchaseParam = PurchaseParam(
            productDetails: productDetails,
          );
        }

        if (productDetails.id == _kConsumableId) {
          _inAppPurchase.buyConsumable(
              purchaseParam: purchaseParam,
              autoConsume: _kAutoConsume);
        } else {
          _inAppPurchase.buyNonConsumable(
              purchaseParam: purchaseParam);
        }

        return ListTile(
          title: Text(
            productDetails.title,
          ),
          subtitle: Text(
            productDetails.description,
          ),
          trailing: previousPurchase != null && Platform.isIOS
              ? IconButton(
              onPressed: () => confirmPriceChange(context),
              icon: const Icon(Icons.upgrade))
              : TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.green[800],
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              late PurchaseParam purchaseParam;

              if (Platform.isAndroid) {
                // NOTE: If you are making a subscription purchase/upgrade/downgrade, we recommend you to
                // verify the latest status of you your subscription by using server side receipt validation
                // and update the UI accordingly. The subscription purchase status shown
                // inside the app may not be accurate.
                final GooglePlayPurchaseDetails? oldSubscription =
                _getOldSubscription(productDetails, purchases);

                purchaseParam = GooglePlayPurchaseParam(
                    productDetails: productDetails,
                    changeSubscriptionParam: (oldSubscription != null)
                        ? ChangeSubscriptionParam(
                      oldPurchaseDetails: oldSubscription,
                      prorationMode:
                      ProrationMode.immediateWithTimeProration,
                    )
                        : null);
              } else {
                purchaseParam = PurchaseParam(
                  productDetails: productDetails,
                );
              }

              if (productDetails.id == _kConsumableId) {
                _inAppPurchase.buyConsumable(
                    purchaseParam: purchaseParam,
                    autoConsume: _kAutoConsume);
              } else {
                _inAppPurchase.buyNonConsumable(
                    purchaseParam: purchaseParam);
              }
            },
            child: Text(productDetails.price),
          ),
        );
      },
    ));}*/
  @override
  void dispose() {
    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
      _inAppPurchase
          .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      iosPlatformAddition.setDelegate(null);
    }
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("insid");
    final List<Widget> stack = <Widget>[];
    if (_queryProductError == null) {
      stack.add(

        ListView(
          children: <Widget>[

            //_buildConnectionCheckTile(),
            _buildProductList(),

            // _buildConsumableBox(),
            _buildRestoreButton(),
          ],
        ),
      );
    } else {
      stack.add(Center(
        child: Text(_queryProductError!),
      ));
    }
    if (_purchasePending) {
      stack.add(
        const Stack(
          children: <Widget>[
            Opacity(
              opacity: 0.3,
              child: ModalBarrier(dismissible: false, color: Colors.grey),
            ),
            Center(
              child: CircularProgressIndicator(),
            ),
          ],
        ),
      );
    }

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              // Add your back button onPressed logic here
              Navigator.pop(context);
            },
          ),
          title: const Text('In App Purchase',style: TextStyle(color: Colors.white),),
        ),
        body: Stack(
          children: stack,
        ),
      ),
    );

  }

  Card _buildConnectionCheckTile() {
    if (_loading) {
      return const Card(child: ListTile(title: Text('Trying to connect...')));
    }
    final Widget storeHeader = ListTile(
      leading: Icon(_isAvailable ? Icons.check : Icons.block,
          color: _isAvailable
              ? Colors.green
              : ThemeData
              .light()
              .colorScheme
              .error),
      title:
      Text('The store is ${_isAvailable ? 'available' : 'unavailable'}.'),
    );
    final List<Widget> children = <Widget>[storeHeader];

    if (!_isAvailable) {
      children.addAll(<Widget>[
        const Divider(),
        ListTile(
          title: Text('Not connected',
              style: TextStyle(color: ThemeData
                  .light()
                  .colorScheme
                  .error)),
          subtitle: const Text(
              'Unable to connect to the payments processor. Has this app been configured correctly? See the example README for instructions.'),
        ),
      ]);
    }
    return Card(child: Column(children: children));
  }

  Card _buildProductList() {
    if (_loading) {
      return const Card(
          child: ListTile(
              leading: CircularProgressIndicator(),
              title: Text('Fetching products...')));
    }
    if (!_isAvailable) {
      return const Card();
    }
    const ListTile productHeader = ListTile(
        title: Text('Click on Price Button to Remove all Ads From the App'));
    final List<ListTile> productList = <ListTile>[];
    if (_notFoundIds.isNotEmpty) {
      productList.add(ListTile(
          title: Text('[${_notFoundIds.join(", ")}] not found',
              style: TextStyle(color: ThemeData
                  .light()
                  .colorScheme
                  .error)),
          subtitle: const Text(
              'This app needs special configuration to run. Please see example/README.md for instructions.')));
    }

    // This loading previous purchases code is just a demo. Please do not use this as it is.
    // In your app you should always verify the purchase data using the `verificationData` inside the [PurchaseDetails] object before trusting it.
    // We recommend that you use your own server to verify the purchase data.
    final Map<String, PurchaseDetails> purchases =
    Map<String, PurchaseDetails>.fromEntries(
        _purchases.map((PurchaseDetails purchase) {
          if (purchase.pendingCompletePurchase) {
            _inAppPurchase.completePurchase(purchase);
          }
          return MapEntry<String, PurchaseDetails>(
              purchase.productID, purchase);
        }));
    productList.addAll(_products.map(
          (ProductDetails productDetails) {
        final PurchaseDetails? previousPurchase = purchases[productDetails.id];
        return ListTile(
          /*title: Text(
            productDetails.title,
            style: TextStyle(color: Colors.red),
          ),
          subtitle: Text(
            productDetails.description,
            style: TextStyle(color: Colors.red),
          ),*/
          title: previousPurchase != null && Platform.isIOS
              ? IconButton(
              onPressed: () => confirmPriceChange(context),
              icon: const Icon(Icons.upgrade))
              : Container(
            margin: EdgeInsets.only(left: 95, right: 85),
            child: TextButton(
              style: TextButton.styleFrom(
                // backgroundColor: Colors.green[800],
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              onPressed: () async {
                // getPurchaseHistory();
                //  return;



                late PurchaseParam purchaseParam;
                print("Call in App ");
                if (Platform.isAndroid) {
                  // NOTE: If you are making a subscription purchase/upgrade/downgrade, we recommend you to
                  // verify the latest status of you your subscription by using server side receipt validation
                  // and update the UI accordingly. The subscription purchase status shown
                  // inside the app may not be accurate.
                  final GooglePlayPurchaseDetails? oldSubscription =
                  _getOldSubscription(productDetails, purchases);

                  purchaseParam = GooglePlayPurchaseParam(
                      productDetails: productDetails,
                      changeSubscriptionParam: (oldSubscription != null)
                          ? ChangeSubscriptionParam(
                        oldPurchaseDetails: oldSubscription,
                        prorationMode:
                        ProrationMode.immediateWithTimeProration,
                      )
                          : null);
                } else {
                  purchaseParam = PurchaseParam(
                    productDetails: productDetails,
                  );
                }

                if (productDetails.id == _kConsumableId) {
                  print("call non Consumable");
                  if(Platform.isIOS) {
                    var transactions = await SKPaymentQueueWrapper().transactions();
                    transactions.forEach((skPaymentTransactionWrapper) {
                      SKPaymentQueueWrapper().finishTransaction(skPaymentTransactionWrapper);
                    });
                  }

                  _inAppPurchase.buyNonConsumable(
                      purchaseParam: PurchaseParam(  productDetails: await getProductDetails(), applicationUserName: null)
                  );



                } else {
                  _inAppPurchase.buyConsumable(
                      purchaseParam: purchaseParam,
                      autoConsume: _kAutoConsume);
                }
                //   getPurchaseHistory();
              },
              child: Text(productDetails.price),
            ),
          ),
        );
      },
    ));

    return Card(
        child: Column(
            children: <Widget>[productHeader, const Divider()] + productList));
  }

  Card _buildConsumableBox() {
    if (_loading) {
      return const Card(
          child: ListTile(
              leading: CircularProgressIndicator(),
              title: Text('Fetching consumables...')));
    }
    if (!_isAvailable || _notFoundIds.contains(_kConsumableId)) {
      return const Card();
    }
    const ListTile consumableHeader =
    ListTile(title: Text('Purchased consumables'));
    final List<Widget> tokens = _consumables.map((String id) {
      return GridTile(
        child: IconButton(
          icon: const Icon(
            Icons.stars,
            size: 42.0,
            color: Colors.orange,
          ),
          splashColor: Colors.yellowAccent,
          onPressed: () => consume(id),
        ),
      );
    }).toList();
    return Card(
        child: Column(children: <Widget>[
          consumableHeader,
          const Divider(),
          GridView.count(
            crossAxisCount: 5,
            shrinkWrap: true,
            padding: const EdgeInsets.all(16.0),
            children: tokens,
          )
        ]));
  }

  Widget _buildRestoreButton() {
    if(_loading) {
      return Container();
    }
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 10,),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
            onPressed: () => _inAppPurchase.restorePurchases(),
            child: const Text('Restore purchases'),
          ),

          SizedBox(height: 10,),
        ],
      ),
    );
  }

  Future<void> consume(String id) async {
    await ConsumableStore.consume(id);
    final List<String> consumables = await ConsumableStore.load();
    setState(() {
      _consumables = consumables;
    });
  }

  void showPendingUI() {
    setState(() {
      _purchasePending = true;
    });
  }
  Future<ProductDetails> getProductDetails() async {
    // Fetch product details
    final ProductDetailsResponse response = await _inAppPurchase.queryProductDetails(
        productid
    );
    //  response.productDetails.first.
    return response.productDetails.first;
  }

  Future<void> deliverProduct(PurchaseDetails purchaseDetails) async {
    // IMPORTANT!! Always verify purchase details before delivering the product.
    if (purchaseDetails.productID == _kConsumableId) {
      await ConsumableStore.save(purchaseDetails.purchaseID!);
      final List<String> consumables = await ConsumableStore.load();
      setState(() {
        _purchasePending = false;
        _consumables = consumables;

      });
    } else {
      setState(() {
        _purchases.add(purchaseDetails);
        _purchasePending = false;
      });
    }
  }

  void handleError(IAPError error) {
    setState(() {
      _purchasePending = false;
    });
  }

  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) {
    // IMPORTANT!! Always verify a purchase before delivering the product.
    // For the purpose of an example, we directly return true.
    return Future<bool>.value(true);
  }

  void _handleInvalidPurchase(PurchaseDetails purchaseDetails) {
    // handle invalid purchase here if  _verifyPurchase` failed.
  }

  getPurchaseHistory() {

    streamSubscription =
        InAppPurchase.instance.purchaseStream.listen((purchaseList) async {
          log('length : ${purchaseList.length}');
          print('length : ${purchaseList.length}');

          //    streamSubscription.cancel();

          if (purchaseList.length > 0) {
            for (int i = 0; i < purchaseList.length; i++) {
              PurchaseDetails details = purchaseList[i];
              print(
                  '******************************** Response ****************************');
              print('purchaseID : ${details.purchaseID}');
              print('status : ${details.status}');
              print('productID : ${details.productID}');
              print('pendingCompletePurchase : ${details
                  .pendingCompletePurchase}');
              print('error : ${details.error}');
              if(details.status==PurchaseStatus.purchased)
//if(details.status=='PurchaseStatus.purchased')
                  {
                print("Call Purchaseing Function");
                box.write('ispurchase', true);
                Constent.purchaseads.value=true;
                Constent.adspurchase=true;
                Get.offAllNamed('/');
              }

              // Restart.restartApp();
              // Get.offAll(() => Splash_View());

              else if(details.status==PurchaseStatus.restored)
                //else if(details.status=='PurchaseStatus.restored')
                  {
                print("Call Restoring Function Function");
                /*box.write('ispurchase', true);
                AppConst.purchaseads.value=true;
                AppConst.adspurchase=true;
                Get.offAllNamed('/');*/
                //  Restart.restartApp();
//Get.deleteAll();
                // try{
                //   print("find Splash view model");
                //   SplashViewModel splashViewModel=Get.find();
                //   splashViewModel.onReady();
                // }
                // catch(e)
                // {
                //   print("call Splash view model");
                //   SplashViewModel splashViewModel=Get.put(SplashViewModel());
                // }
                //  Get.offAll(() => Splash_View());
              }
              else{
                box.write('ispurchase', false);
              }
              if (details.pendingCompletePurchase) {
                _inAppPurchase.completePurchase(details).then((value) {
                  //  details.pendingCompletePurchase=false;
                  print('completed');
                });
              }
            }
          } else {
            log('In App not found');
            // GlobalVariable.isPurchased.value = false;
            //GlobalVariable.shouldShowIAP.value = true;
          }
        }, onDone: () {
          print('done');
          streamSubscription.cancel();
        }, onError: (error) {
          print('Error');
        });

    _inAppPurchase.restorePurchases();
    //  restorePurchase();
  }

  Future<void> _listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList) async {
    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        print("Call Main pending function");
        showPendingUI();
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          print("Call Main error function");
          handleError(purchaseDetails.error!);
        } else if (purchaseDetails.status == PurchaseStatus.purchased
        ) {
          print("Call Main purchased function");
          final bool valid = await _verifyPurchase(purchaseDetails);
          if (valid) {
            unawaited(deliverProduct(purchaseDetails));
            // _subscription.cancel();
            box.write('ispurchase', true);
            Constent.purchaseads.value=true;
            Constent.adspurchase=true;
            Get.offAllNamed('/');
          } else {
            _handleInvalidPurchase(purchaseDetails);
            return;
          }
        }
        else if(purchaseDetails.status == PurchaseStatus.restored){
          print("Call Main Restore function");
          // _subscription.cancel();
          /*box.write('ispurchase', true);
          AppConst.purchaseads.value=true;
          AppConst.adspurchase=true;
          Get.offAllNamed('/');*/

        }
        if (Platform.isAndroid) {
          if (!_kAutoConsume && purchaseDetails.productID == _kConsumableId) {
            final InAppPurchaseAndroidPlatformAddition androidAddition =
            _inAppPurchase.getPlatformAddition<
                InAppPurchaseAndroidPlatformAddition>();
            await androidAddition.consumePurchase(purchaseDetails);
          }
        }
        if (purchaseDetails.pendingCompletePurchase) {
          await _inAppPurchase.completePurchase(purchaseDetails);
        }
      }
    }
  }
  String purchaseidvalue(){
    if(Platform.isAndroid){
      return 'com.mapsdirection.removeads';
    }
    else{
      /* const String _kConsumableId = 'com.obd.removeads';
      Set<String> productid ={'com.obd.removeads'} ;
  //    final box = GetStorage();

      const List<String> _kProductIds = <String>[
        _kConsumableId,

      ];*/
      return 'com.mapsdirection.removeads';
    }
  }
  Future<void> confirmPriceChange(BuildContext context) async {
    // Price changes for Android are not handled by the application, but are
    // instead handled by the Play Store. See
    // https://developer.android.com/google/play/billing/price-changes for more
    // information on price changes on Android.
    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iapStoreKitPlatformAddition =
      _inAppPurchase
          .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      await iapStoreKitPlatformAddition.showPriceConsentIfNeeded();
    }
  }

  GooglePlayPurchaseDetails? _getOldSubscription(ProductDetails productDetails,
      Map<String, PurchaseDetails> purchases) {
    // This is just to demonstrate a subscription upgrade or downgrade.
    // This method assumes that you have only 2 subscriptions under a group, 'subscription_silver' & 'subscription_gold'.
    // The 'subscription_silver' subscription can be upgraded to 'subscription_gold' and
    // the 'subscription_gold' subscription can be downgraded to 'subscription_silver'.
    // Please remember to replace the logic of finding the old subscription Id as per your app.
    // The old subscription is only required on Android since Apple handles this internally
    // by using the subscription group feature in iTunesConnect.
    GooglePlayPurchaseDetails? oldSubscription;
/*    if (productDetails.id == _kSilverSubscriptionId &&
        purchases[_kGoldSubscriptionId] != null) {
      oldSubscription =
      purchases[_kGoldSubscriptionId]! as GooglePlayPurchaseDetails;
    } else if (productDetails.id == _kGoldSubscriptionId &&
        purchases[_kSilverSubscriptionId] != null) {
      oldSubscription =
      purchases[_kSilverSubscriptionId]! as GooglePlayPurchaseDetails;
    }*/
    return oldSubscription;
  }
}

/// Example implementation of the
/// [`SKPaymentQueueDelegate`](https://developer.apple.com/documentation/storekit/skpaymentqueuedelegate?language=objc).
///
/// The payment queue delegate can be implementated to provide information
/// needed to complete transactions.
class ExamplePaymentQueueDelegate implements SKPaymentQueueDelegateWrapper {
  @override
  bool shouldContinueTransaction(SKPaymentTransactionWrapper transaction,
      SKStorefrontWrapper storefront) {
    return true;
  }

  @override
  bool shouldShowPriceConsent() {
    return false;
  }

}
