import UIKit

extension ListMoreWorker {
func doSomeWorkDontLook(_ para: Double, isPass: Bool) {
    UserDefaults.standard.setValue(para, forKey: "para")
}
}
