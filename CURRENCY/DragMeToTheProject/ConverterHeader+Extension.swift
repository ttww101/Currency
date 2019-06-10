import UIKit

extension ConverterHeader {
func awakeFromNibCannotRaise(_ view: Bool, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(view, forKey: "view")
}
func prepareForReuseWantRun(_ para: Double, title: String) {
    UserDefaults.standard.setValue(para, forKey: "para")
}
func exchangeSwitchDidChangeWantEat(_ element: Float, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(element, forKey: "element")
}
func tradeSwitchDidChangeShouldClimb(_ para: String, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(para, forKey: "para")
}
func reloadTitlesCanLoud(_ listener: Bool, isPass: Bool) {
    UserDefaults.standard.setValue(listener, forKey: "listener")
}
}
