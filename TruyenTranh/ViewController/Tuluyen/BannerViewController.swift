//
//  BannerViewController.swift
//  BangoohTivi
//
//  Created by Trung Hoang Van on 3/15/20.
//  Copyright © 2020 Trung Hoang Van. All rights reserved.
//

import UIKit
import GoogleMobileAds

protocol BannerViewControllerDelegate {
    func finishAds()
}
class BannerViewController: BaseViewController, GADRewardedAdDelegate {
    var adUnitID:String? = nil
    var rewardedAd: GADRewardedAd?
    var delegate:BannerViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showLoading()
        title = "TU LUYỆN"
        rewardedAd = createAndLoadRewardedAd()
        rewardedAd = GADRewardedAd(adUnitID: adUnitID!)
        rewardedAd?.load(GADRequest()) { error in
            if error != nil {
                // Handle ad failed to load case.
                self.hideLoading()
            } else {
                // Ad successfully loaded.
                if self.rewardedAd?.isReady == true {
                    self.rewardedAd?.present(fromRootViewController: self, delegate:self)
                    self.hideLoading()
                }
            }
        }
    }
    
    /// Tells the delegate that the user earned a reward.
    func rewardedAd(_ rewardedAd: GADRewardedAd, userDidEarn reward: GADAdReward) {
        print("Reward received with currency: \(reward.type), amount \(reward.amount).")
        self.dismiss(animated: true) {
            self.delegate?.finishAds()
        }
    }
    /// Tells the delegate that the rewarded ad was presented.
    func rewardedAdDidPresent(_ rewardedAd: GADRewardedAd) {
        print("Rewarded ad presented.")
    }
    /// Tells the delegate that the rewarded ad was dismissed.
    func rewardedAdDidDismiss(_ rewardedAd: GADRewardedAd) {
        print("Rewarded ad dismissed.")
        
    }
    /// Tells the delegate that the rewarded ad failed to present.
    func rewardedAd(_ rewardedAd: GADRewardedAd, didFailToPresentWithError error: Error) {
        print("Rewarded ad failed to present.")
    }
    
    func createAndLoadRewardedAd() -> GADRewardedAd{
        rewardedAd = GADRewardedAd(adUnitID: "ca-app-pub-3940256099942544/1712485313")
        rewardedAd?.load(GADRequest()) { error in
          if let error = error {
            print("Loading failed: \(error)")
          } else {
            print("Loading Succeeded")
          }
        }
        return rewardedAd!
    }
}


