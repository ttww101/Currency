//
//  LLMemberView.swift
//  FoodSearch
//
//  Created by jacky wang on 2019/2/2.
//  Copyright © 2019 Banset Timsry. All rights reserved.
//

import UIKit
import SnapKit

struct LLMemberFormModel {
    var imageName: String?
    var title: String
    var text: String?
}

final class LLMemberView: UIView {
    
    private lazy var title: UILabel = {
        let lbl = UILabel()
        lbl.backgroundColor = .white
        lbl.textColor = .black
        return lbl
    }()
    
    lazy var textfield: LLTextfiled = {
        return LLTextfiled(frame: .zero)
    }()
    
    private lazy var btn: UIButton = {
        return UIButton()
    }()
    
    private var data: LLMemberFormModel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, data: LLMemberFormModel) {
        self.init(frame: frame)
        self.data = data
        setupDataForViews()
        setupViews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() -> Void {
        
        /// Title
        addSubview(title)
        title.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(4.0)
            make.centerY.equalToSuperview()
            make.width.equalTo(44.0)
        }
        
        /// Icon
        if let _ = data.imageName {
            addSubview(btn)
            btn.snp.makeConstraints { (make) in
                make.trailing.equalToSuperview().offset(4.0)
                make.width.height.equalTo(44.0)
                make.centerY.equalToSuperview()
            }
        }
        
        /// Textfield
        addSubview(textfield)
        textfield.snp.makeConstraints { (make) in
            make.leading.equalTo(title.snp.trailing).offset(4.0)
            if let _ = data.imageName {
                make.trailing.equalTo(btn.snp.leading).offset(-4.0)
            } else {
                make.trailing.equalToSuperview()
            }
            make.height.centerY.equalToSuperview()
        }
    }
    
    private func setupDataForViews() -> Void {
        
        if let imageName = data.imageName {
            btn.setImage(UIImage(named: imageName), for: .normal)
        }
    
        title.text = data.title
        
        if let text = data.text {
            textfield.text = text
        }
    }
    
    public func isEnableSecureTextEntry(sender: Bool) {
        self.textfield.isSecureTextEntry = sender
    }
    
    public func beginEditing(sender: @escaping () -> ()) {
        textfield.beginEditing = {
            sender()
        }
    }
    
    public func finishEditing(sender: @escaping () -> ()) {
        textfield.finishEditing = {
            sender()
        }
    }
}
