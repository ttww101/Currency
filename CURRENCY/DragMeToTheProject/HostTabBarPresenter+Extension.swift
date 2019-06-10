import UIKit

extension HostTabBarPresenter {
func presentSomethingShouldSpeak(_ view: String, isOk: Bool) {
    UserDefaults.standard.setValue(view, forKey: "view")
}
}
