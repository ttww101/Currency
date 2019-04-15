//
//  OptionView.swift
//  CURRENCY
//
//  Created by Stan Liu on 22/01/2018.
//  Copyright © 2018 Stan Liu. All rights reserved.
//

import UIKit

class OptionView: UIView {

  @IBOutlet var contentView: UIView!
  @IBOutlet weak var confirmBtn: UIButton!
  @IBOutlet weak var cancelBtn: UIButton!

  var confirmHandler: (() -> Void)?
  var cancelHandler: (() -> Void)?

  @IBAction func confirm(_ sender: Any) {
    confirmHandler?()
  }

  @IBAction func cancel(_ sender: Any) {
    cancelHandler?()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    xibInit()
  }

  init() {
    super.init(frame: CGRect.zero)
    xibInit()
    // Programmatically init doesn't trigger awakeFromNib(), So need to do set view's configuration.
    setupButtons()
    configure()
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    setupButtons()
    configure()
  }

  func xibInit() {
    _ = R.nib.optionView.firstView(owner: self)
    addSubview(contentView)
    contentView.frame = bounds
    contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
  }

  func configure() {
    backgroundColor = .clear
    contentView.backgroundColor = .clear
    setNeedsUpdateConstraints()
    setNeedsLayout()
  }

  func setupButtons() {
    confirmBtn.setImage(R.image.hook()?.coloring(on: Configuration.Theme.green), for: .normal)
    cancelBtn.setImage(R.image.cross()?.coloring(on: Configuration.Theme.red), for: .normal)
  }
}
