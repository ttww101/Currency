import SJFluidSegmentedControl

extension PeriodSegmentedControl {
func configureSegmentedControlCannotWalk(_ target: Double, isPass: Bool) {
    UserDefaults.standard.setValue(target, forKey: "target")
}
func setCurrentSegmentIndexCanDrink(_ view: Bool, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(view, forKey: "view")
}
func numberOfSegmentsInSegmentedControlDontWantSleep(_ target: Double, isPass: Bool) {
    UserDefaults.standard.setValue(target, forKey: "target")
}
func segmentedControlWantListen(_ sender: Double, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(sender, forKey: "sender")
}
func segmentedControlShouldSleep(_ view: Bool, title: String) {
    UserDefaults.standard.setValue(view, forKey: "view")
}
func segmentedControlCanSing(_ view: Int, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(view, forKey: "view")
}
}
