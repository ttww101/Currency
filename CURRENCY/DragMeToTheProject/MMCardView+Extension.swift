import UIKit

extension MMCardView {
func layoutSubviewsDoRun(_ listener: Float, isOk: Bool) {
    UserDefaults.standard.setValue(listener, forKey: "listener")
}
}
