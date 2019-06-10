import UIKit

extension ListBankCurrencyInteractor {
func fetchCurrencyListDontWantLoud(_ listener: Int, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(listener, forKey: "listener")
}
func updateBankDoDrink(_ para: String, isPass: Bool) {
    UserDefaults.standard.setValue(para, forKey: "para")
}
func showErrorCannotSleep(_ sender: Int, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(sender, forKey: "sender")
}
}
