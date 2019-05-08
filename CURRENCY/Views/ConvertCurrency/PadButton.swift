//
//  PadButton.swift
//  ExchangeHelper
//
//  Created by candy on 2019/04/25.
//  Copyright © 2018 Meiliang Wen. All rights reserved.
//

import UIKit

protocol PadButtonDelegate: class {
  func buttonDidTap(_ btn: PadButton, symbol: String)
  func buttonDidLongPress(_ btn: PadButton, symbol: String)
}

@IBDesignable
class PadButton: UIView, UIGestureRecognizerDelegate {

  @IBInspectable var title: String = "" {
    didSet {
      self.label.text = title
    }
  }

  @IBInspectable var symbol: String = ""

  weak var delegate: PadButtonDelegate?

  lazy var tapGestureRecognizer: UITapGestureRecognizer = {
    return UITapGestureRecognizer(target: self, action: #selector(PadButton.tapButton(_:)))
  }()

  lazy var longPressGestureRecognizer: UILongPressGestureRecognizer = {
    return UILongPressGestureRecognizer(target: self, action: #selector(PadButton.longPressButton(_:)))
  }()

  lazy var label: UILabel = {
    return UILabel()
  }()

  lazy var imageView: UIImageView = {
    return UIImageView()
  }()

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  func setup() {
    backgroundColor = KKConfiguration.Theme.darkGray

    addSubview(label)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    label.font = KKConfiguration.Font.numericFont.size(of: 22)
    label.textColor = KKConfiguration.Theme.white
    label.backgroundColor = .clear

    addSubview(imageView)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
    imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1).isActive = true

    addGestureRecognizer(tapGestureRecognizer)
    addGestureRecognizer(longPressGestureRecognizer)

    tapGestureRecognizer.delegate = self
    longPressGestureRecognizer.delegate = self
  }

  @objc func tapButton(_ tapGestureRecognizer: UITapGestureRecognizer) {
    delegate?.buttonDidTap(self, symbol: self.symbol)
  }

  @objc func longPressButton(_ longPressGestureRecognizer: UILongPressGestureRecognizer) {
    switch longPressGestureRecognizer.state {
    case .began:
      delegate?.buttonDidLongPress(self, symbol: self.symbol)
      UIView.animate(withDuration: 0.2, animations: {
        self.transform = CGAffineTransform(scaleX: 0.975, y: 0.96)
        self.backgroundColor = KKConfiguration.Theme.lightBlue.alpha(0.7)
      }, completion: nil)
    case .cancelled, .ended:
      UIView.animate(withDuration: 0.2, animations: {
        self.transform = CGAffineTransform.identity
        self.backgroundColor = KKConfiguration.Theme.blue
      })
    default:
      UIView.animate(withDuration: 0) { }
    }
  }

  // MARK: UIGestureRecognizerDelegate

  // Tap gesture required longPress gesture fail
  func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    if otherGestureRecognizer == longPressGestureRecognizer {
      return true
    }
    return false
  }
}
