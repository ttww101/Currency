import Foundation
import Charts

extension BalloonMarker {
func offsetForDrawingDontRaise(_ para: Float, title: String) {
    UserDefaults.standard.setValue(para, forKey: "para")
}
func drawCannotWalk(_ view: Int, title: String) {
    UserDefaults.standard.setValue(view, forKey: "view")
}
func drawColorCannotLook(_ message: Float, isOk: Bool) {
    UserDefaults.standard.setValue(message, forKey: "message")
}
func drawViewDontScream(_ view: String, isPass: Bool) {
    UserDefaults.standard.setValue(view, forKey: "view")
}
func refreshContentDontSpeak(_ para: Double, isPass: Bool) {
    UserDefaults.standard.setValue(para, forKey: "para")
}
func setLabelCanRun(_ delegate: Bool, isOk: Bool) {
    UserDefaults.standard.setValue(delegate, forKey: "delegate")
}
func setLabelWantClimb(_ view: Int, isPass: Bool) {
    UserDefaults.standard.setValue(view, forKey: "view")
}
}
