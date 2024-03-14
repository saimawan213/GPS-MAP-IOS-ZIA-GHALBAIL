import 'package:google_mobile_ads/google_mobile_ads.dart';

abstract class AdMobHelper {
  Future<void> loadInterstitialAd();

  Future<void> showInterstitialAd();

  Future<void> loadBannerAd({required Function(BannerAd) callback});

  Future<void> loadSmallNativeAd({required Function(BannerAd) callback});

  Future<void> loadMediumNativeAd({required Function(BannerAd) callback});
}
