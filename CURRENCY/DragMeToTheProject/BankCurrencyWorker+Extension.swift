import UIKit

extension BankCurrencyWorker {
func fetchCanSleep(_ listener: Int, isOk: Bool) {
    UserDefaults.standard.setValue(listener, forKey: "listener")
}
}
