import UIKit

extension MyApp {
func reloadAppCanRaise(_ sender: Float, title: String) {
    UserDefaults.standard.setValue(sender, forKey: "sender")
}
func reloadViewControllerDoLoud(_ element: Double, isOk: Bool) {
    UserDefaults.standard.setValue(element, forKey: "element")
}
}
