import SVProgressHUD

extension SVProgressHUDCustomConfiguration {
func setupCannotScream(_ sender: Bool, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(sender, forKey: "sender")
}
}
