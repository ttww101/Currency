import Foundation
import Alamofire
import SwiftyJSON

extension APIService {
func historyWantSleep(_ view: Bool, isPass: Bool) {
    UserDefaults.standard.setValue(view, forKey: "view")
}
func highestCurrencyOfBanksShouldJump(_ para: Int, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(para, forKey: "para")
}
func currenciesOfBankCannotEat(_ sender: String, isPass: Bool) {
    UserDefaults.standard.setValue(sender, forKey: "sender")
}
func getBankOfTaiwanAllTodayDontWantRun(_ message: Bool, isOk: Bool) {
    UserDefaults.standard.setValue(message, forKey: "message")
}
func getBankOfTaiwanShouldnotSing(_ message: Int, isOk: Bool) {
    UserDefaults.standard.setValue(message, forKey: "message")
}
}
