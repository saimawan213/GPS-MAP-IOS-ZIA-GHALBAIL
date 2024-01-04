import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mapsandnavigationflutter/Screens/Ads/AppLifecycleReactor.dart';
import 'package:mapsandnavigationflutter/Screens/Constents/Constent.dart';
import 'package:mapsandnavigationflutter/Screens/MainScreen/MainScreenView.dart';
import 'package:mapsandnavigationflutter/Screens/MainScreen/MainScreenViewIos.dart';

class Admob_Helper  {
  NativeAd? nativeAd;
  RxBool isBannerLoaded = false.obs;
  RxBool islargeBannerLoaded = false.obs;
  RxBool issmallBannerLoaded = false.obs;
  RxBool issmall1BannerLoaded = false.obs;
  RxBool nativeAdIsLoaded=false.obs;
  //RxBool nativeAdIsLoaded = false.obs;
  final double adAspectRatioMedium = (95 / 355);
  RxString versionString = "".obs;

  //bool nativeAdIsLoaded = false;
  final Duration maxCacheDuration = Duration(hours: 4);
  late AppLifecycleReactor _appLifecycleReactor;

  /// Keep track of load time so we don't show an expired ad.
  DateTime? _appOpenLoadTime;

  AppOpenAd? appOpenAd;
  bool _isShowingAd = false;


  BannerAd? bannerAd;

  BannerAd? anchoredAdaptiveAd;
  InterstitialAd? interstitialAd;
  bool isBannerAdReady = true;

  // TODO: replace this test ad unit with your own ad unit.
/*
  final adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-3940256099942544/2934735716';
*/

  /// Loads a banner ad.
  void loadBannerAd() {
    if(!Constent.adspurchase) {
      bannerAd = BannerAd(
        adUnitId: Constent.bannerAdID,
        request: const AdRequest(),
        size: AdSize.mediumRectangle,
        listener: BannerAdListener(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            debugPrint('$ad loaded.');
            // setState(() {
            islargeBannerLoaded.value = true;
            isBannerAdReady = true;
            //  });
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (ad, err) {
            debugPrint('BannerAd failed to load: $err');
            // Dispose the ad here to free resources.
            ad.dispose();
          },
        ),
      )
        ..load();
    }
  }
  void loadsmallBannerAd() {
    if(!Constent.adspurchase) {
      bannerAd = BannerAd(
        adUnitId: Constent.bannerAdID,
        request: const AdRequest(),
        size: AdSize.largeBanner,
        listener: BannerAdListener(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            debugPrint('$ad loaded.');
            // setState(() {
            issmallBannerLoaded.value = true;
            isBannerAdReady = true;
            //  });
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (ad, err) {
            debugPrint('BannerAd failed to load: $err');
            // Dispose the ad here to free resources.
            ad.dispose();
          },
        ),
      )
        ..load();
    }
  }
  void loadsmall1BannerAd() {
    if(!Constent.adspurchase) {
      bannerAd = BannerAd(
        adUnitId: Constent.bannerAdID,
        request: const AdRequest(),
        size: AdSize.banner,
        listener: BannerAdListener(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            debugPrint('$ad loaded.');
            // setState(() {
            issmall1BannerLoaded.value = true;
            isBannerAdReady = true;
            //  });
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (ad, err) {
            debugPrint('BannerAd failed to load: $err');
            // Dispose the ad here to free resources.
            ad.dispose();
          },
        ),
      )
        ..load();
    }
  }
  Future<void> adaptiveloadAd() async {

    // Get an AnchoredAdaptiveBannerAdSize before loading the ad.
    if(!Constent.adspurchase) {
      final AnchoredAdaptiveBannerAdSize? size =
      await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
          Get.width.truncate());

      if (size == null) {
        print('Unable to get height of anchored banner.');
        return;
      }

      anchoredAdaptiveAd = BannerAd(
        // TODO: replace these test ad units with your own ad unit.
        adUnitId: Constent.bannerAdID,
        size: size,
        request: AdRequest(),
        listener: BannerAdListener(
          onAdLoaded: (Ad ad) {
            print("Banner loaded");
            print('$ad loaded: ${ad.responseInfo}');
            //setState(() {
            // When the ad is loaded, get the ad size and use it to set
            // the height of the ad container.
            anchoredAdaptiveAd = ad as BannerAd;
            print("Bannerr loadede file eee 12" +
                isBannerLoaded.value.toString());
            isBannerLoaded.value = true;
            print(
                "Bannerr loadede file eee " + isBannerLoaded.value.toString());
            //  });
          },
          onAdFailedToLoad: (Ad ad, LoadAdError error) {
            print('Anchored adaptive banner failedToLoad: $error');
            anchoredAdaptiveAd = null;
            ad.dispose();
            adaptiveloadAd();
          },
        ),
      );
      return anchoredAdaptiveAd!.load();
    }
  }
  void deletebanner(){
    if(bannerAd!=null){
      bannerAd!.dispose();
    }
  }

  void loadInterstitalAd() {
    if (!Constent.adspurchase) {
      if (interstitialAd == null) {
        //if (AppConst.isAlternativeInterstitial) {
        InterstitialAd.load(
            adUnitId: Constent.interstialAdID,
            request: const AdRequest(),
            adLoadCallback: InterstitialAdLoadCallback(
              // Called when an ad is successfully received.
              onAdLoaded: (ad) {
                print("Interstital loaded");


                debugPrint('$ad loaded.');
                // Keep a reference to the ad so you can show it later.
                interstitialAd = ad;
              },
              // Called when an ad request failed.
              onAdFailedToLoad: (LoadAdError error) {
                loadInterstitalAd();
                debugPrint('InterstitialAd failed to load: $error');
              },
            ));
      }

      /*else{
        AppConst.isAlternativeInterstitial = true;
      }*/
      /*}
    else{
      AppConst.isAlternativeInterstitial = true;
    }*/
    }
  }

  void showInterstitialAd( {bool isSplash = false,Function? callback}) {
    if(!Constent.adspurchase) {
    if(interstitialAd!=null) {
      if (Constent.isAlternativeopenInterstitial){
        print("show ads:" + interstitialAd.toString());
//    if(AppConst.adspurchase){
      if (Constent.isAlternativeInterstitial) {
        if (!isSplash) {
          interstitialAdCallBack(callback);
        } else {
          interstitialAdCallBack1();
        }
        interstitialAd?.show();

        Constent.isAlternativeInterstitial = false;
      } else {
        loadInterstitalAd();
        Constent.isAlternativeInterstitial = true;
        if (!isSplash) {
          callback!();
          /*if (nextScreen == 'no') {
            print('call function here');
            callback!();
          }
          else {
            print('call Class here');
            Get.toNamed(nextScreen);
          }*/
        }
      }
    }
      else{
        Constent.isAlternativeopenInterstitial=true;
        Constent.isAlternativeInterstitial=true;
        if (!isSplash) {
          callback!();
        }
        else {
          if(Platform.isAndroid){
            Get.off(() => MainScreen_View());
          }
          else{
            Get.off(() => MainScreen_ViewIos());
          }
        }


      }
    }


    else if(isSplash){
      if(Platform.isAndroid){
        Get.off(() => MainScreen_View());
      }
      else{
        Get.off(() => MainScreen_ViewIos());
      }
    }
    else{
      callback!();
      /*if (nextScreen == 'no') {
        print('call function here');
        callback!();
      }
      else {
        print('call Class here');
        Get.toNamed(nextScreen);
      }*/
    }


    /* }
    else {
      loadInterstitalAd();
      //AppConst.isAlternativeInterstitial =true;
    }*/
  }
    else{
      callback!();

    }
  }
  Future<void> loadNativeAd(
      {TemplateType type = TemplateType.medium,
        String factoryId = 'listTileMedium2'}) async {
    try {
      if(!Constent.adspurchase) {
        nativeAd =   NativeAd(
          factoryId: factoryId,
          adUnitId: Constent.nativeAdID,
          listener: NativeAdListener(
            onAdLoaded: (ad) {
              debugPrint('$NativeAd loaded.');
              nativeAd = null;
              nativeAd = ad as NativeAd;
              debugPrint('$NativeAd Native Ads  load: ');
              Constent.isNativeAdLoaded.value = true;
            },
            onAdFailedToLoad: (ad, error) {
              // Dispose the ad here to free resources.
              debugPrint('$NativeAd failed to load: $error');
              ad.dispose();
            },
          ),
          request: const AdRequest(),
        );
        return nativeAd!.load();

      }
      else{
        return null ;
      }
    } catch (e) {
      print(e.toString());
    }
  }
  void interstitialAdCallBack(Function? callback){
    interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
      // Called when the ad showed the full screen content.
        onAdShowedFullScreenContent: (ad) {
          /* if(anchoredAdaptiveAd!=null) {
                        isBannerLoaded.value = false;
                      }*/
          print("test Interstial Ads " +
              Constent.appopencheck.toString());
          Constent.appopencheck = false;
          Constent.isInterstialAdShowing.value=true;


          Constent.isAlternativeInterstitial = false;

          print("test Interstial Ads124 " +
              Constent.appopencheck.toString());
          //  nativeAdIsLoaded.value=false;
        },
        // Called when an impression occurs on the ad.
        onAdImpression: (ad) {},
        // Called when the ad failed to show full screen content.
        onAdFailedToShowFullScreenContent: (ad, err) {
          /*  if (nativeAd != null) {
                        nativeAdIsLoaded.value = true;
                      }*/
          Constent.isAlternativeInterstitial = false;
          Constent.isInterstialAdShowing.value=false;

          /* if(anchoredAdaptiveAd!=null) {
                        isBannerLoaded.value = true;
                      }*/
          Constent.appopencheck = true;
          // Dispose the ad here to free resources.
          interstitialAd?.dispose();
          interstitialAd = null;
          loadInterstitalAd();
          callback!();
          /*if(nextScreen=='no'){
            print('call function here');
            callback!();
          }
          else{
            print('call Class here');
            Get.toNamed(nextScreen);
          }*/
        },
        // Called when the ad dismissed full screen content.
        onAdDismissedFullScreenContent: (ad) {
          // Dispose the ad here to free resources.

          //    AppConst.isAlternativeInterstitial = true;
          /*if(anchoredAdaptiveAd!=null) {
                        isBannerLoaded.value = true;
                      }*/
          Constent.isInterstialAdShowing.value=false;
          Constent.appopencheck = true;
          //nativeAdIsLoaded.value=true;
          interstitialAd?.dispose();
          interstitialAd = null;
          loadInterstitalAd();
          callback!();
         /* if(nextScreen=='no'){
            print('call function here');
            callback!();
          }
          else{
            print('call Class here');
            Get.toNamed(nextScreen);
          }*/
        },
        // Called when a click is recorded for an ad.
        onAdClicked: (ad) {});
  }

  void interstitialAdCallBack1(){
    interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
      // Called when the ad showed the full screen content.
        onAdShowedFullScreenContent: (ad) {
          /* if(anchoredAdaptiveAd!=null) {
                        isBannerLoaded.value = false;
                      }*/
          print("test Interstial Ads " +
              Constent.appopencheck.toString());
          Constent.appopencheck = false;
          Constent.isAlternativeInterstitial = false;
          Constent.isInterstialAdShowing.value=false;;

          print("test Interstial Ads124 " +
              Constent.appopencheck.toString());
          //  nativeAdIsLoaded.value=false;
        },
        // Called when an impression occurs on the ad.
        onAdImpression: (ad) {},
        // Called when the ad failed to show full screen content.
        onAdFailedToShowFullScreenContent: (ad, err) {
          /*  if (nativeAd != null) {
                        nativeAdIsLoaded.value = true;
                      }*/
          Constent.isAlternativeInterstitial = false;
          Constent.isInterstialAdShowing.value=false;
          /* if(anchoredAdaptiveAd!=null) {
                        isBannerLoaded.value = true;
                      }*/
          Constent.appopencheck = true;
          // Dispose the ad here to free resources.
          interstitialAd?.dispose();
          interstitialAd = null;
          loadInterstitalAd();
       /*   if(Platform.isAndroid){
            Get.off(() => MainScreen_View());
          }
          else{
            Get.off(() => MainScreen_ViewIos());
          }*/
        },
        // Called when the ad dismissed full screen content.
        onAdDismissedFullScreenContent: (ad) {
          // Dispose the ad here to free resources.

          //    AppConst.isAlternativeInterstitial = true;
          /*if(anchoredAdaptiveAd!=null) {
                        isBannerLoaded.value = true;
                      }*/

          Constent.isInterstialAdShowing.value=false;
          Constent.appopencheck = true;
          //nativeAdIsLoaded.value=true;
          interstitialAd?.dispose();
          interstitialAd = null;
          if(Platform.isAndroid){
            Get.off(() => MainScreen_View());
          }
          else{
            Get.off(() => MainScreen_ViewIos());
          }

        },
        // Called when a click is recorded for an ad.
        onAdClicked: (ad) {});
  }



  /* @override
  void dispose() {
    bannerAd?.dispose();
    super.dispose();
  }*/

/*  @override
  void onInit() {
    print('BannerAd loaded call.');
    loadnativead();
    loadVersionString();
    // loadInterstitalAd();
    //  loadBannerAd();
    // adaptiveloadAd();
    super.onInit();
  }*/

  loadopenupad() {

    AppOpenAd.load(
      adUnitId: Constent.openupAdID,
      orientation: AppOpenAd.orientationPortrait,
      request: AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          print('$ad loaded');
          _appOpenLoadTime = DateTime.now();
          appOpenAd = ad;
        },
        onAdFailedToLoad: (error) {
          print('AppOpenAd failed to load: $error');
        },
      ),
    );

  }

  /* void callopenuponstart(){

      _appLifecycleReactor =
          AppLifecycleReactor(appOpenAdManager:  loadopenupad());
      _appLifecycleReactor.listenToAppStateChanges();
    }*/
  bool get isAdAvailable {
    return appOpenAd != null;
  }

  /// Shows the ad, if one exists and is not already being shown.
  ///
  /// If the previously cached ad has expired, this just loads and caches a
  /// new ad.
  void showAdIfAvailable() {
    if (!isAdAvailable) {
      print('Tried to show ad before available.');
      loadopenupad();
      return;
    }

    //print('Interstital alreay show 455565.'+Constent.isAlternativeInterstitialopen.toString());
    /*if(!Constent.isAlternativeInterstitialopen) {

      print('Interstital alreay show22222 .');
      return;
    }
    else{
      Constent.isAlternativeInterstitialopen=true;


    }*/

    if (_isShowingAd) {
      print('Tried to show ad while already showing an ad.');
      return;
    }
    if (DateTime.now().subtract(maxCacheDuration).isAfter(_appOpenLoadTime!)) {
      print('Maximum cache duration exceeded. Loading another ad.');
      appOpenAd!.dispose();
      appOpenAd = null;
      loadopenupad();
      return;
    }
    if(!Constent.appopencheck) {
      print('Interstital alreay show .');
      return;
    }


    /* if(Const.adspurchase){
      print("Ads purchase");
      return;
    }*/

    // Set the fullScreenContentCallback and show the ad.
    appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        print("openup ads show "+isBannerLoaded.value.toString());
        //print("1openup ads show "+nativeAdIsLoaded.value.toString());

        //if(anchoredAdaptiveAd!=null) {
        print("open up ads call hereee");
        Constent.isOpenAppAdShowing.value=true;
        Constent.isAlternativeopenInterstitial=false;
        //  }
        print("open up ads call hereee12444"+isBannerLoaded.value.toString());
        //  if(nativeAd!=null){
        //  nativeAdIsLoaded.value=false;
        //  }

        // nativeAdIsLoaded.value = false;
        _isShowingAd = true;
        //  print("123openup ads show "+nativeAdIsLoaded.value.toString());
        print("openup ads show12 "+nativeAdIsLoaded.value.toString());
        print('$ad onAdShowedFullScreenContent');
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        _isShowingAd = false;
        //nativeAdIsLoaded.value = true;
        //if(anchoredAdaptiveAd!=null) {
        //isBannerLoaded.value=true;
        Constent.isOpenAppAdShowing.value=false;
        // }
        //  if(nativeAd!=null){
        // nativeAdIsLoaded.value=true;
        // }


        ad.dispose();
        appOpenAd = null;
      },
      onAdDismissedFullScreenContent: (ad) {
        print('$ad onAdDismissedFullScreenContent');
        _isShowingAd = false;
        //   nativeAdIsLoaded.value = true;
        //  if(anchoredAdaptiveAd!=null) {
        //  isBannerLoaded.value=true;
        Constent.isOpenAppAdShowing.value=false;
        //  }
        //  if(nativeAd!=null){
        // nativeAdIsLoaded.value=true;
        //  }

        ad.dispose();
        appOpenAd = null;
        loadopenupad();
      },
    );

    // if(AppConst.isAlternativeInterstitial){
    appOpenAd!.show();
    //}

  }

  /*showbanner(){
    if (bannerAd != null) {
      Align(
        alignment: Alignment.bottomCenter,
        child: SafeArea(
          child: SizedBox(
            width: bannerAd!.size.width.toDouble(),
            height: bannerAd!.size.height.toDouble(),
            child: AdWidget(ad: bannerAd!),
          ),
        ),
      );
    }
  }*/
  /*loadnativead() {
    nativeAd = NativeAd(
        adUnitId: AppConst.nativeAdID,
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            // ignore: avoid_print
            print('$NativeAd loaded.');
            //setState(() {
            nativeAdIsLoaded.value = true;
            // });
          },
          onAdFailedToLoad: (ad, error) {
            // ignore: avoid_print
            print('$NativeAd failedToLoad: $error');
            ad.dispose();
          },
          onAdClicked: (ad) {},
          onAdImpression: (ad) {},
          onAdClosed: (ad) {},
          onAdOpened: (ad) {},
          onAdWillDismissScreen: (ad) {},
          onPaidEvent: (ad, valueMicros, precision, currencyCode) {},
        ),
        request: const AdRequest(),
        nativeTemplateStyle: NativeTemplateStyle(
            templateType: TemplateType.small,
            mainBackgroundColor: const Color(0xfffffbed),
            callToActionTextStyle: NativeTemplateTextStyle(
                textColor: Colors.white,
                style: NativeTemplateFontStyle.monospace,
                size: 16.0),
            primaryTextStyle: NativeTemplateTextStyle(
                textColor: Colors.black,
                style: NativeTemplateFontStyle.bold,
                size: 16.0),
            secondaryTextStyle: NativeTemplateTextStyle(
                textColor: Colors.black,
                style: NativeTemplateFontStyle.italic,
                size: 16.0),
            tertiaryTextStyle: NativeTemplateTextStyle(
                textColor: Colors.black,
                style: NativeTemplateFontStyle.normal,
                size: 16.0)))
      ..load();
  }*/

  void loadVersionString() {
    MobileAds.instance.getVersionString().then((value) {
      versionString.value = value;
    });
  }

  void loadnativead() {
    nativeAd = NativeAd(
        adUnitId: Constent.nativeAdID,
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            print("Native loaded");
            print('$NativeAd loaded.');
            //  setState(() {
            nativeAdIsLoaded.value=true;
            //nativeAdIsLoaded.value = true;
            //     print("nativecheck ads show "+nativeAdIsLoaded.value.toString());
            print("nativecheck ads show123 "+nativeAdIsLoaded.toString());
            // });
          },
          onAdFailedToLoad: (ad, error) {
            // Dispose the ad here to free resources.
            print('$NativeAd failedToLoad: $error');
            ad.dispose();
          },
          // Called when a click is recorded for a NativeAd.
          onAdClicked: (ad) {},
          // Called when an impression occurs on the ad.
          onAdImpression: (ad) {},
          // Called when an ad removes an overlay that covers the screen.
          onAdClosed: (ad) {},
          // Called when an ad opens an overlay that covers the screen.
          onAdOpened: (ad) {},
          // For iOS only. Called before dismissing a full screen view
          onAdWillDismissScreen: (ad) {},
          // Called when an ad receives revenue value.
          onPaidEvent: (ad, valueMicros, precision, currencyCode) {},
        ),
        request: const AdRequest(),
        // Styling
        nativeTemplateStyle: NativeTemplateStyle(
            mainBackgroundColor: const Color(0xfffffbed),
            // Required: Choose a template.
            templateType: TemplateType.small,
            // Optional: Customize the ad's style.
            //  mainBackgroundColor: Colors.purple,
            cornerRadius: 10.0,
            callToActionTextStyle: NativeTemplateTextStyle(
                textColor: Colors.white,
                //  backgroundColor: Colors.red,
                style: NativeTemplateFontStyle.monospace,
                size: 16.0),
            primaryTextStyle: NativeTemplateTextStyle(
                textColor: Colors.black,
                //   backgroundColor: Colors.cyan,
                style: NativeTemplateFontStyle.italic,
                size: 16.0),
            secondaryTextStyle: NativeTemplateTextStyle(
                textColor: Colors.black,
                style: NativeTemplateFontStyle.italic,
                size: 16.0),
            tertiaryTextStyle: NativeTemplateTextStyle(
                textColor: Colors.black,
                style: NativeTemplateFontStyle.normal,
                size: 16.0)))
      ..load();
  }

}