//
//  SimpleChart.swift
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

class SimpleChart: BarLineChartViewBase, ChartViewDelegate, LineChartDataProvider {

  // Conform LineChartDataProvider
  var lineData: LineChartData? { return self.data as? LineChartData }

  var subjects: [Decimal] = [] // 匯率資料
  var dates: [String] = [] // 日期資料 == 匯率資料 // 需要仔細比對日期與匯率有沒有正確
  var line1: LineChartDataSet = LineChartDataSet() // 曲線 cubic
  let animationInterval: TimeInterval = 0.7 // 設定動畫時間
  let visibleXMaximum = 6.0
  let visibleXMinimum = 6.0
  var sourceDescription: String = "" {
    didSet {
      chartDescription?.text = sourceDescription // 右下角的表格說明
    }
  }

  init() { super.init(frame: .zero) }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)

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
    chartDescription?.text = sourceDescription // 右下角的表格說明
    chartDescription?.font = Configuration.Font.letterFont.size(of: 13) // 表格說明的字型
    chartDescription?.textColor = Configuration.Theme.darkBlue // 表格說明的文字顏色
    legend.enabled = false // 圖例說明

    minOffset = 0 // 上左下右的最小offset
    extraBottomOffset = 8 // 下方offset間距
    extraTopOffset = 5 // 上方offset間距
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
    //xAxis.enabled = false

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
    //line.setColor(.white)
    let filledBackgroundGradientColors = [Configuration.Theme.green.cgColor,
                                          Configuration.Theme.yellow.cgColor]
    if let gradient = CGGradient(colorsSpace: nil,
                                 colors: filledBackgroundGradientColors as CFArray,
                                 locations: nil) {
      if let cgColor = Fill(linearGradient: gradient, angle: 180).color {
        line.setColor(UIColor(cgColor: cgColor))
      }
    }
    line.lineWidth = 0.0
    line.valueTextColor = Configuration.Theme.white
    line.valueFont = Configuration.Font.numericFont
    line.mode = .cubicBezier // 線圖使用曲線
  }

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
    line.circleRadius = 7.0 // 交叉點半徑
    line.drawCircleHoleEnabled = false // 交叉點中空
    line.circleHoleRadius = 3.0 // 交叉中空心點半徑
    line.circleHoleColor = Configuration.Theme.darkBlue // 空心點顏色
    line.circleColors = [Configuration.Theme.darkBlue.alpha(0.2)]
  }

  private func setLineColor(line: LineChartDataSet) {
    let filledBackgroundGradientColors = [Configuration.Theme.green.cgColor,
                                          Configuration.Theme.yellow.cgColor]
    if let gradient = CGGradient(colorsSpace: nil,
                                 colors: filledBackgroundGradientColors as CFArray,
                                 locations: nil) {
      line.drawFilledEnabled = true // 填滿顏色
      line.fillAlpha = 0.8 // 填滿的透明度
      line.fill = Fill(linearGradient: gradient, angle: 180) // 從哪個方向填滿
    }
  }

  private func setBallonMarker() {
    // 使用自己的marker
    let marker = BalloonMarker(color: Configuration.Theme.white,
                               font: Configuration.Font.ballonFont,
                               textColor: Configuration.Theme.white,
                               insets: UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0))
    // assign image depends chat value point
    marker.img = R.image.marker_up()?.coloring(on: Configuration.Theme.mediumLightBlue.alpha(0.8)) // 設定marker的背景圖片
    marker.chartView = self // 指定marker用在哪裡
    self.marker = marker // assign local to global
  }

  // 畫圖
  // range:
  func modifyChart(by subjects: [Decimal], dates: [String]) {
    guard subjects.count == dates.count else { return }
    var values: [ChartDataEntry] = []
    for (index, subject) in subjects.enumerated() {
      let entry = ChartDataEntry(x: Double(index), y: subject.doubleValue)
      values.append(entry)
    }
    // hotfix: use current subjects value to calculate the average
    // prevent line chart be cut off at the top
    // get min and max from data set
    if let min = subjects.min(), let max = subjects.max() {
      // get avg
      let avg = subjects.decimalAverage
      // To make minimum and maximum more smooth so that it won't exceed beyond top edge
      leftAxis.axisMinimum = (min - (avg - min)).doubleValue // 設定左邊單位格線最小值
      leftAxis.axisMaximum = (max + (max - avg)).doubleValue // 設定左邊單位格線最大值
    }
    // Value is ChartDataEntry array
    line1.values = values
    setLineBase(line: line1) // 設定曲線
    setLineHighlight(line: line1) // 設定曲線點下去的highlight
    setLineCircle(line: line1) // 設定曲線節點
    setLineColor(line: line1) // 設定曲線顏色
    let data = LineChartData(dataSet: line1)
    self.data = data // Charts.ChartData: Swift Chart 設定 chat 的進入點
    xAxis.valueFormatter = IndexAxisValueFormatter(values: dates)
    setBallonMarker()
    highlightValue(nil) // Reload chart should disable previous selected highlighter
  }

  // custom reload data like TableView
  func reloadData() {

    modifyChart(by: subjects, dates: dates)
    //animate(yAxisDuration: animationInterval)
    //animate(xAxisDuration: animationInterval, easingOption: .easeInBounce)
    animate(yAxisDuration: animationInterval, easingOption: .easeInOutExpo)
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

    // 原本是想說第一個跟最後一個不能點選highlight, 因為ballon marker會被切掉
    //guard entry.x == 0 || entry.x == Double(subjects.count) else {
    //  return
    //}
    //chartView.highlightValue(nil)
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
