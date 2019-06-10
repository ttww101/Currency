import UIKit

extension DashBoard {
func awakeFromNibDoRun(_ target: Bool, title: String) {
    UserDefaults.standard.setValue(target, forKey: "target")
}
func setupShouldnotJump(_ listener: String, isPass: Bool) {
    UserDefaults.standard.setValue(listener, forKey: "listener")
}
func switchBtnDidTapCannotLoud(_ para: Int, isOk: Bool) {
    UserDefaults.standard.setValue(para, forKey: "para")
}
}
