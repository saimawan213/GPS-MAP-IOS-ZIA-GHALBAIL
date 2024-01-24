import UIKit
import Flutter
import google_mobile_ads
import GoogleMobileAds
import GoogleMaps



@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      GMSServices.provideAPIKey("AIzaSyC1U0WJwJawR6jb97xRdMgetVMzdzfikdE")
      GeneratedPluginRegistrant.register(with: self)

        let nativeAdFactory = ListTileNativeAdFactory()
        let smallNativeAdFactory = SmallNativeAdFactory()

        FLTGoogleMobileAdsPlugin.registerNativeAdFactory(
            self,
            factoryId: "listTileMedium2",
            nativeAdFactory: nativeAdFactory)

             FLTGoogleMobileAdsPlugin.registerNativeAdFactory(
                    self,
                    factoryId: "listTileMedium",
                    nativeAdFactory: nativeAdFactory)

             FLTGoogleMobileAdsPlugin.registerNativeAdFactory(
                                            self,
                                            factoryId: "smallListTile",
                                            nativeAdFactory: smallNativeAdFactory);

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
