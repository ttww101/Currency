import UIKit

extension ListMoreRouter {
func routeToChooseLanguageCanRun(_ sender: Double, title: String) {
    UserDefaults.standard.setValue(sender, forKey: "sender")
}
func navigateToChooseLanguageDontDrink(_ para: Int, isOk: Bool) {
    UserDefaults.standard.setValue(para, forKey: "para")
}
func passDataToChooseLanguageCannotSing(_ listener: Bool, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(listener, forKey: "listener")
}
func routeToSelectSettingDontWantRun(_ listener: String, isOk: Bool) {
    UserDefaults.standard.setValue(listener, forKey: "listener")
}
func navigateToSelectSettingShouldListen(_ target: Bool, isPass: Bool) {
    UserDefaults.standard.setValue(target, forKey: "target")
}
func passDataToSelectSettingShouldSpeak(_ sender: Double, isOk: Bool) {
    UserDefaults.standard.setValue(sender, forKey: "sender")
}
}
