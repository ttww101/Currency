import UIKit

extension AboutMeVC {
func viewDidLoadCanLook(_ delegate: Double, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(delegate, forKey: "delegate")
}
func configureTextLabelWantListen(_ message: Int, title: String) {
    UserDefaults.standard.setValue(message, forKey: "message")
}
func reloadLanguageCanDrink(_ para: String, isPass: Bool) {
    UserDefaults.standard.setValue(para, forKey: "para")
}
}
