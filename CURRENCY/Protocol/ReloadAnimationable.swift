//
//  LanguageRefreshable.swift
//  CURRENCY
//
//  Created by Stan Liu on 26/02/2018.
//  Copyright © 2018 Stan Liu. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

protocol LoadingContainer: class {
  var loadingContainerView: UIView? { get set }
}

protocol LoadingControl {
  var indicatorView: UIView { get }
  var indicatorContainer: LoadingView? { get }
  var onView: LoadingContainer { get }
  func showLoading()
  func dismissLoading()
}

extension UIView: LoadingContainer {
  static let LoadingViewTag = 666
  var loadingContainerView: UIView? {
    get {
      return viewWithTag(UIView.LoadingViewTag)
    }
    set {
      viewWithTag(UIView.LoadingViewTag)?.removeFromSuperview()

      guard let view = newValue else { return }

     view.tag = UIView.LoadingViewTag
      addSubview(view)
      view.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        view.centerXAnchor.constraint(equalTo: centerXAnchor),
        view.centerYAnchor.constraint(equalTo: centerYAnchor),
        view.leadingAnchor.constraint(greaterThanOrEqualTo: readableContentGuide.leadingAnchor),
        view.trailingAnchor.constraint(lessThanOrEqualTo: readableContentGuide.trailingAnchor),
        view.topAnchor.constraint(greaterThanOrEqualTo: topAnchor),
        view.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor)
        ])
    }
  }
}

extension LoadingControl where Self: UIView {
  var onView: LoadingContainer {
    return self
  }
}

extension LoadingControl where Self: UIViewController {
  var onView: LoadingContainer {
    return view
  }
}

extension LoadingControl where Self: UITableViewController {
  var onView: LoadingContainer {
    if let container = tableView.backgroundView {
      return container
    }
    return view
  }
}

struct DefaultIndicatorView {
  var indicatorView: UIView {
    return NVActivityIndicatorView(frame: CGRect(x: 0,
                                                 y: 0,
                                                 width: 30,
                                                 height: 30),
                                   type: .circleStrokeSpin,
                                   color: .darkGray, padding: 0)
  }
}

extension LoadingControl {
  // Default indicator view
  var indicatorView: UIView {
    return NVActivityIndicatorView(frame: CGRect(x: 0,
                                                 y: 0,
                                                 width: 30,
                                                 height: 30),
                                   type: .circleStrokeSpin,
                                   color: .darkGray, padding: 0)
  }
  // Default refresh view
  var indicatorContainer: LoadingView? {
    return LoadingView(indicator: self.indicatorView)
  }

  func dismissLoading() {
    onView.loadingContainerView = nil
  }

  func showLoading() {
    guard let sv = indicatorContainer else { return }
    onView.loadingContainerView = sv.contentView
  }
}

//extension RefreshViewControl where Self: UIViewController {
//  func showRefreshView() {
//    let containerView = UIView(frame: UIScreen.main.bounds)
//    containerView.restorationIdentifier = loadingView.refreshViewIdentifier
//    containerView.addSubview(loadingView)
//    guard let keyWindow = UIApplication.shared.keyWindow else { return }
//    keyWindow.addSubview(containerView)
//    loadingView.isRefreshing = true
//  }
//
//  func dismissRefreshView() {
//    if loadingView.isRefreshing {
//      guard let keyWindow = UIApplication.shared.keyWindow else { return }
//      for item in keyWindow.subviews
//        where item.restorationIdentifier == loadingView.refreshViewIdentifier {
//          item.removeFromSuperview()
//      }
//      loadingView.isRefreshing = false
//    }
//  }
//}
