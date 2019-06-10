import UIKit

extension ChartPresenter {
func presentFetchedHistoryWantEat(_ para: Double, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(para, forKey: "para")
}
}
