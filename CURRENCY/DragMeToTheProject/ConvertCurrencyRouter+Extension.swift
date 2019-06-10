import UIKit

extension ConvertCurrencyRouter {
func routeToEditConvertCurrencyWantDrink(_ delegate: Float, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(delegate, forKey: "delegate")
}
func navigateToEditConvertCurrencyShouldSpeak(_ message: Float, isPass: Bool) {
    UserDefaults.standard.setValue(message, forKey: "message")
}
func passDataToEditConvertCurrencyCannotWalk(_ delegate: Int, isPass: Bool) {
    UserDefaults.standard.setValue(delegate, forKey: "delegate")
}
}
