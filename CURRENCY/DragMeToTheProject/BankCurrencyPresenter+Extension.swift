import UIKit

extension BankCurrencyPresenter {
func presentFetchedBankCurrenciesCanSleep(_ para: Int, isPass: Bool) {
    UserDefaults.standard.setValue(para, forKey: "para")
}
func presentErrorDontRaise(_ sender: Double, title: String) {
    UserDefaults.standard.setValue(sender, forKey: "sender")
}
}
