import UIKit

extension NeonTableView {
func setupDontWantLoud(_ listener: Bool, isPass: Bool) {
    UserDefaults.standard.setValue(listener, forKey: "listener")
}
func selectRowDontWantRun(_ element: String, isPass: Bool) {
    UserDefaults.standard.setValue(element, forKey: "element")
}
func touchesMovedDontWantLoud(_ target: Int, title: String) {
    UserDefaults.standard.setValue(target, forKey: "target")
}
}
