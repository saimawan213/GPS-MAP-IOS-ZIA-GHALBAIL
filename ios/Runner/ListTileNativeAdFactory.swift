import google_mobile_ads

// TODO: Implement ListTileNativeAdFactory
class ListTileNativeAdFactory : FLTNativeAdFactory {

    func createNativeAd(_ nativeAd: GADNativeAd,
                        customOptions: [AnyHashable : Any]? = nil) -> GADNativeAdView? {
        let nibView = Bundle.main.loadNibNamed("NativeAdView", owner: nil, options: nil)!.first
        let nativeAdView = nibView as! GADNativeAdView

        (nativeAdView.headlineView as! UILabel).text = nativeAd.headline

      // (nativeAdView.bodyView as! UILabel).text = nativeAd.body
      // nativeAdView.bodyView!.isHidden = nativeAd.body == nil
        //nativeAdView.bodyView!.isHidden = true
        (nativeAdView.starRatingView as? UIImageView)?.image = imageOfStars(from: nativeAd.starRating)
          nativeAdView.starRatingView?.isHidden = nativeAd.starRating == nil

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

    func imageOfStars(from starRating: NSDecimalNumber?) -> UIImage? {
       guard let rating = starRating?.doubleValue else {
         return nil
       }
       if rating >= 5 {
         return UIImage(named: "stars_5")
       } else if rating >= 4.5 {
         return UIImage(named: "stars_4_5")
       } else if rating >= 4 {
         return UIImage(named: "stars_4")
       } else if rating >= 3.5 {
         return UIImage(named: "stars_3_5")
       } else {
         return nil
       }
     }
}
