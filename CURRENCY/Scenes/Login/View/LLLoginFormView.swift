//
//  LLLoginFormView.swift
//  LaJoin
//
//  Created by stephen on 2019/4/23.
//  Copyright © 2019 lafresh. All rights reserved.
//

import UIKit
import SnapKit
import ReactiveKit

final class LLLoginFormView: UIView {
    
    private let title: UILabel = {
        let lbl = UILabel()
        lbl.backgroundColor = .white
        lbl.textColor = .black
        lbl.textAlignment = .left
        return lbl
    }()

    private(set) lazy var textfield: LLTextfiled = {
        return LLTextfiled(type: data.returnType)
    }()
    
    private lazy var icon: UIImageView = {
        return UIImageView()
    }()
    
    private var data: LLLoginFormModel

    init(frame: CGRect, data: LLLoginFormModel) {
        self.data = data
        super.init(frame: frame)
        self.setupData()
        self.setupViews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() -> Void {
        
        /// Icon
        if let _ = data.imageName {
            addSubview(icon)
            icon.snp.makeConstraints { (make) in
                make.leading.equalToSuperview().offset(2.0)
                make.width.height.equalTo(22.0)
                make.top.equalTo(2.0)
            }
        }
        
        /// Title
        addSubview(title)
        title.snp.makeConstraints { (make) in
            if let _ = data.imageName {
                make.leading.equalTo(icon.snp.trailing).offset(4.0)
            } else {
                make.leading.equalToSuperview().offset(2.0)
            }
            make.height.equalTo(22.0)
            make.trailing.equalToSuperview()
            make.top.equalTo(2.0)
        }
        
        /// Textfield
        addSubview(textfield)
        textfield.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(title.snp.bottom).offset(4.0)
        }
    }
    
    private func setupData() -> Void {
        
        if let imageName = data.imageName {
            icon.image = UIImage(named: imageName)
        }
        
        title.text = data.title
        
        textfield.placeholder = data.placeholder
    }
    
    public func isEnableSecureTextEntry(sender: Bool) {
        textfield.isSecureTextEntry = sender
    }
    
    public func beginEditing(sender: @escaping () -> ()) {
        textfield.beginEditing = {
            sender()
        }
    }
    
    public func finishEditing(sender: @escaping (_ text: String?) -> ()) {
        textfield.finishEditing = { [unowned self] in
            sender(self.textfield.text)
        }
    }
}

struct LLLoginFormModel {
    var imageName: String?
    var title: String
    var placeholder: String
    var returnType: UIReturnKeyType
}

