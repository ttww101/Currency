import Foundation
import SwiftyJSON

extension InvestmentSubject {
func calculateDoListen(_ para: Float, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(para, forKey: "para")
}
func mappingShouldSleep(_ message: Int, isPass: Bool) {
    UserDefaults.standard.setValue(message, forKey: "message")
}
}
