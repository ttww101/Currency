//
//  ChartHeader.swift
//  ExchangeHelper
//
//  Created by Meiliang Wen on 28/03/2018.
//  Copyright © 2018 Meiliang Wen. All rights reserved.
//

import UIKit
import Hero

class ChartHeader: UIView {
  let containerOffset: CGFloat = 70.0
  private var heightLayoutConstraint = NSLayoutConstraint()
  private var bottomLayoutConstraint = NSLayoutConstraint()
  private var containerLayoutConstraint = NSLayoutConstraint()

  lazy var containerView: UIView = {
    let _view = UIView(frame: CGRect.zero)
    _view.translatesAutoresizingMaskIntoConstraints = false
    return _view
  }()

  lazy var chart: LineChart = {
    let _chart = LineChart(frame: CGRect.zero)
    _chart.translatesAutoresizingMaskIntoConstraints = false
    return _chart
  }()

  lazy var segmentedControl: PeriodSegmentedControl = {
    let _segmentedControl = PeriodSegmentedControl(frame: CGRect.zero)
    _segmentedControl.translatesAutoresizingMaskIntoConstraints = false
    return _segmentedControl
  }()

  lazy var barView: UIView = {
    let _view = UIView()
    _view.translatesAutoresizingMaskIntoConstraints = false
    return _view
  }()

  lazy var logoImageView: UIImageView = {
    let _imageView = UIImageView(frame: CGRect.zero)
    _imageView.translatesAutoresizingMaskIntoConstraints = false
    _imageView.contentMode = .scaleAspectFit
    _imageView.layer.cornerRadius = 5
    _imageView.layer.masksToBounds = true
    return _imageView
  }()

  lazy var nameLabel: UILabel = {
    let _label = UILabel(frame: CGRect.zero)
    _label.translatesAutoresizingMaskIntoConstraints = false
    _label.font = KKConfiguration.Font.letterFont
    _label.textColor = KKConfiguration.Theme.textColor
    return _label
  }()

  lazy var rateLabel: UILabel = {
    let _label = UILabel(frame: CGRect.zero)
    _label.translatesAutoresizingMaskIntoConstraints = false
    _label.font = KKConfiguration.Font.numericFont
    _label.textColor = KKConfiguration.Theme.textColor
    return _label
  }()

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    configureChart()
    configureSegementedControl()
    configureBarView()
    configureLogo()
    configureLabel()
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    configureChart()
    configureSegementedControl()
    configureBarView()
    configureLogo()
    configureLabel()
  }

  override func awakeFromNib() {
    super.awakeFromNib()
  }

  func configureChart() {
    addSubview(containerView)
    containerView.addSubview(chart)
    let views = ["containerView": containerView, "chart": chart]
    addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[containerView]|",
                                                  options: [],
                                                  metrics: nil,
                                                  views: views))
    addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[containerView]-offset-|",
                                                  options: [],
                                                  metrics: ["offset": containerOffset],
                                                  views: views))
    containerLayoutConstraint = NSLayoutConstraint(item: containerView,
                                                   attribute: .height,
                                                   relatedBy: .equal,
                                                   toItem: self,
                                                   attribute: .height,
                                                   multiplier: 1.0,
                                                   constant: -(containerOffset))
    addConstraint(containerLayoutConstraint)
    containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[chart]|",
                                                                options: [],
                                                                metrics: nil,
                                                                views: views))
    bottomLayoutConstraint = NSLayoutConstraint(item: chart,
                                                attribute: .bottom,
                                                relatedBy: .equal,
                                                toItem: containerView,
                                                attribute: .bottom,
                                                multiplier: 1.0,
                                                constant: 0)
    containerView.addConstraint(bottomLayoutConstraint)
    heightLayoutConstraint = NSLayoutConstraint(item: chart,
                                                attribute: .height,
                                                relatedBy: .equal,
                                                toItem: containerView,
                                                attribute: .height,
                                                multiplier: 1.0,
                                                constant: 0)
    containerView.addConstraint(heightLayoutConstraint)
    containerView.heroID = "chartImageView"
  }

  func configureSegementedControl() {
    addSubview(segmentedControl)
    segmentedControl.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
    segmentedControl.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
    segmentedControl.centerYAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10).isActive = true
    segmentedControl.heightAnchor.constraint(equalToConstant: 40).isActive = true
  }

  func configureBarView() {
    addSubview(barView)
    barView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
    barView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    barView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    barView.heightAnchor.constraint(equalToConstant: 60).isActive = true
  }

  func configureLogo() {
    barView.addSubview(logoImageView)
    logoImageView.leadingAnchor.constraint(equalTo: barView.leadingAnchor, constant: 10).isActive = true
    logoImageView.centerYAnchor.constraint(equalTo: barView.centerYAnchor).isActive = true
    logoImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
    logoImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
    logoImageView.heroID = "logoImageView"
  }
  func configureLabel() {
    barView.addSubview(nameLabel)
    barView.addSubview(rateLabel)
    nameLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 10).isActive = true
    nameLabel.centerYAnchor.constraint(equalTo: logoImageView.centerYAnchor).isActive = true

    rateLabel.trailingAnchor.constraint(equalTo: barView.trailingAnchor, constant: -20).isActive = true
    rateLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor).isActive = true
    nameLabel.heroID = "nameLabel"
  }

  func scrollViewDidScroll(scrollView: UIScrollView) {
    containerLayoutConstraint.constant = scrollView.contentInset.top - containerOffset
    let offsetY = -(scrollView.contentOffset.y + scrollView.contentInset.top)
    containerView.clipsToBounds = offsetY <= 0
    bottomLayoutConstraint.constant = offsetY >= 0 ? 0 : -offsetY / 2
    heightLayoutConstraint.constant = max(offsetY + scrollView.contentInset.top, scrollView.contentInset.top)
  }
}
