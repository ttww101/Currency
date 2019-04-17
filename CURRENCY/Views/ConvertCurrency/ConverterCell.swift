//
//  CurrencyCell.swift
//  CURRENCY
//
//  Created by Stan Liu on 29/01/2018.
//  Copyright © 2018 Stan Liu. All rights reserved.
//

import UIKit
import JVFloatLabeledTextField

class SelectedView: UIView {
  var selected: Bool = false {
    didSet {
      self.backgroundColor = selected
        ? Configuration.Theme.green
        : .clear
    }
  }
}

class ConverterCell: UITableViewCell, UITextFieldDelegate {

  weak var delegate: UITextFieldDelegate?
  @IBOutlet weak var selectedView: SelectedView!
  @IBOutlet weak var subjectLabel: UILabel!
  @IBOutlet weak var textField: UITextField!
  var storedString: String = ""
  var shouldDisplayPlaceHolder: Bool = false
  var isTextFieldFirstEdting: Bool = false
  private var textFieldObservation: NSKeyValueObservation?

  override func awakeFromNib() {
    super.awakeFromNib()

    selectionStyle = .none

    textField.delegate = self
    textField.textAlignment = .right
    textField.borderStyle = .none
    textField.textColor = Configuration.Theme.textColor
    textField.font = Configuration.Font.numericFont.size(of: 17)
    textField.keyboardType = .decimalPad
    textField.inputView = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 1))

    subjectLabel.textAlignment = .left
    subjectLabel.textColor = Configuration.Theme.black
    subjectLabel.font = Configuration.Font.letterFont.size(of: 16)

    // KVO for Swift 3.2 and above.
    // Warning: This triggered will after setSelected(selected:animated:) when selecting
    textFieldObservation = textField.observe(\.text, options: [.new]) { [weak self] (textField, changedValue) in
      guard
        let newString = changedValue.newValue as? String,
        textField.isEditing
        else { return }

      self?.storedString = newString

      // 這邊判斷需要跟shouldDisplayPlaceHolder的本意相反，因為在輸入字元的時候，這邊是第一個被triggered的,
      // 但這時候還沒有真正從ConvertCurrencyVC的shouldDisplayPlaceHolder assign給 cell shouldDisplayPlaceHolder
      // 所以需要跟displayPlaceHolder的本意相反
      guard let displayPlaceHolder = self?.shouldDisplayPlaceHolder,
        displayPlaceHolder == true else {
          return
      }
      // If textField is inputing string, make placeHolder empty
      guard newString != "" else {
        return
      }
      textField.placeholder = ""
    }
  }

  deinit {
    textFieldObservation?.invalidate()
  }

  // exceed maximum digits, do shake shake bun bun
  func detect(content: String) -> Bool {
    // 小數點不該出現在第一位
    guard !content.hasPrefix(".") else { return false }
    // 如果小於最大上限並且沒有小數點
    if content.count < NumberPad.maximumDigits, !content.contains(".") {
      // if lenth not exceed maximum, assign string passed by number pad to textfield
      textField.text = content
      return true
    }
    // 把小數點前後的數字分開
    let digits = content.split(separator: ".").map { return $0.count }
    // 把分開後的數字字數加總
    let digitCount = digits.reduce(0, +)
    // 如果加總小於(上限 + 1), 因為要把小數點算進去
    if digitCount < (NumberPad.maximumDigits + 1) {
      // 加總等於上限，而且最後一個字元是小數點，就不做任何動作
      if digitCount == NumberPad.maximumDigits && content.hasSuffix(".") {
        return false
      }
      textField.text = content
      return true
    }
    shake()
    return false
  }

  func clean() {
    textField.text = ""
    textField.placeholder = "/"
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    selectedView.selected = selected
    guard shouldDisplayPlaceHolder, storedString != "" else {
      textField.placeholder = ""
      textField.text = storedString
      return
    }
    textField.text = ""
    textField.placeholder = storedString
  }

  func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    return delegate?.textFieldShouldBeginEditing?(textField) ?? false
  }

  func textFieldDidBeginEditing(_ textField: UITextField) {
    delegate?.textFieldDidBeginEditing?(textField)
  }

  func textFieldDidEndEditing(_ textField: UITextField) {
    delegate?.textFieldDidEndEditing?(textField)
  }

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    return delegate?.textFieldShouldReturn?(textField) ?? false
  }

  // Use my custom number pad wont trigger this method.
  // Use native keyboard
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    return delegate?.textField?(textField,
                                shouldChangeCharactersIn: range,
                                replacementString: string) ?? true
  }
}
