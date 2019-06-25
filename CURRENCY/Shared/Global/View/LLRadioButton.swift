
//
//  LLRadioButton.swift
//  LaJoin
//
//  Created by stephen on 2019/5/27.
//  Copyright © 2019 lafresh. All rights reserved.
//

import UIKit

final class LLRadioButton: UIButton {
    
    private let checkedImage = UIImage(named: "icon_option_on")
    
    private let uncheckedImage = UIImage(named: "icon_option_off")
    
    override var isSelected: Bool {
        didSet{
            if isSelected == true {
                self.setImage(checkedImage, for: UIControl.State.normal)
            } else {
                self.setImage(uncheckedImage, for: UIControl.State.normal)
            }
        }
    }
    
    convenience init() {
        self.init(frame: .zero)
        self.setImage(uncheckedImage, for: UIControl.State.normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
