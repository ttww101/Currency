//
//  LLToastView.swift
//  LaJoin
//
//  Created by stephen on 2019/6/22.
//  Copyright © 2019 lafresh. All rights reserved.
//
import UIKit

protocol LLToastProtocol {}

/// 之後改 reactive kit 方式
extension LLToastProtocol where Self: LLViewController {
    
    
    func showToast(controller: UIViewController,
                   message : String,
                   seconds: Double = Configuration.UI.toastDuration) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = .black
        alert.view.alpha = 0.6
        alert.view.layer.cornerRadius = 15
        
        controller.present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
}
