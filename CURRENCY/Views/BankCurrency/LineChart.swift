//
//  LineChart.swift
//  CURRENCY
//
//  Created by Stan Liu on 14/11/2017.
//  Copyright © 2017 Stan Liu. All rights reserved.
//

import Charts
import Hue

// left    line           right
//  ⎡---------------------⎤
//  |   |    |    |    |   |
//  |   |    |    |    |   |
//  |   |    |    |    |   |
//  |   |grid|    |    |xxx|  chartDescription.text
//  ⎣---------------------⎦  <-- xAxis
//   label
//
//  □ description // legend

class LineChart: BarLineChartViewBase, ChartViewDelegate, LineChartDataProvider {

  // Conform LineChartDataProvider
  var lineData: LineChartData? { return self.data as? LineChartData }

  var subjects: [Decimal] = [] // 匯率資料
  var dates: [String] = [] // 日期資料 == 匯率資料 // 需要仔細比對日期與匯率有沒有正確
  var line1: LineChartDataSet = LineChartDataSet() // 曲線 cubic
  let animationInterval: TimeInterval = 0.0 // 設定動畫時間
  var highlightLastEnabled: Bool = false
  var fillEnabled: Bool = false
  var visibleXMaximum: Double {
    return Double(subjects.count - 1)
  }
  let visibleXMinimum: Double = 0
  var sourceDescription: String = "" {
    didSet {
      chartDescription?.text = sourceDescription // 右下角的表格說明
    }
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupInitial()
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupInitial()
  }

  init() {
    super.init(frame: .zero)
  }

  func setupInitial() {
    // needs to init a renderer like LineChartView
    //renderer = LineChartRenderer(dataProvider: self,
    //                             animator: chartAnimator,
    //                             viewPortHandler: viewPortHandler)
    renderer = SLineChartRenderer(dataProvider: self,
                                  animator: chartAnimator,
                                  viewPortHandler: viewPortHandler)

    self.delegate = self
    dragEnabled = true // 拖拉圖表
    setScaleEnabled(false) // 縮放
    pinchZoomEnabled = false // 兩隻手指放大
    drawGridBackgroundEnabled = false // 繪製網格
    drawBordersEnabled = false // 繪製框框
    dragDecelerationEnabled = false // 拖移後是否有慣性效果
    dragDecelerationFrictionCoef = 0 // 慣性摩擦係數(0~1), 數值越小，慣性越不明顯
    highlightPerTapEnabled = true
    clipValuesToContentEnabled = true // 要不要切掉 label content
    noDataText = "No Chart Data"
    noDataFont = Configuration.Font.letterFont.size(of: 32)
    noDataTextColor = Configuration.Theme.darkBlue

    chartDescription?.text = sourceDescription // 右下角的表格說明
    chartDescription?.font = Configuration.Font.letterFont.size(of: 13) // 表格說明的字型
    chartDescription?.textColor = Configuration.Theme.darkBlue // 表格說明的文字顏色
    legend.enabled = false // 圖例說明

    minOffset = 0 // 上左下右的最小offset
    extraBottomOffset = 0 // 下方offset間距
    extraTopOffset = 0 // 上方offset間距
    extraLeftOffset = 0
    extraRightOffset = 0

    // Sets the size of the area (range on the x-axis) that should be maximum visible at once (no further zooming out allowed).
    setVisibleXRangeMaximum(visibleXMaximum) // 最大顯示
    setVisibleXRangeMinimum(visibleXMinimum) // 最小顯示

    setupLeftAxis() // 設定左右標線
    setupRightAxis() // 設定左右標線
    setupAxisBase() // 設定圖表
  }

  func setupAxisBase() {
    xAxis.gridColor = Configuration.Theme.lightBlue
    xAxis.labelPosition = .bottom // 顯示曲線數值的位置
    xAxis.labelTextColor = Configuration.Theme.darkBlue
    xAxis.labelFont = Configuration.Font.numericFont

    // 所有有關x軸的標線都不要
    xAxis.enabled = false

    // set this with axisLineWidth could make label shows but line
    xAxis.drawLabelsEnabled = true // 顯示xAxis單位label // label always shows with xAxis guide,
    xAxis.drawGridLinesEnabled = false // 顯示Axis中間的單位線grid
    xAxis.drawAxisLineEnabled = false // 顯示xAxis單位的格線（在label上方） _|_
    // if focing the y-label count is enabled. Default: false
    //xAxis.forceLabelsEnabled = false //  if true, 會消失幾個label 讓版面最前面跟最後面的label顯示出來
    //xAxis.granularityEnabled = true
    xAxis.granularity = 1 // 曲線間格為1

    // xAxis the first and last label entry in the char "clip" off the edge of that chart
    xAxis.avoidFirstLastClippingEnabled = true // 最前面跟最後面的label會不會切掉
    //xAxis.wordWrapEnabled = true
    xAxis.centerAxisLabelsEnabled = true

    // this will make line disappear
    //xAxis.axisLineWidth = 0

    //xAxis.axisMinimum = -3 // 最前面留空3格
    //xAxis.axisMaximum = Double(subjectsRange.rawValue) - 0.9 // 後面留空3格
  }

  func setupLeftAxis() {
    //leftAxis.removeAllLimitLines()
    //leftAxis.axisMaximum = 100 // 設定左邊單位格線最大值
    //leftAxis.axisMaximum = 0 // 設定左邊單位格線最小值
    //leftAxis.gridLineDashLengths = [0, 0]
    //leftAxis.drawZeroLineEnabled = true
    //leftAxis.drawLimitLinesBehindDataEnabled = false
    //leftAxis.labelTextColor = .white
    leftAxis.enabled = false // 繪製左邊單位所有
  }

  func setupRightAxis() {
    rightAxis.drawLimitLinesBehindDataEnabled = false
    rightAxis.enabled = false // 繪製右邊單位所有
  }

  private func setLineBase(line: LineChartDataSet) {
    line.drawIconsEnabled = false
    line.drawValuesEnabled = false // 顯示數值文字
    // error: CGContextSetLineDash: invalid dash array: at least one element must be non-zero.
    // https://stackoverflow.com/questions/34315551/warning-with-cgcontextsetlinedash
    /*
     You should post what are the argument values.
     As I can assume from the error message, your arguments has 0 and is not allowed. Read CGContextSetLineDash about the dash options.
     */
    //line1.lineDashLengths = [0, 0]
    //line1.setColor(.white)
    line.lineWidth = 2.5
    line.valueTextColor = Configuration.Theme.white
    line.valueFont = Configuration.Font.numericFont
    line.mode = .cubicBezier // 線圖使用曲線
  }

  // Not USE This, Now Draw custom Highlight indicator in HistoryMaker
  private func setLineHighlight(line: LineChartDataSet) {
    line.highlightEnabled = true // 是否開啟highlight(顯示十字線)
    line.drawVerticalHighlightIndicatorEnabled = false // 移動highlight顯示垂直線
    line.drawHorizontalHighlightIndicatorEnabled = false // 移動highlight顯示水平線
    line.highlightColor = Configuration.Theme.lightBlue
    line.highlightLineWidth = 1
    line.highlightLineDashLengths = [5, 5] // 讓highlight 虛線
    line.highlightLineDashPhase = 5
  }

  private func setLineCircle(line: LineChartDataSet) {
    // This also affect the highlight circle size and color
    line.drawCirclesEnabled = false // 繪製交叉點
    line.circleRadius = 9.0 // 交叉點半徑
    line.drawCircleHoleEnabled = false // 交叉點中空
    line.circleHoleRadius = 4.5 // 交叉中空心點半徑
    line.circleHoleColor = Configuration.Theme.darkBlue // 空心點顏色
    line.circleColors = [Configuration.Theme.darkBlue.alpha(0.2)]
  }

  private func setLineColor(line: LineChartDataSet) {
    let filledBackgroundGradientColors = [Configuration.Theme.mediumLightBlue.alpha(0.3).cgColor,
                                          UIColor.clear.cgColor]
    if let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(),
                                 colors: filledBackgroundGradientColors as CFArray,
                                 locations: nil) {
      line.drawFilledEnabled = fillEnabled // 填滿顏色
      line.fillAlpha = 1.0 // 填滿的透明度
      line.fill = Fill(linearGradient: gradient, angle: 270) // 從哪個方向填滿
      //line.fill = Fill(radialGradient: gradient,
      //                 startOffsetPercent: self.center,
      //                 startRadiusPercent: 0.5,
      //                 endOffsetPercent: CGPoint(x: 150, y: 150),
      //                 endRadiusPercent: 0.2)
      //line.fill = Fill(CGColor: Configuration.Theme.mediumLightBlue.cgColor)
      line.setColor(Configuration.Theme.darkBlue)
    }
  }

  private func setMarker() {
    // 使用自己的marker
    let marker = HistoryMarker(color: .clear,
                               font: Configuration.Font.numericFont,
                               xTextColor: Configuration.Theme.mediumGray,
                               yTextColor: Configuration.Theme.textColor,
                               insets: UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5))
    // assign image depends chat value point
    marker.chartView = self // 指定marker用在哪裡
    self.marker = marker // assign local to global
  }

  // 畫圖
  // range:
  func modifyChart(by subjects: [Decimal], dates: [String]) {
    guard subjects.count == dates.count else { return }
    var values: [ChartDataEntry] = []
    // hotfix: use current subjects value to calculate the average
    // prevent line chart be cut off at the top
    // get min and max from data set
    // get avg
    guard let min = subjects.min(), let max = subjects.max() else {
      return
    }
    for (index, subject) in subjects.enumerated() {
      let entry = ChartDataEntry(x: Double(index), y: subject.doubleValue)
      values.append(entry)
    }
    // get avg
    let avg = subjects.decimalAverage
    // To make minimum and maximum more smooth so that it won't exceed beyond top edge
    leftAxis.axisMinimum = (min - (avg - min)).doubleValue // 設定左邊單位格線最小值
    leftAxis.axisMaximum = (max + (max - avg)).doubleValue // 設定左邊單位格線最大值
    //let avg = subjects.decimalAverage
    //leftAxis.axisMinimum = (avg * 0.9).doubleValue // 設定左邊單位格線最小值
    //leftAxis.axisMaximum = (avg * 1.1).doubleValue // 設定左邊單位格線最大值
    // Value is ChartDataEntry array
    line1.values = values
    setLineBase(line: line1) // 設定曲線
    setLineHighlight(line: line1) // 設定曲線點下去的highlight
    setLineCircle(line: line1) // 設定曲線節點
    setLineColor(line: line1) // 設定曲線顏色
    let data = LineChartData(dataSet: line1)
    self.data = data // Charts.ChartData: Swift Chart 設定 chat 的進入點
    xAxis.valueFormatter = IndexAxisValueFormatter(values: dates) // 設定下方文字
    setMarker()
    highlightValue(nil) // Reload chart should disable previous selected highlighter

    if highlightLastEnabled {
      // Show Lastest highlight
      guard let lastSubject = subjects.last else { return }
      highlightValue(x: Double(self.subjects.count - 1), y: lastSubject.doubleValue, dataSetIndex: 0, callDelegate: false)
      moveViewToX(Double(self.subjects.count))
    }
  }

  // custom reload data like TableView
  func reloadData(completion: (() -> Void)? = nil) {
    modifyChart(by: subjects, dates: dates)
    animate(yAxisDuration: animationInterval)
    completion?()
  }

  func clean() {
    self.subjects = []
    self.dates = []
    reloadData()
  }

  // custom reload Chart view 重整圖表的 UI
  func reloadChartViewProperties() {

    guard let dataSets = data?.dataSets as? [LineChartDataSet] else {
      return
    }
    for set in dataSets {
      set.mode = .cubicBezier
    }
    setNeedsDisplay()
  }

  // MARK: ChartViewDelegate

  // Interaction with the Chart
  func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
    // this is index and value, in this case
    // x: index
    // y: value
    //print("hight x: \(highlight.x), y: \(highlight.y)")
    // xpx, ypx could use to draw custom highlighter
    //print("hight x: \(highlight.xPx), y: \(highlight.yPx)")
    //self.moveViewToX(Double(highlight.xPx))
  }

  func chartValueNothingSelected(_ chartView: ChartViewBase) {
    //print("chart value nothing selected")
  }

  override func draw(_ rect: CGRect) {
//    for i in 1 ..< (subjects.count - 1) {
//      drawGrid(at: i)
//    }
    super.draw(rect)
  }

  // custom draw grid
  func drawGrid(at index: Int, color: UIColor = Configuration.Theme.lightBlue, offset: CGFloat = 15) {
    guard let set = data?.dataSets.first,
      let entry = data?.dataSets.first?.entryForIndex(index),
        var startY = self.renderer?.viewPortHandler.contentBottom else {
        return
    }
    startY -= offset
    let endPoint = getTransformer(forAxis: set.axisDependency).pixelForValues(x: entry.x, y: entry.y)
    let bezierPath = UIBezierPath()
    bezierPath.lineWidth = 1
    bezierPath.move(to: CGPoint(x: endPoint.x, y: startY))
    bezierPath.addLine(to: CGPoint(x: endPoint.x, y: endPoint.y))
    color.setStroke()
    bezierPath.stroke()
  }
}
