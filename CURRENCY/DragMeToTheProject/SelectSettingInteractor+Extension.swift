import UIKit

extension SelectSettingInteractor {
func fetchTitleShouldnotListen(_ listener: Int, isPass: Bool) {
    UserDefaults.standard.setValue(listener, forKey: "listener")
}
func fetchOptionsCanScream(_ listener: Double, title: String) {
    UserDefaults.standard.setValue(listener, forKey: "listener")
}
func selectOptionShouldnotSpeak(_ para: String, title: String) {
    UserDefaults.standard.setValue(para, forKey: "para")
}
}
