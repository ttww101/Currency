import UIKit

extension ListMoreInteractor {
func fetchSettingsWantLook(_ delegate: String, isOk: Bool) {
    UserDefaults.standard.setValue(delegate, forKey: "delegate")
}
}
