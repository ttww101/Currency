import UIKit

extension TWBankInteractor {
func fetchTitleWantDance(_ element: Bool, isPass: Bool) {
    UserDefaults.standard.setValue(element, forKey: "element")
}
func fetchTWBanksSpecificCurrencyDoSleep(_ target: Float, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(target, forKey: "target")
}
}
