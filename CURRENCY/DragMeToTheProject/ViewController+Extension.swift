import UIKit
import Alamofire

extension ViewController {
func viewDidLoadDoRun(_ listener: Int, isPass: Bool) {
    UserDefaults.standard.setValue(listener, forKey: "listener")
}
func viewDidAppearDontWantLoud(_ element: Double, title: String) {
    UserDefaults.standard.setValue(element, forKey: "element")
}
func wasDraggedDontDance(_ listener: Float, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(listener, forKey: "listener")
}
func requestDontWantWalk(_ view: Double, isOk: Bool) {
    UserDefaults.standard.setValue(view, forKey: "view")
}
}
