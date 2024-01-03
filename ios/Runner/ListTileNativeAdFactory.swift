import google_mobile_ads

// TODO: Implement ListTileNativeAdFactory
class ListTileNativeAdFactory : FLTNativeAdFactory {

    func createNativeAd(_ nativeAd: GADNativeAd,
                        customOptions: [AnyHashable : Any]? = nil) -> GADNativeAdView? {
        let nibView = Bundle.main.loadNibNamed("NativeAdView", owner: nil, options: nil)!.first
        let nativeAdView = nibView as! GADNativeAdView

        (nativeAdView.headlineView as! UILabel).text = nativeAd.headline

        (nativeAdView.bodyView as! UILabel).text = nativeAd.body
       nativeAdView.bodyView!.isHidden = nativeAd.body == nil
        nativeAdView.bodyView!.isHidden = true

        (nativeAdView.iconView as! UIImageView).image = nativeAd.icon?.image
        nativeAdView.iconView!.isHidden = nativeAd.icon == nil

        (nativeAdView.advertiserView as? UILabel)?.text = nativeAd.advertiser
        nativeAdView.advertiserView?.isHidden = nativeAd.advertiser == nil

        nativeAdView.callToActionView?.isUserInteractionEnabled = false

        // Connect the GADMediaView outlet from your XIB file
             let mediaView = nativeAdView.mediaView
             mediaView?.mediaContent = nativeAd.mediaContent


        nativeAdView.nativeAd = nativeAd

        return nativeAdView
    }
}
