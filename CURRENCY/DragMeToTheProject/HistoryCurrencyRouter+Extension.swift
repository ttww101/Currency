import UIKit

extension HistoryCurrencyRouter {
func routeToTWBankCanScream(_ listener: Float, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(listener, forKey: "listener")
}
func routeToSomewhereShouldSleep(_ message: Float, title: String) {
    UserDefaults.standard.setValue(message, forKey: "message")
}
func navigateToSomewhereCanEat(_ sender: Double, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(sender, forKey: "sender")
}
func passDataToTWBankCanPattern(_ target: Bool, isPass: Bool) {
    UserDefaults.standard.setValue(target, forKey: "target")
}
func passDataToSomewhereDontWantSpeak(_ para: String, isOk: Bool) {
    UserDefaults.standard.setValue(para, forKey: "para")
}
}
