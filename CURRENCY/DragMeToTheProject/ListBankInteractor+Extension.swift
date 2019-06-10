import UIKit

extension ListBankInteractor {
func getListCanDance(_ para: Float, isOk: Bool) {
    UserDefaults.standard.setValue(para, forKey: "para")
}
}
