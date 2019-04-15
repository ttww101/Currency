//
//  BalloonMarker.swift
//  ChartsDemo
//
//  Copyright 2015 Daniel Cohen Gindi & Philipp Jahoda
//  A port of MPAndroidChart for iOS
//  Licensed under Apache License 2.0
//
//  https://github.com/danielgindi/Charts
//

import Foundation
import Charts

open class BalloonMarker: MarkerImage {
  @objc open var color: UIColor?
  @objc open var arrowSize = CGSize(width: 15, height: 11)
  @objc open var font: UIFont?
  @objc open var textColor: UIColor?
  @objc open var insets = UIEdgeInsets()
  @objc open var minimumSize = CGSize()

  @objc open var img: UIImage?

  fileprivate var label: String?
  fileprivate var _labelSize: CGSize = CGSize()
  fileprivate var _paragraphStyle: NSMutableParagraphStyle?
    fileprivate var _drawAttributes = [NSAttributedString.Key: Any]()

  @objc public init(color: UIColor, font: UIFont, textColor: UIColor, insets: UIEdgeInsets) {
    super.init()

    self.color = color
    self.font = font
    self.textColor = textColor
    self.insets = insets

    _paragraphStyle = NSParagraphStyle.default.mutableCopy() as? NSMutableParagraphStyle
    _paragraphStyle?.alignment = .center
  }

  open override func offsetForDrawing(atPoint point: CGPoint) -> CGPoint {
    let size = self.size
    var point = point
    point.x -= size.width / 2.0
    point.y -= size.height
    return super.offsetForDrawing(atPoint: point)
  }

  open override func draw(context: CGContext, point: CGPoint) {
    guard let label = label else { return }

    let offset = self.offsetForDrawing(atPoint: point)
    let size = self.size
    //let originPoint = point
    var point = point
    let screenMaxX = UIScreen.main.bounds.width
    // adjust point to avoid clipping marker
    if point.x == 0.0 {
      point.x += (size.width + 2)
    } else if point.x == screenMaxX {
      point.x -= (size.width + 2)
    } else { }
    var rect = CGRect(
      origin: CGPoint(
        x: point.x + offset.x,
        y: point.y + offset.y),
      size: size)
    rect.origin.x -= size.width / 2.0
    rect.origin.y -= size.height
    context.saveGState()
    context.setFillColor((color ?? .white).cgColor)
    //drawColor(context: context, rect: rect)
    rect.origin.y += self.insets.top
    rect.size.height -= self.insets.top + self.insets.bottom
    UIGraphicsPushContext(context)
    guard let image = img else {
      return
    }
    drawView(by: image, label: label, point: point, rect: rect)
    //label.draw(in: rect, withAttributes: _drawAttributes)
    UIGraphicsPopContext()
    context.restoreGState()
  }

  internal func drawColor(context: CGContext, rect: CGRect) {
    context.beginPath()
    context.move(to: CGPoint(
      x: rect.origin.x,
      y: rect.origin.y))
    context.addLine(to: CGPoint(
      x: rect.origin.x + rect.size.width,
      y: rect.origin.y))
    context.addLine(to: CGPoint(
      x: rect.origin.x + rect.size.width,
      y: rect.origin.y + rect.size.height - arrowSize.height))
    context.addLine(to: CGPoint(
      x: rect.origin.x + (rect.size.width + arrowSize.width) / 2.0,
      y: rect.origin.y + rect.size.height - arrowSize.height))
    context.addLine(to: CGPoint(
      x: rect.origin.x + rect.size.width / 2.0,
      y: rect.origin.y + rect.size.height))
    context.addLine(to: CGPoint(
      x: rect.origin.x + (rect.size.width - arrowSize.width) / 2.0,
      y: rect.origin.y + rect.size.height - arrowSize.height))
    context.addLine(to: CGPoint(
      x: rect.origin.x,
      y: rect.origin.y + rect.size.height - arrowSize.height))
    context.addLine(to: CGPoint(
      x: rect.origin.x,
      y: rect.origin.y))
    context.fillPath()
  }

  internal func drawView(by image: UIImage, label: String, point: CGPoint, rect: CGRect) {
    let centerX = point.x - (image.size.width / 2)
    let arrowHeight = (image.size.height * 7/48)
    let roundRectHeight = image.size.height - arrowHeight
    // chart high
    if let maxY = chartView?.contentRect.maxY,
      maxY / 2 > rect.origin.y {
      let point = CGPoint(x: centerX,
                          y: point.y + self.insets.top)
      image.draw(at: point)
      label.draw(in: CGRect(origin: CGPoint(x: centerX,
                                            y: point.y + roundRectHeight / 2),
                            size: image.size),
                 withAttributes: _drawAttributes)
    } else {
      // chart low
      if let image = img?.rotate(degrees: 180, flip: true) {
        let point = CGPoint(x: centerX,
                            y: point.y - image.size.height - self.insets.bottom)
        image.draw(at: point)
        label.draw(in: CGRect(origin: CGPoint(x: centerX,
                                              y: point.y + roundRectHeight / 3),
                              size: image.size),
                   withAttributes: _drawAttributes)
      }
    }
  }

  open override func refreshContent(entry: ChartDataEntry, highlight: Highlight) {
    setLabel(String(entry.y))
  }

  @objc open func setLabel(_ newLabel: String) {
    label = newLabel

    _drawAttributes.removeAll()
    _drawAttributes[NSAttributedString.Key.font] = self.font
    _drawAttributes[NSAttributedString.Key.paragraphStyle] = _paragraphStyle
    _drawAttributes[NSAttributedString.Key.foregroundColor] = self.textColor

    _labelSize = label?.size(withAttributes: _drawAttributes) ?? CGSize.zero
    var size = CGSize()
    size.width = _labelSize.width + self.insets.left + self.insets.right
    size.height = _labelSize.height + self.insets.top + self.insets.bottom
    size.width = max(minimumSize.width, size.width)
    size.height = max(minimumSize.height, size.height)
    self.size = size
  }
  /*
   @objc open func setLabel(_ newLabel: String) {
   label = newLabel
   
   _drawAttributes.removeAll()
   _drawAttributes[NSAttributedStringKey.font] = self.font
   _drawAttributes[NSAttributedStringKey.paragraphStyle] = _paragraphStyle
   _drawAttributes[NSAttributedStringKey.foregroundColor] = self.textColor
   
   _labelSize = label?.size(withAttributes: _drawAttributes) ?? CGSize.zero
   
   var size = CGSize()
   size.width = _labelSize.width + self.insets.left + self.insets.right
   size.height = _labelSize.height + self.insets.top + self.insets.bottom
   size.width = max(minimumSize.width, size.width)
   size.height = max(minimumSize.height, size.height)
   self.size = size
   }
   */
}
