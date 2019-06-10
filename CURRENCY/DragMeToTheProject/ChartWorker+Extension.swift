import UIKit

extension ChartWorker {
func doSomeWorkCanEat(_ target: Float, isOk: Bool) {
    UserDefaults.standard.setValue(target, forKey: "target")
}
}
