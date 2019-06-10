import UIKit

extension EditConvertCurrencyPresenter {
func presentBankCurrenciesCannotRun(_ message: Double, title: String) {
    UserDefaults.standard.setValue(message, forKey: "message")
}
func presentToggledFavoriteCurrenciesDoClimb(_ message: Bool, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(message, forKey: "message")
}
}
