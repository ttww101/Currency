import UIKit

extension ListBankCurrencyRouter {
func routeToUpdateBankCurrencyShouldClimb(_ message: Bool, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(message, forKey: "message")
}
func passDataToBankCurrencyDoEat(_ element: String, isPass: Bool) {
    UserDefaults.standard.setValue(element, forKey: "element")
}
}
