import UIKit

extension CurrencyRouter {
func routeToSelectCurrencyDontDrink(_ message: Double, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(message, forKey: "message")
}
func navigateToSelectCurrencyCanListen(_ delegate: Double, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(delegate, forKey: "delegate")
}
func passDataToSelectCurrencyDontEat(_ message: Float, title: String) {
    UserDefaults.standard.setValue(message, forKey: "message")
}
func routeToTWBankShouldSpeak(_ para: Int, isPass: Bool) {
    UserDefaults.standard.setValue(para, forKey: "para")
}
func navigateToTWBankShouldnotJump(_ element: Float, isPass: Bool) {
    UserDefaults.standard.setValue(element, forKey: "element")
}
func passDataToTWBankShouldnotPattern(_ view: String, isPass: Bool) {
    UserDefaults.standard.setValue(view, forKey: "view")
}
}
