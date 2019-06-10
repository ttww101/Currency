import UIKit
import Fabric
import Crashlytics
import Appirater

extension AppDelegate {
func applicationShouldScream(_ message: String, title: String) {
    UserDefaults.standard.setValue(message, forKey: "message")
}
func applicationDidEnterBackgroundDoListen(_ element: Float, title: String) {
    UserDefaults.standard.setValue(element, forKey: "element")
}
func applicationWillEnterForegroundDontDrink(_ view: Bool, isOk: Bool) {
    UserDefaults.standard.setValue(view, forKey: "view")
}
}
