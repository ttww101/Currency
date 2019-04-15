//
//  Calculator.swift
//  CURRENCY
//
//  Created by Stan Liu on 30/01/2018.
//  Copyright © 2018 Stan Liu. All rights reserved.
//

import UIKit

class NumberPad: UIView, PadButtonDelegate {

  static let defaultValue = "100"
  static let maximumDigits = 8 // maximum is 9
  @IBOutlet var contentView: UIView!

  @IBOutlet var numericBtns: [PadButton]!
  @IBOutlet var symbolicBtns: [PadButton]!
  @IBOutlet weak var pointBtn: PadButton!
  @IBOutlet weak var deleteBtn: PadButton!

  var receiveHandler:(() -> String)?
  var passHandler: ((String) -> Void)?
  var emptyHandler: ((String) -> Void)?

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    xibInit()
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    xibInit()
  }

  init() {
    super.init(frame: CGRect.zero)
    xibInit()
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    setup()
  }

  func xibInit() {
    _ = R.nib.numberPad.firstView(owner: self)
    addSubview(contentView)
    contentView.frame = bounds
    contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
  }


  func setup() {

    backgroundColor = Configuration.Theme.blue
    for btn in numericBtns {
      btn.delegate = self
    }
    for btn in symbolicBtns {
      btn.delegate = self
    }
    pointBtn.delegate = self
    deleteBtn.delegate = self
    deleteBtn.imageView.image = R.image.backspace()?.coloring(on: .white)
  }

  // MARK: CalculatorButton Delegate

  func buttonDidLongPress(_ btn: PadButton, symbol: String) {
    if btn == deleteBtn {
      passHandler?("")
      emptyHandler?(NumberPad.defaultValue)
      return
    }
  }

  func buttonDidTap(_ btn: PadButton, symbol: String) {
    if btn == pointBtn {
      pointBtnPress(btn, symbol: symbol)
      return
    }
    if btn == deleteBtn {
      deleteBtnPress(btn)
      return
    }
    if numericBtns.contains(btn) {
      numbericBtnPress(btn, symbol: symbol)
      return
    }
    if symbolicBtns.contains(btn) {
      symbolicBtnPress(btn, symbol: symbol)
      return
    }
  }

  func numbericBtnPress(_ btn: PadButton, symbol: String) {
    var string = receiveHandler?() ?? ""
    // if string first is 0 and not contains decimal point
    // case 1: 01 = 1,
    // case 2: 0.1 = 0.1
    if string.first == "0", !string.contains("."), string.count > 0 {
      string.removeFirst()
    }
    string += symbol
    passHandler?(string)
  }

  func symbolicBtnPress(_ btn: PadButton, symbol: String) {
  }

  func pointBtnPress(_ btn: PadButton, symbol: String) {
    var string = receiveHandler?() ?? ""
    // just keep one decimal point in a string
    if string.contains(".") {
      // do nothing
    } else if string.isEmpty {
      passHandler?("0.")
    } else {
      string += symbol
      passHandler?(string)
    }
  }

  func deleteBtnPress(_ btn: PadButton) {
    // if string not nil
    guard var string = receiveHandler?() else {
      passHandler?("")
      emptyHandler?(NumberPad.defaultValue)
      return
    }
    // if string count > 0, otherwise pass empty string
    guard string.count > 0 else {
      passHandler?("")
      emptyHandler?(NumberPad.defaultValue)
      return
    }
    // remove last character by delete btn press
    string.removeLast()
    // after remove last, if last character is decimal point, also delete it
    if string.last == ".", string.count > 1 {
      string.removeLast()
    }
    if string == "0" {
      string.removeAll()
      passHandler?("")
      emptyHandler?(NumberPad.defaultValue)
    }
    // if string is not empty, pass string
    guard string != "" else {
      // otherwise pass empty from default value
      passHandler?("")
      emptyHandler?(NumberPad.defaultValue)
      return
    }
    passHandler?(string)
  }

}
