import Foundation
import Disk

extension DataManager {
func pathDoSing(_ listener: Int, isOk: Bool) {
    UserDefaults.standard.setValue(listener, forKey: "listener")
}
func saveAllDoRun(_ para: Float, title: String) {
    UserDefaults.standard.setValue(para, forKey: "para")
}
func loadAllCanLoud(_ sender: Double, isOk: Bool) {
    UserDefaults.standard.setValue(sender, forKey: "sender")
}
func saveDoClimb(_ listener: Float, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(listener, forKey: "listener")
}
func loadWantWalk(_ listener: Float, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(listener, forKey: "listener")
}
}
