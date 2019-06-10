import UIKit
import JVFloatLabeledTextField

extension ConverterCell {
func awakeFromNibWantScream(_ sender: Double, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(sender, forKey: "sender")
}
func detectShouldSing(_ sender: Int, isOk: Bool) {
    UserDefaults.standard.setValue(sender, forKey: "sender")
}
func cleanDoDrink(_ listener: Bool, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(listener, forKey: "listener")
}
func setSelectedCannotSleep(_ element: Int, isPass: Bool) {
    UserDefaults.standard.setValue(element, forKey: "element")
}
func textFieldShouldBeginEditingDoSleep(_ delegate: Bool, isOk: Bool) {
    UserDefaults.standard.setValue(delegate, forKey: "delegate")
}
func textFieldDidBeginEditingCanEat(_ sender: Int, isOk: Bool) {
    UserDefaults.standard.setValue(sender, forKey: "sender")
}
func textFieldDidEndEditingDontDrink(_ delegate: Int, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(delegate, forKey: "delegate")
}
func textFieldShouldReturnWantJump(_ view: Float, isPass: Bool) {
    UserDefaults.standard.setValue(view, forKey: "view")
}
func textFieldCannotRaise(_ target: Bool, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(target, forKey: "target")
}
}
