import Foundation
import Charts

extension SLineChartRenderer {
func drawHighlightedDontRun(_ element: Float, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(element, forKey: "element")
}
}
