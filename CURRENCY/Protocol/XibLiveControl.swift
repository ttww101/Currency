//
//  XibLiveControl.swift
//  CURRENCY
//
//  Created by Stan Liu on 2018/4/20.
//  Copyright © 2018 Stan Liu. All rights reserved.
//

import UIKit

protocol XibLiveControl where Self: UIView {
  var containerView: UIView? { get set }
  var nib: UIView? { get }
  func xibSetup() -> UIView?
}

extension XibLiveControl {
  func xibSetup() -> UIView? {
    guard let view = nib else { return nil }
    view.frame = self.bounds
    view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    addSubview(view)
    return view
  }
}
