//
//  AnimationView.swift
//  ExchangeHelper
//
//  Created by Meiliang Wen on 23/02/2018.
//  Copyright © 2018 Meiliang Wen. All rights reserved.
//

import Hue
import NVActivityIndicatorView

class KKLoadingView: UIView {

  //internal let refreshViewIdentifier = "RefreshViewContainer"
  @IBOutlet var contentView: UIView!
  @IBOutlet weak var indicatorContainerView: UIView!
  var indicatorView: UIView?
  var isRefreshing: Bool = false

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    xibInit()
    configure()
    run()
  }
  override init(frame: CGRect) {
    super.init(frame: frame)
    xibInit()
    configure()
    run()
  }

  init(indicator: UIView) {
    super.init(frame: .zero)
    xibInit(indicator: indicator)
    configure()
    run()
  }

  func xibInit(indicator: UIView? = nil) {
    _ = R.nib.loadingView.firstView(owner: self)
    addSubview(contentView)
    contentView.frame = bounds
    contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    if let indicator = indicator {
      self.indicatorView = indicator
    } else {
      self.indicatorView = DefaultIndicatorView().indicatorView
    }
  }

  func configure() {
    indicatorContainerView.backgroundColor = .clear

    guard let indicatorView = indicatorView else { return }
    indicatorContainerView.addSubview(indicatorView)
    indicatorView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      indicatorView.centerXAnchor.constraint(equalTo: indicatorContainerView.centerXAnchor),
      indicatorView.centerYAnchor.constraint(equalTo: indicatorContainerView.centerYAnchor),
      indicatorView.leadingAnchor.constraint(greaterThanOrEqualTo: readableContentGuide.leadingAnchor),
      indicatorView.trailingAnchor.constraint(lessThanOrEqualTo: readableContentGuide.trailingAnchor),
      indicatorView.topAnchor.constraint(greaterThanOrEqualTo: indicatorContainerView.topAnchor),
      indicatorView.bottomAnchor.constraint(lessThanOrEqualTo: indicatorContainerView.bottomAnchor)
      ])
  }

  func run() {
    if let indicatorView = indicatorView as? NVActivityIndicatorView {
      indicatorView.startAnimating()
    } else if let indicatorView = indicatorView as? UIActivityIndicatorView {
      indicatorView.startAnimating()
    }
  }

  func stop() {
    if let indicatorView = indicatorView as? NVActivityIndicatorView {
      indicatorView.stopAnimating()
    } else if let indicatorView = indicatorView as? UIActivityIndicatorView {
      indicatorView.stopAnimating()
    }
  }

//  func configure() {
//    indicatorView.type = .circleStrokeSpin
//    indicatorView.color = .darkGray
//  }
//
//  func run() {
//    indicatorView.startAnimating()
//  }
//
//  func stop() {
//    indicatorView.stopAnimating()
//  }
}
