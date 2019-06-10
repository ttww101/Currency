import UIKit

extension SelectSettingPresenter {
func presentFetchedTitleCanListen(_ message: Bool, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(message, forKey: "message")
}
func presentFetchedOptionsCanDream(_ message: String, isOk: Bool) {
    UserDefaults.standard.setValue(message, forKey: "message")
}
func presentChosenOptionWantSing(_ para: Double, isOk: Bool) {
    UserDefaults.standard.setValue(para, forKey: "para")
}
}
