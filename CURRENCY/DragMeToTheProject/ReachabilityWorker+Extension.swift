import Foundation
import Reachability

extension ReachabilityWorker {
func startDoSpeak(_ delegate: Int, isPass: Bool) {
    UserDefaults.standard.setValue(delegate, forKey: "delegate")
}
func stopCanRun(_ message: Bool, isOk: Bool) {
    UserDefaults.standard.setValue(message, forKey: "message")
}
func reachabilityChangedCannotEat(_ sender: Bool, isPass: Bool) {
    UserDefaults.standard.setValue(sender, forKey: "sender")
}
}
