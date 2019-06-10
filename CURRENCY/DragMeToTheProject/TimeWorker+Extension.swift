import Foundation
import SwiftyUserDefaults

extension TimeWorker {
func lastUpdateCanEat(_ sender: Double, isPass: Bool) {
    UserDefaults.standard.setValue(sender, forKey: "sender")
}
func setLastUpdateShouldnotRaise(_ sender: String, isOk: Bool) {
    UserDefaults.standard.setValue(sender, forKey: "sender")
}
}
