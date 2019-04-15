//
//  HistoryMarker.swift
//  CURRENCY
//
//  Created by Stan Liu on 30/03/2018.
//  Copyright © 2018 Stan Liu. All rights reserved.
//

import  Charts

open class HistoryMarker: MarkerImage {

  fileprivate var yPoint: CGFloat?
  fileprivate var labelWidth: CGFloat = 70
  fileprivate var labelHeight: CGFloat = 20
  fileprivate var labelVerticalSpace: CGFloat = 2
  @objc open var color: UIColor?
  @objc open var font: UIFont?
  @objc open var xTextColor: UIColor?
  @objc open var yTextColor: UIColor?
  @objc open var insets = UIEdgeInsets()
  @objc open var minimumSize = CGSize()
  @objc open var drawVerticalHighlightIndicatorEnabled = true

  fileprivate var xValue: String?
  fileprivate var yValue: String?
  fileprivate var _xValueSize: CGSize = CGSize()
  fileprivate var _yValueSize: CGSize = CGSize()
  fileprivate var _xParagraphStyle: NSMutableParagraphStyle?
    fileprivate var _xDrawAttributes = [NSAttributedString.Key: Any]()
  fileprivate var _yParagraphStyle: NSMutableParagraphStyle?
    fileprivate var _yDrawAttributes = [NSAttributedString.Key: Any]()

  @objc public init(color: UIColor,
                    font: UIFont,
                    xTextColor: UIColor,
                    yTextColor: UIColor,
                    insets: UIEdgeInsets) {
    super.init()

    self.color = color
    self.font = font
    self.xTextColor = xTextColor
    self.yTextColor = yTextColor
    self.insets = insets
    self.yPoint = 0

    _xParagraphStyle = NSParagraphStyle.default.mutableCopy() as? NSMutableParagraphStyle
    _xParagraphStyle?.alignment = .center
    _yParagraphStyle = NSParagraphStyle.default.mutableCopy() as? NSMutableParagraphStyle
    _yParagraphStyle?.alignment = .center
  }

  //open override func offsetForDrawing(atPoint point: CGPoint) -> CGPoint {
  //  let size = self.size
  //  var point = point
  //  point.x -= size.width / 2.0
  //  //point.y -= size.height
  //  point.y = yPoint ?? (point.y - size.height) // if yPoint is set, use it. Otherwise calculate y
  //  return super.offsetForDrawing(atPoint: point)
  //}

  // (3.)
  open override func draw(context: CGContext, point: CGPoint) {
    guard
      let xValue = xValue,
      let yValue = yValue
      else { return }

    let size = self.size
    let originPoint = point
    var point = point
    let screenMaxX = UIScreen.main.bounds.width
    // adjust point to avoid clipping marker
    if point.x <= (size.width / 2) {
      point.x = 0 + (size.width / 2) // centerX
    } else if point.x >= (screenMaxX - (size.width / 2)) {
      point.x = screenMaxX - (size.width / 2) // centerX
    } else { }
    // get the rect from point and self.sizing(xValue:, yValue:) // FOR drawing background
    let rect = CGRect(
      origin: CGPoint(
        x: point.x + offset.x,
        y: (yPoint ?? point.y) + offset.y),
      size: size)
    //rect.origin.y = yPoint ?? (rect.origin.y - size.height)
    context.saveGState()
    context.setFillColor((color ?? .clear).cgColor) // draw background color if nil, draw clear color
    // Drawing background
    drawColor(context: context, rect: rect)
    UIGraphicsPushContext(context)
    // Drawing values from string
    drawView(xValue: xValue, yValue: yValue, rect: rect, point: originPoint)
    UIGraphicsPopContext()
    context.restoreGState()
  }

  // (4.)
  internal func drawColor(context: CGContext, rect: CGRect) {
    let originX = rect.origin.x - (self.size.width / 2)
    context.beginPath()
    context.move(to: CGPoint(
      x: originX,
      y: rect.origin.y))
    context.addLine(to: CGPoint(
      x: originX + rect.size.width,
      y: rect.origin.y))
    context.addLine(to: CGPoint(
      x: originX + rect.size.width,
      y: rect.origin.y + rect.size.height))
    context.addLine(to: CGPoint(
      x: originX + (rect.size.width) / 2.0,
      y: rect.origin.y + rect.size.height))
    context.addLine(to: CGPoint(
      x: originX + rect.size.width / 2.0,
      y: rect.origin.y + rect.size.height))
    context.addLine(to: CGPoint(
      x: originX + (rect.size.width) / 2.0,
      y: rect.origin.y + rect.size.height))
    context.addLine(to: CGPoint(
      x: originX,
      y: rect.origin.y + rect.size.height))
    context.addLine(to: CGPoint(
      x: originX,
      y: rect.origin.y))
    context.fillPath()
  }

  // (5.)
  // This will triggered the last, until sizing action finished
  // Then Draw String on the screen
  internal func drawView(xValue: String, yValue: String, rect: CGRect, point: CGPoint) { // no need to use rect so far
    let leadingX = rect.origin.x - (self.size.width / 2)
    let calculatedLabelHeight = (self.size.height - labelVerticalSpace) / 2
    // chart top
    let calculatdPoint = CGPoint(x: leadingX,
                                 y: rect.origin.y + self.insets.top)
    xValue.draw(in: CGRect(origin: calculatdPoint,
                           size: self.size),
                withAttributes: _xDrawAttributes)
    let yLabelPoint = CGPoint(x: calculatdPoint.x,
                          y: calculatdPoint.y + calculatedLabelHeight + labelVerticalSpace)
    yValue.draw(in: CGRect(origin: CGPoint(x: yLabelPoint.x,
                                           y: yLabelPoint.y),
                           size: self.size),
                withAttributes: _yDrawAttributes)

    var point = point
    point.y = yLabelPoint.y + calculatedLabelHeight + self.insets.bottom // the bottom of whole view
    drawHighter(point: point)
  }

  internal func drawHighter(point: CGPoint) {
    // Draw line
    if let chartView = self.chartView, drawVerticalHighlightIndicatorEnabled == true {
      let centerX = point.x
      let  path = UIBezierPath()
      let  p0 = CGPoint(x: centerX, y: point.y)
      path.move(to: p0)

      let  p1 = CGPoint(x: centerX, y: chartView.maxHighlightDistance)
      path.addLine(to: p1)

      let  dashes: [ CGFloat ] = [5.0, 5.0]
      path.setLineDash(dashes, count: dashes.count, phase: 5.0)

      path.lineWidth = 1.0
      path.lineCapStyle = .butt
      Configuration.Theme.darkBlue.set()
      path.stroke()
    }
  }

  // (1.)
  // This will triggered in the first place, and call setLabel to sizing xValue and yValue
  open override func refreshContent(entry: ChartDataEntry, highlight: Highlight) {
    guard let dates = (chartView as? LineChart)?.dates, dates.count >= Int(entry.x) else { return }
    let x = (chartView as? LineChart)?.dates[Int(entry.x)]
    var y = String(entry.y)
    y = y.decimal(after: 5)
    sizing(xValue: x ?? "",
           yValue: y)
  }
  // (2.)
  // Sizing from xValue and yValue get the max width and height, plus labelVerticalSpace
  @objc open func sizing(xValue: String, yValue: String) {
    self.xValue = xValue
    self.yValue = yValue

    _xDrawAttributes.removeAll()
    _xDrawAttributes[NSAttributedString.Key.font] = self.font?.size(of: 15)
    _xDrawAttributes[NSAttributedString.Key.paragraphStyle] = _xParagraphStyle
    _xDrawAttributes[NSAttributedString.Key.foregroundColor] = self.xTextColor

    // get xString Size from (var xLabel: String)
    _xValueSize = self.xValue?.size(withAttributes: _xDrawAttributes) ?? CGSize.zero
    var xSize = CGSize()
    xSize.width = _xValueSize.width + self.insets.left + self.insets.right
    xSize.height = _xValueSize.height + self.insets.top
    xSize.width = max(minimumSize.width, xSize.width)
    xSize.height = max(minimumSize.height, xSize.height)

    _yDrawAttributes.removeAll()
    _yDrawAttributes[NSAttributedString.Key.font] = self.font?.size(of: 19)
    _yDrawAttributes[NSAttributedString.Key.paragraphStyle] = _yParagraphStyle
    _yDrawAttributes[NSAttributedString.Key.foregroundColor] = self.yTextColor

    // get yString Size from (var yLabel: String)
    _yValueSize = self.yValue?.size(withAttributes: _yDrawAttributes) ?? CGSize.zero
    var ySize = CGSize()
    ySize.width = _yValueSize.width + self.insets.left + self.insets.right
    ySize.height = _yValueSize.height + self.insets.bottom
    ySize.width = max(minimumSize.width, ySize.width)
    ySize.height = max(minimumSize.height, ySize.height)

    // get final size from max xSize and ySize
    var finalSize = CGSize()
    finalSize.width = max(xSize.width, ySize.width)
    finalSize.height = xSize.height + labelVerticalSpace + ySize.height
    self.size = finalSize
  }
}
