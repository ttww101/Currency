import UIKit

extension HistoryCurrencyWorker {
func getHistoryDontWantListen(_ element: Float, isPass: Bool) {
    UserDefaults.standard.setValue(element, forKey: "element")
}
}
