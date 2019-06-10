import UIKit

extension ConvertCurrencyPresenter {
func presentFetchedCurrenciesCanRaise(_ delegate: Bool, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(delegate, forKey: "delegate")
}
func presentSwitchChangeDontLoud(_ target: Int, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(target, forKey: "target")
}
func presentEditedWantLoud(_ message: Int, isOk: Bool) {
    UserDefaults.standard.setValue(message, forKey: "message")
}
func presentFetchedDataDontWantSleep(_ listener: Double, isPass: Bool) {
    UserDefaults.standard.setValue(listener, forKey: "listener")
}
func presentErrorWantSleep(_ para: Double, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(para, forKey: "para")
}
func presentUpdateCellTextFieldDoRaise(_ sender: Bool, isPass: Bool) {
    UserDefaults.standard.setValue(sender, forKey: "sender")
}
func presentUpdateCellPlaceHolderDoJump(_ view: Int, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(view, forKey: "view")
}
}
