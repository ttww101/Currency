import UIKit

extension SelectSettingRouter {
func routeToSomewhereWantDance(_ view: Float, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(view, forKey: "view")
}
func navigateToSomewhereShouldnotLook(_ listener: String, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(listener, forKey: "listener")
}
func passDataToSomewhereCanSleep(_ element: String, isPass: Bool) {
    UserDefaults.standard.setValue(element, forKey: "element")
}
}
