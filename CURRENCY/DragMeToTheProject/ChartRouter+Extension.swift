import UIKit

extension ChartRouter {
func routeToSomewhereDontWantRaise(_ message: Double, isPass: Bool) {
    UserDefaults.standard.setValue(message, forKey: "message")
}
func routeToChartViewControllerWantLook(_ target: Double, isPass: Bool) {
    UserDefaults.standard.setValue(target, forKey: "target")
}
func navigateToSomewhereCannotJump(_ target: Double, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(target, forKey: "target")
}
func navigateToChartCanDance(_ delegate: Int, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(delegate, forKey: "delegate")
}
func passDataToSomewhereShouldnotDance(_ sender: Int, isPass: Bool) {
    UserDefaults.standard.setValue(sender, forKey: "sender")
}
func passDataToChartShouldnotJump(_ listener: Double, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(listener, forKey: "listener")
}
}
