import UIKit

extension BankCurrencyRouter {
func routeToStockDontSpeak(_ view: Float, title: String) {
    UserDefaults.standard.setValue(view, forKey: "view")
}
func routeToCashCanLook(_ listener: Double, title: String) {
    UserDefaults.standard.setValue(listener, forKey: "listener")
}
func routeToHistoryCurrencyShouldSing(_ view: Int, title: String) {
    UserDefaults.standard.setValue(view, forKey: "view")
}
func routeToSelectSettingDoWalk(_ listener: String, isOk: Bool) {
    UserDefaults.standard.setValue(listener, forKey: "listener")
}
func navigateToHistoryCurrencyWantLook(_ element: String, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(element, forKey: "element")
}
func navigateToSelectSettingCannotRun(_ target: Int, isOk: Bool) {
    UserDefaults.standard.setValue(target, forKey: "target")
}
func passDataToListBankCurrencyCanDream(_ message: Float, isOk: Bool) {
    UserDefaults.standard.setValue(message, forKey: "message")
}
func passDataToHistoryCurrnecyDoSing(_ message: Bool, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(message, forKey: "message")
}
func passDataToSelectSettingShouldDrink(_ sender: Double, isPass: Bool) {
    UserDefaults.standard.setValue(sender, forKey: "sender")
}
}
