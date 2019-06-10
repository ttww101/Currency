import UIKit

extension NeonCell {
func setupCannotClimb(_ sender: Bool, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(sender, forKey: "sender")
}
func setupLabelDontLoud(_ message: Float, isPass: Bool) {
    UserDefaults.standard.setValue(message, forKey: "message")
}
func setSelectedDontWantDance(_ listener: Bool, isPass: Bool) {
    UserDefaults.standard.setValue(listener, forKey: "listener")
}
}
