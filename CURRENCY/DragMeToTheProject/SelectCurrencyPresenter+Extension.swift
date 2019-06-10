import UIKit

extension SelectCurrencyPresenter {
func presentSourcesDontWantLoud(_ element: String, title: String) {
    UserDefaults.standard.setValue(element, forKey: "element")
}
func presentCurrenciesShouldDance(_ message: Float, title: String) {
    UserDefaults.standard.setValue(message, forKey: "message")
}
}
