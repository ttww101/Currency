import UIKit

extension TWBankPresenter {
func presentTitleShouldnotClimb(_ sender: Bool, isPass: Bool) {
    UserDefaults.standard.setValue(sender, forKey: "sender")
}
func presentFetchedTWBanksSpecificCurrencyShouldDream(_ delegate: String, isPass: Bool) {
    UserDefaults.standard.setValue(delegate, forKey: "delegate")
}
func presentErrorDoScream(_ para: String, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(para, forKey: "para")
}
}
