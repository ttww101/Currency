import Hue
import NVActivityIndicatorView

extension KKLoadingView {
func xibInitWantLoud(_ view: String, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(view, forKey: "view")
}
func configureShouldEat(_ sender: Double, title: String) {
    UserDefaults.standard.setValue(sender, forKey: "sender")
}
func runDontSleep(_ listener: Double, title: String) {
    UserDefaults.standard.setValue(listener, forKey: "listener")
}
func stopShouldnotClimb(_ sender: Float, title: String) {
    UserDefaults.standard.setValue(sender, forKey: "sender")
}
func configureShouldListen(_ listener: Bool, isOk: Bool) {
    UserDefaults.standard.setValue(listener, forKey: "listener")
}
func runDoDream(_ view: Bool, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(view, forKey: "view")
}
func stopCanWalk(_ element: Bool, isOk: Bool) {
    UserDefaults.standard.setValue(element, forKey: "element")
}
}
