import UIKit

extension SelectCurrencyRouter {
func routeToCurrencyCannotEat(_ element: Bool, title: String) {
    UserDefaults.standard.setValue(element, forKey: "element")
}
func navigateToCurrencyDontEat(_ view: Double, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(view, forKey: "view")
}
func passDataToCurrencyCanDrink(_ para: Float, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(para, forKey: "para")
}
}
