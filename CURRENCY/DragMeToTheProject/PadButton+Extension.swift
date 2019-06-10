import UIKit

extension PadButton {
func setupDontWantClimb(_ para: Bool, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(para, forKey: "para")
}
func tapButtonDontWantDrink(_ delegate: Bool, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(delegate, forKey: "delegate")
}
func longPressButtonWantClimb(_ message: String, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(message, forKey: "message")
}
func gestureRecognizerShouldSing(_ delegate: Bool, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(delegate, forKey: "delegate")
}
}
