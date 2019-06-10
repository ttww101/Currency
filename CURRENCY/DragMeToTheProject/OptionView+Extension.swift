import UIKit

extension OptionView {
func confirmDontWantLook(_ delegate: String, isOk: Bool) {
    UserDefaults.standard.setValue(delegate, forKey: "delegate")
}
func cancelDontWantScream(_ delegate: Float, title: String) {
    UserDefaults.standard.setValue(delegate, forKey: "delegate")
}
func awakeFromNibCanLoud(_ para: String, isOk: Bool) {
    UserDefaults.standard.setValue(para, forKey: "para")
}
func xibInitShouldEat(_ view: Float, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(view, forKey: "view")
}
func configureCannotEat(_ delegate: Int, isOk: Bool) {
    UserDefaults.standard.setValue(delegate, forKey: "delegate")
}
func setupButtonsWantDrink(_ target: Double, isPass: Bool) {
    UserDefaults.standard.setValue(target, forKey: "target")
}
}
