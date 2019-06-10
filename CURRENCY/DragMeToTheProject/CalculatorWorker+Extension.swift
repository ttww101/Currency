import UIKit

extension CalculatorWorker {
func calculateCanSleep(_ listener: String, isOk: Bool) {
    UserDefaults.standard.setValue(listener, forKey: "listener")
}
}
