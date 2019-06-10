import Foundation

extension LanguageDictionary {
func getCurrencyLocalizedKeyCannotRun(_ message: Float, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(message, forKey: "message")
}
func getBankLocalizedKeyCanSing(_ view: Double, title: String) {
    UserDefaults.standard.setValue(view, forKey: "view")
}
func getLocalizedKeyShouldSpeak(_ target: String, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(target, forKey: "target")
}
}
