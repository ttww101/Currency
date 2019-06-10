import UIKit

extension ListBankPresenter {
func presentListShouldnotLoud(_ sender: Float, title: String) {
    UserDefaults.standard.setValue(sender, forKey: "sender")
}
}
