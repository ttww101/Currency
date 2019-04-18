//
//  SLineChartRenderer.swift
//  ExchangeHelper
//
//  Created by Meiliang Wen on 07/03/2018.
//  Copyright © 2018 Meiliang Wen. All rights reserved.
//

import Foundation
import Charts

// Inherit LineChartRenderer to make a custom highlighter with circle
class SLineChartRenderer: LineChartRenderer {
  override func drawHighlighted(context: CGContext, indices: [Highlight]) {
    // custom highlight circle
    guard
      let dataProvider = dataProvider,
      let lineData = dataProvider.lineData
        /// FIXME:  stephen
//      let animator = animator
      else { return }

    let phaseY = animator.phaseY

    var pt = CGPoint()
    var rect = CGRect()

    context.saveGState()

    for high in indices {
      guard let set = lineData.getDataSetByIndex(high.dataSetIndex) as? ILineChartDataSet, set.isHighlightEnabled
        else { continue }

      let trans = dataProvider.getTransformer(forAxis: set.axisDependency)
      let valueToPixelMatrix = trans.valueToPixelMatrix

      guard let e = set.entryForXValue(high.x, closestToY: high.y) else { continue }
      pt.x = CGFloat(e.x)
      pt.y = CGFloat(e.y * phaseY)
      pt = pt.applying(valueToPixelMatrix)

      let circleRadius = set.circleRadius // 外圈半徑
      let circleDiameter = circleRadius * 2.0
      let circleHoleRadius = set.circleHoleRadius // 內圈半徑
      let circleHoleDiameter = circleHoleRadius * 2.0

      let drawCircleHole = circleHoleRadius < circleRadius &&
        circleHoleRadius > 0.0
      let drawTransparentCircleHole = drawCircleHole &&
        (set.circleHoleColor == nil ||
          set.circleHoleColor == NSUIColor.clear)

      let x = high.x // get the x-position
      // let y = high.y * Double(animator.phaseY)

      context.setFillColor(set.getCircleColor(atIndex: Int(x))!.cgColor)

      rect.origin.x = pt.x - circleRadius
      rect.origin.y = pt.y - circleRadius
      rect.size.width = circleDiameter
      rect.size.height = circleDiameter

      if drawTransparentCircleHole {
        // Begin path for circle with hole
        context.beginPath()
        context.addEllipse(in: rect)

        // Cut hole in path
        rect.origin.x = pt.x - circleHoleRadius
        rect.origin.y = pt.y - circleHoleRadius
        rect.size.width = circleHoleDiameter
        rect.size.height = circleHoleDiameter
        context.addEllipse(in: rect)

        // Fill in-between
        context.fillPath(using: .evenOdd)
      } else {
        context.fillEllipse(in: rect)

        if drawCircleHole {
          context.setFillColor(set.circleHoleColor!.cgColor)

          // The hole rect
          rect.origin.x = pt.x - circleHoleRadius
          rect.origin.y = pt.y - circleHoleRadius
          rect.size.width = circleHoleDiameter
          rect.size.height = circleHoleDiameter

          context.fillEllipse(in: rect)
        }
      }
      super.drawHighlighted(context: context, indices: indices)
    }
    context.restoreGState()
  }
}
