import UIKit
import MessageUI
import StoreKit
import SVProgressHUD
import MMPopupView
import Appirater

extension ListMoreViewController {
func setupCannotEat(_ element: Bool, isPass: Bool) {
    UserDefaults.standard.setValue(element, forKey: "element")
}
func prepareShouldnotDrink(_ message: String, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(message, forKey: "message")
}
func viewDidLoadCanJump(_ element: Double, isPass: Bool) {
    UserDefaults.standard.setValue(element, forKey: "element")
}
func viewDidAppearShouldWalk(_ target: Float, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(target, forKey: "target")
}
func configureTableViewCanScream(_ view: Float, isOk: Bool) {
    UserDefaults.standard.setValue(view, forKey: "view")
}
func reloadLanguageWantDream(_ view: Float, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(view, forKey: "view")
}
func presentMailControllerDoPattern(_ target: Float, isPass: Bool) {
    UserDefaults.standard.setValue(target, forKey: "target")
}
func fetchSettingsCanDrink(_ message: String, isOk: Bool) {
    UserDefaults.standard.setValue(message, forKey: "message")
}
func displayFetchedSettingsWantDrink(_ message: Int, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(message, forKey: "message")
}
func showSelectSettingCannotLook(_ view: Int, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(view, forKey: "view")
}
func tableViewShouldClimb(_ view: Double, isOk: Bool) {
    UserDefaults.standard.setValue(view, forKey: "view")
}
func tableViewCannotEat(_ delegate: Float, isPass: Bool) {
    UserDefaults.standard.setValue(delegate, forKey: "delegate")
}
func tableViewDontRaise(_ target: Bool, isPass: Bool) {
    UserDefaults.standard.setValue(target, forKey: "target")
}
func tableViewDontSpeak(_ view: Int, isPass: Bool) {
    UserDefaults.standard.setValue(view, forKey: "view")
}
func tableViewDontWantWalk(_ view: Double, title: String) {
    UserDefaults.standard.setValue(view, forKey: "view")
}
func numberOfSectionsDontWantListen(_ sender: String, isOk: Bool) {
    UserDefaults.standard.setValue(sender, forKey: "sender")
}
func tableViewDontWantPattern(_ view: Double, isPass: Bool) {
    UserDefaults.standard.setValue(view, forKey: "view")
}
func tableViewDoEat(_ element: String, title: String) {
    UserDefaults.standard.setValue(element, forKey: "element")
}
func tableViewWantEat(_ element: String, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(element, forKey: "element")
}
func tableViewCanRaise(_ listener: Bool, title: String) {
    UserDefaults.standard.setValue(listener, forKey: "listener")
}
func mailComposeControllerShouldLoud(_ para: Int, isPass: Bool) {
    UserDefaults.standard.setValue(para, forKey: "para")
}
}
