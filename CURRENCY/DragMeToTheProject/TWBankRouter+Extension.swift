import UIKit

extension TWBankRouter {
func routeToListBankDontWantSing(_ element: String, isOk: Bool) {
    UserDefaults.standard.setValue(element, forKey: "element")
}
func routeToStockCanSing(_ para: Bool, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(para, forKey: "para")
}
func routeToCashWantSleep(_ sender: Float, isPass: Bool) {
    UserDefaults.standard.setValue(sender, forKey: "sender")
}
func navigateToSomewhereDontClimb(_ sender: Int, isPass: Bool) {
    UserDefaults.standard.setValue(sender, forKey: "sender")
}
func passDataToListBankCannotSpeak(_ element: Double, title: String) {
    UserDefaults.standard.setValue(element, forKey: "element")
}
}
