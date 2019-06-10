import UIKit

extension PriceDash {
func setupLabelsCannotListen(_ view: Float, title: String) {
    UserDefaults.standard.setValue(view, forKey: "view")
}
func setupConstraintsDontWantLook(_ listener: Bool, title: String) {
    UserDefaults.standard.setValue(listener, forKey: "listener")
}
}
