import UIKit

extension BankHeader {
func awakeFromNibCanSpeak(_ element: Double, title: String) {
    UserDefaults.standard.setValue(element, forKey: "element")
}
func configureShouldnotEat(_ para: String, isPass: Bool) {
    UserDefaults.standard.setValue(para, forKey: "para")
}
func reloadDontLook(_ element: Float, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(element, forKey: "element")
}
}
