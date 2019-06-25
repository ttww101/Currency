//
//  LLScrollView.swift
//  LaJoin
//
//  Created by stephen on 2019/4/27.
//  Copyright © 2019 lafresh. All rights reserved.
//

import UIKit

final class LLScrollView: UIScrollView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init() {
        self.init(frame: .zero)
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = true
    }

    /// Let super view catch the event
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.next?.touchesBegan(touches, with: event)
    }
    
    public func updateConstraints(offset: CGFloat) -> Void {
        UIView.animate(withDuration: 0.5, animations: {
            self.snp.updateConstraints({ (make) in
                make.top.equalToSuperview().offset(offset)
            })
            self.superview?.layoutIfNeeded()
        })
    }
}


