//
//  GenderButton.swift
//  FoodSearch
//
//  Created by jacky wang on 2019/1/28.
//  Copyright © 2019 Banset Timsry. All rights reserved.
//

import UIKit

final class LLGenderButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String, isSelected: Bool) {
        self.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.setTitleColor(.black, for: .normal)
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1.0
        self.isSelected = isSelected
        
    }
    
    override var isSelected: Bool {
        didSet {
            self.backgroundColor = isSelected ? UIColor(red:0.78, green:0.08, blue:0.52, alpha:1.0) : .white
        }
    }
}
