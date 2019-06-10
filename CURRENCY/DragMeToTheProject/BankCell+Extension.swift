import UIKit
import Kingfisher

extension BankCell {
func awakeFromNibCanWalk(_ delegate: String, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(delegate, forKey: "delegate")
}
func prepareForReuseDoListen(_ target: Int, isPass: Bool) {
    UserDefaults.standard.setValue(target, forKey: "target")
}
func setSelectedDoRaise(_ listener: Double, isPass: Bool) {
    UserDefaults.standard.setValue(listener, forKey: "listener")
}
func configureDontPattern(_ delegate: Int, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(delegate, forKey: "delegate")
}
}
