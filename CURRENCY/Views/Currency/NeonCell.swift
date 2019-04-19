//
//  NeonCell.swift
//  ExchangeHelper
//
//  Created by Meiliang Wen on 21/01/2018.
//  Copyright © 2018 Meiliang Wen. All rights reserved.
//

import UIKit

class NeonCell: UITableViewCell {

  private var horizontalGap: CGFloat = 30
  private var verticalGap: CGFloat = 5
  var roundingSide: RoundingSide = .all

  lazy var label: UILabel = {
    let _label = UILabel()
    _label.backgroundColor = .clear
    _label.textColor = KKConfiguration.Theme.darkBlue
    return _label
  }()

  // Custom selectedView for cell selected
  // IMPORTANT: Need to set native selectionStyle = .none
  lazy var selectedView: RoundedView = {
    let _view = RoundedView()
    _view.roundingSide = self.roundingSide
    _view.backgroundColor = .clear
    return _view
  }()
    
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setup()
    setupLabel()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
    setupLabel()
  }

  func setup() {
    // color KKConfiguration need to put in init(style: reuseIdentifier) otherwise it won't work.
    backgroundColor = .clear
    contentView.backgroundColor = .clear

    // This do the trick to solve origin selection conflict my custom selection style.
    // cell was reflect white selection flash when cell selected.
    selectionStyle = .none
  }

  func setupLabel() {
    addSubview(label)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.topAnchor.constraint(equalTo: topAnchor, constant: verticalGap).isActive = true
    label.leftAnchor.constraint(equalTo: leftAnchor, constant: horizontalGap).isActive = true
    label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -verticalGap).isActive = true
    label.rightAnchor.constraint(equalTo: rightAnchor, constant: -horizontalGap).isActive = true
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    if selected == true {
      selectedBackgroundView = selectedView
      label.textColor = KKConfiguration.Theme.white
    } else {
      selectedBackgroundView = nil
      label.textColor = KKConfiguration.Theme.darkBlue
    }
  }
}

// Half rounded effect
class RoundedView: UIView {

  var roundingSide: RoundingSide = .all
  var selectedColor: UIColor = KKConfiguration.Theme.darkBlue

  override func draw(_ rect: CGRect) {
    super.draw(rect)
    var roundingCornors: UIRectCorner!
    switch roundingSide {
    case .all:
      roundingCornors = [.topLeft, .bottomLeft, .topRight, .bottomRight]
    case .left:
      roundingCornors = [.topLeft, .bottomLeft]
    case .right:
      roundingCornors = [.topRight, .bottomRight]
    }

    let path = UIBezierPath(roundedRect: frame,
                            byRoundingCorners: roundingCornors,
                            cornerRadii: CGSize(width: frame.size.width,
                                                height: frame.size.height))
    selectedColor.setFill()
    path.fill()
  }

}
