import UIKit

extension HostTabBarInteractor {
func doSomethingDontPattern(_ message: Double, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(message, forKey: "message")
}
}
