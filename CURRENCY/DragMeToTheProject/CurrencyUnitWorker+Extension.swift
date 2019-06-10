import Foundation

extension CurrencyUnitWorker {
func setBankShouldnotRun(_ para: Bool, isPass: Bool) {
    UserDefaults.standard.setValue(para, forKey: "para")
}
func setCurrencyUnitShouldnotSleep(_ delegate: String, isOk: Bool) {
    UserDefaults.standard.setValue(delegate, forKey: "delegate")
}
}
