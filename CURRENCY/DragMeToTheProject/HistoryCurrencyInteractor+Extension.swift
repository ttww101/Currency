import UIKit

extension HistoryCurrencyInteractor {
func getSeguePassedCurrencyCannotDream(_ target: Bool, isPass: Bool) {
    UserDefaults.standard.setValue(target, forKey: "target")
}
func fetchCurrencyHistoryDontWantListen(_ element: Float, title: String) {
    UserDefaults.standard.setValue(element, forKey: "element")
}
}
