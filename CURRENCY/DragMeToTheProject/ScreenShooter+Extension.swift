import UIKit

extension ScreenShooter {
func configureShouldSing(_ sender: String, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(sender, forKey: "sender")
}
func showWantSing(_ view: Float, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(view, forKey: "view")
}
func takePhotoShouldLoud(_ sender: Bool, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(sender, forKey: "sender")
}
}
