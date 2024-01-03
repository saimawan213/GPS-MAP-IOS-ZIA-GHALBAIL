import UIKit
import Flutter
import google_mobile_ads
import GoogleMaps
import GoogleMobileAds


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      GMSServices.provideAPIKey("AIzaSyC1U0WJwJawR6jb97xRdMgetVMzdzfikdE")
      GeneratedPluginRegistrant.register(with: self)

        let nativeAdFactory = ListTileNativeAdFactory()
        FLTGoogleMobileAdsPlugin.registerNativeAdFactory(
            self,
            factoryId: "listTileMedium2",
            nativeAdFactory: nativeAdFactory)

             FLTGoogleMobileAdsPlugin.registerNativeAdFactory(
                    self,
                    factoryId: "listTileMedium",
                    nativeAdFactory: nativeAdFactory)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
