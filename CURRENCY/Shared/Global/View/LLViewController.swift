
//
//  LLViewController.swift
//  LaJoin
//
//  Created by stephen on 2019/4/25.
//  Copyright © 2019 lafresh. All rights reserved.
//

import UIKit

extension LLViewController: LLAlertViewProtocol {}

class LLViewController: UIViewController {
    
    let offset: CGFloat = {
        return 8.0
    }()

    override func loadView() {
        let v = UIView(frame: UIScreen.main.bounds)
        v.backgroundColor = .white
        self.view = v
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.edgesForExtendedLayout = [UIRectEdge.top]
        self.edgesForExtendedLayout = []
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.isNavigationBarHidden = false

    }
    
}
