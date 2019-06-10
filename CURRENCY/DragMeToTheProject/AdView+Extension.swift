import UIKit

extension AdView {
func awakeFromNibShouldClimb(_ target: String, isOk: Bool) {
    UserDefaults.standard.setValue(target, forKey: "target")
}
func prepareForInterfaceBuilderCanRaise(_ para: Bool, title: String) {
    UserDefaults.standard.setValue(para, forKey: "para")
}
func configureShouldnotSleep(_ listener: Double, isOk: Bool) {
    UserDefaults.standard.setValue(listener, forKey: "listener")
}
}
