import UIKit

extension EditConvertCurrencyWorker {
func loadAllCurrenciesCanEat(_ sender: Bool, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(sender, forKey: "sender")
}
func loadFavoriteCurrenciesWantSleep(_ sender: String, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(sender, forKey: "sender")
}
}
