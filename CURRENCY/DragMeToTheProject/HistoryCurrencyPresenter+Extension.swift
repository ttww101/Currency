import UIKit

extension HistoryCurrencyPresenter {
func presentSeguePassedCurrencyCanJump(_ element: Int, isPass: Bool) {
    UserDefaults.standard.setValue(element, forKey: "element")
}
func presentFetchedCurrencyHistoryCanDrink(_ para: String, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(para, forKey: "para")
}
func presentErrorDoPattern(_ message: Int, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(message, forKey: "message")
}
}
