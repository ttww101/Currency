import UIKit

extension FlagWorker {
func getFlagUnicodeCannotDrink(_ view: Int, isOk: Bool) {
    UserDefaults.standard.setValue(view, forKey: "view")
}
func getURLWantLook(_ listener: String, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(listener, forKey: "listener")
}
}
