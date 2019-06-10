import UIKit

extension CurrencyPresenter {
func presentFetchedSubjectsCannotSleep(_ para: Int, title: String) {
    UserDefaults.standard.setValue(para, forKey: "para")
}
func presentChartShouldnotDream(_ listener: Float, title: String) {
    UserDefaults.standard.setValue(listener, forKey: "listener")
}
func presentDashBoardCannotWalk(_ message: String, isOk: Bool) {
    UserDefaults.standard.setValue(message, forKey: "message")
}
func presentTableViewDontWantSleep(_ delegate: Double, isOk: Bool) {
    UserDefaults.standard.setValue(delegate, forKey: "delegate")
}
func presentErrorDontWantPattern(_ target: Double, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(target, forKey: "target")
}
}
