//
//  Protocol.swift
//  LaJoin
//
//  Created by stephen on 2019/5/2.
//  Copyright © 2019 lafresh. All rights reserved.
//

import UIKit
import Foundation
import NVActivityIndicatorView

protocol Loadable { }

extension Loadable {

    /// Show NVActivityIndicatorView and start laoding, but this is not UIBlocker
    ///
    /// - Parameters:
    ///   - center: center point of NVActivityIndicatorView
    ///   - view: a view for NVActivityIndicatorView locate
    ///   - size: the size of NVActivityIndicatorView, default is (44, 44)
    func startLoading(at center: CGPoint, onTopOf view: UIView, size: CGSize = CGSize(width: 44, height: 44)) {
        let activityIndicatorView = NVActivityIndicatorView(frame: CGRect(origin: .zero, size: size), type: .circleStrokeSpin, color: .black, padding: nil)
        activityIndicatorView.center = center
        view.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
    }
    
    /// Stop Loading
    func stopLoading() {
        
        var subviews: [UIView] = []
        
        if let v = (self as? UIViewController)?.view.subviews {
            subviews = v
        }
        
        if let v = (self as? UIView)?.subviews {
            subviews = v
        }

        for view in subviews {
            if let v = view as? NVActivityIndicatorView {
                v.stopAnimating()
            }
        }
    }
}
