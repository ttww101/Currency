import UIKit

extension CrownView {
func configureConstraintsCanListen(_ view: Bool, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(view, forKey: "view")
}
}
