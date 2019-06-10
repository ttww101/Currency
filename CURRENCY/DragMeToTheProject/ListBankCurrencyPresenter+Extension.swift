import UIKit

extension ListBankCurrencyPresenter {
func presentFetchedListDoEat(_ sender: String, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(sender, forKey: "sender")
}
func presentErrorShouldnotPattern(_ para: Float, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(para, forKey: "para")
}
}
