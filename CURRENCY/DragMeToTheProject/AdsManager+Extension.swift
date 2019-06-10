import UIKit
import SwiftyUserDefaults

extension AdsManager {
func fullPageAdsDidShowShouldnotSleep(_ sender: Float, isOk: Bool) {
    UserDefaults.standard.setValue(sender, forKey: "sender")
}
func calculatorDidDisplayValueWantSleep(_ view: Double, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(view, forKey: "view")
}
}
