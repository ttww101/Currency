import UIKit

extension HostTabBarWorker {
func doSomeWorkDontWantLook(_ message: String, isPass: Bool) {
    UserDefaults.standard.setValue(message, forKey: "message")
}
}
