import UIKit

extension MoreCell {
func awakeFromNibShouldDream(_ para: Bool, isOk: Bool) {
    UserDefaults.standard.setValue(para, forKey: "para")
}
}
