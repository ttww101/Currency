import UIKit

extension RecordCell {
func awakeFromNibShouldLoud(_ element: Int, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(element, forKey: "element")
}
func setSelectedShouldnotRaise(_ listener: String, title: String) {
    UserDefaults.standard.setValue(listener, forKey: "listener")
}
}
