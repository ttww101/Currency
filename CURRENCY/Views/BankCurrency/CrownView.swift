//
//  CrownView.swift
//  ExchangeHelper
//
//  Created by Meiliang Wen on 2018/4/20.
//  Copyright © 2018 Meiliang Wen. All rights reserved.
//

import UIKit

@IBDesignable
class CrownView: UIView {
  var isCrownShown: Bool = true {
    didSet {
      imageView.isHidden = !isCrownShown
      isCrownShown == true
        ? imageView.startGlowing(Configuration.Theme.yellow)
        : imageView.stopGlowing()
    }
  }
  @IBInspectable var image: UIImage? {
    didSet {
      imageView.image = image
    }
  }
  @IBInspectable var text: String = "" {
    didSet {
      label.text = text
    }
  }

  @IBInspectable var font: UIFont = UIFont.systemFont(ofSize: 13) {
    didSet {
      label.font = font
    }
  }

  @IBInspectable var textColor: UIColor = .black {
    didSet {
      label.textColor = textColor
    }
  }

  var rotationAngle: CGFloat = 0 {
    didSet {
      let rotatedImage = image?.rotate(degrees: rotationAngle, flip: false)
      imageView.image = rotatedImage
    }
  }

  lazy var imageView: UIImageView = {
    return UIImageView(frame: CGRect.zero)
  }()

  lazy var label: UILabel = {
    return UILabel(frame: CGRect.zero)
  }()

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    configureConstraints()
  }

  func configureConstraints() {
    imageView.translatesAutoresizingMaskIntoConstraints = false
    label.translatesAutoresizingMaskIntoConstraints = false
    addSubview(label)
    addSubview(imageView) // imageView must be above of label
    // UILabel NSLayoutConstraint
    NSLayoutConstraint.activate([
      label.topAnchor.constraint(equalTo: topAnchor, constant: -10),
      label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
      label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 10),
      label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10)
      ])
    // UIImageView NSLayoutConstraint
    let imageViewHeight: CGFloat = 20.0
    NSLayoutConstraint.activate([
      imageView.centerYAnchor.constraint(equalTo: label.centerYAnchor, constant: -(imageViewHeight / 2 + 3)),
      imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2),
      imageView.heightAnchor.constraint(equalToConstant: imageViewHeight),
      imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
      ])
    layoutIfNeeded()
  }
}
