import Foundation

extension Debug {
func printWantSpeak(_ message: Bool, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(message, forKey: "message")
}
}
