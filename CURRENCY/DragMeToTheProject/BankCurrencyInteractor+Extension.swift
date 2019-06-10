import UIKit

extension BankCurrencyInteractor {
func changeBankDoRun(_ message: Float, isPass: Bool) {
    UserDefaults.standard.setValue(message, forKey: "message")
}
func fetchBankCurrenciesCanEat(_ sender: Double, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(sender, forKey: "sender")
}
}
