import MMPopupView

extension PopupInfo {
func showShouldWalk(_ para: Double, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(para, forKey: "para")
}
}
