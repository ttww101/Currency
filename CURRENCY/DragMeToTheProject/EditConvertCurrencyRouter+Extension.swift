import UIKit

extension EditConvertCurrencyRouter {
func routeToConvertCurrencyShouldLook(_ delegate: Double, isPass: Bool) {
    UserDefaults.standard.setValue(delegate, forKey: "delegate")
}
func navigateToConvertCurrencyDoScream(_ delegate: String, isPass: Bool) {
    UserDefaults.standard.setValue(delegate, forKey: "delegate")
}
func passDataToConvertCurrencyDontLoud(_ sender: Double, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(sender, forKey: "sender")
}
}
