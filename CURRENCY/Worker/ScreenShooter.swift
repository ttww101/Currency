//
//  ChartCameraman.swift
//  ExchangeHelper
//
//  Created by Meiliang Wen on 28/03/2018.
//  Copyright © 2018 Meiliang Wen. All rights reserved.
//

import UIKit

class ScreenShooter: UIWindow {

  var subjects: [Decimal] = []

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    configure()
  }

  convenience init() {
    let height: Double = 200
    let width: Double = 200 * 1.3
    self.init(frame: CGRect(x: 0, y: 0, width: width, height: height))
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }

  private func configure() {
    //self.windowLevel = UIWindowLevelAlert + 1000
    self.windowLevel = UIWindow.Level.normal - 1000
//    guard let vc = R.storyboard.screenshotSB.screenshotChartVC() else { return }
//    rootViewController = vc
  }

  private func show(completion: (() -> Void)? = nil) {
    self.makeKeyAndVisible()
    guard let vc = self.rootViewController as? ScreenshotChartVC else { return }
    vc.chart.subjects = self.subjects
    vc.chart.dates = self.subjects.map { _ in return "" }
    vc.chart.reloadData(completion: completion)
  }

  func takePhoto(completion: @escaping (UIImage?) -> Void) {
    //DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
    DispatchQueue.main.async {
      self.show {
        guard
          let vc = self.rootViewController as? ScreenshotChartVC,
          let chartImage = vc.view.screenshot
          else {
            completion(nil)
            return
        }
        completion(chartImage)
      }
    }
  }
}
