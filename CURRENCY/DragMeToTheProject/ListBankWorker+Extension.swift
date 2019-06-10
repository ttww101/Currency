import UIKit

extension ListBankWorker {
func doSomeWorkWantEat(_ para: String, isPass: Bool) {
    UserDefaults.standard.setValue(para, forKey: "para")
}
}
