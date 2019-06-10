import UIKit

extension ListMorePresenter {
func presentFetchedSettingsDontWantEat(_ message: Float, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(message, forKey: "message")
}
}
