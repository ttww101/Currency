//
//  DifferencialLabel.swift
//  CURRENCY
//
//  Created by Stan Liu on 10/11/2017.
//  Copyright © 2017 Stan Liu. All rights reserved.
//

import UIKit

@IBDesignable
class DivergenceLabel: UIView, XibLiveControl {
  var nib: UIView? {
    return R.nib.divergenceLabel.firstView(owner: self)
  }
  var containerView: UIView?
  @IBOutlet var imageView: UIImageView!
  @IBOutlet var label: UILabel!
  //@IBInspectable var nibName: String?
  var glowingEnabled: Bool = false {
    didSet {
      if glowingEnabled == true {
        switch self.tendency {
        case .even:
          self.startGlowing(Configuration.Theme.darkBlue)
        case .rise:
          self.startGlowing(Configuration.Theme.red)
        case .fall:
          self.startGlowing(Configuration.Theme.green)
        }
      } else {
        self.stopGlowing()
      }
    }
  }

  var font: UIFont = UIFont.systemFont(ofSize: 11) {
    didSet {
      label.font = self.font
    }
  }

  @IBInspectable var text: String = "10%" {
    didSet {
      label.text = self.text
    }
  }

  @IBInspectable var image: UIImage? {
    didSet {
      imageView.image = image
    }
  }

  var tendency: Tendency = .even {
    didSet {
      switch tendency {
      case .even:
        imageView.image = R.image.even()
        label.textColor = Configuration.Theme.darkBlue
      case .rise:
        imageView.image = R.image.arrow_up()
        label.textColor = Configuration.Theme.red
      case .fall:
        imageView.image = R.image.arrow_down()
        label.textColor = Configuration.Theme.green
      }
    }
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    containerView = xibSetup()
    configure()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    containerView = xibSetup()
    configure()
  }

  override func awakeFromNib() {
    super.awakeFromNib()
  }

  override func prepareForInterfaceBuilder() {
    super.prepareForInterfaceBuilder()
    containerView = xibSetup()
    containerView?.prepareForInterfaceBuilder()
  }

  func configure() {
    // UI
    imageView.contentMode = .scaleAspectFit
    label.font = self.font
  }

  func bind(tendency: Tendency, amountString: String) {
    self.tendency = tendency
    label.text = amountString
  }
}
