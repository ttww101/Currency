import UIKit

extension ScreenshotChartVC {
func viewDidLoadDontLook(_ listener: Double, title: String) {
    UserDefaults.standard.setValue(listener, forKey: "listener")
}
func configureTestImageViewDontWantEat(_ delegate: String, title: String) {
    UserDefaults.standard.setValue(delegate, forKey: "delegate")
}
}
