//
//  LLTextfiled.swift
//  LaJoin
//
//  Created by stephen on 2019/4/24.
//  Copyright © 2019 lafresh. All rights reserved.
//

import UIKit

/// FIXME: 使用 reactive
final class LLTextfiled: UITextField, UITextFieldDelegate {
    
    public var finishEditing: (() -> ())?
    
    public var beginEditing: (() -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(type: UIReturnKeyType) {
        self.init(frame: .zero)
        returnKeyType = type
    }
    
    func setupViews() {
        delegate = self
        textAlignment = .center
        clearButtonMode = .whileEditing
        autocorrectionType = .no
        autocapitalizationType = .none
        translatesAutoresizingMaskIntoConstraints = false
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = Configuration.UI.cornerRadius
    }
    
    func warning() {
        layer.borderColor = UIColor.red.cgColor
    }
    
    func unwarning() {
        layer.borderColor = UIColor.black.cgColor
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        finishEditing?()
        resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        beginEditing?()
    }
}

