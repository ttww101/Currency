//
//  LLMemberViewController.swift
//  FoodSearch
//
//  Created by jacky wang on 2019/2/2.
//  Copyright © 2019 Banset Timsry. All rights reserved.
//

import SnapKit

import Foundation

final class LLMemberViewController: LLViewController {
    
    private let viewModel = LLRegisterViewModel()
    
    private lazy var scrollView: LLScrollView = {
        return LLScrollView()
    }()
    
    let width = ALScreen.width - 16.0
 
    private lazy var dataButton: LLButton = {
        return LLButton(title: "資料", imageName: nil)
    }()
    
    private lazy var brandBindButton: LLButton = {
        return LLButton(title: "品牌綁定", imageName: nil)
    }()
    
    private lazy var logoutButton: LLButton = {
        return LLButton(title: "登出", imageName: "icon_pencil")
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "會員專區"
        setupViews()
        setupEvents()
        setupBindings()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.updateContentView()
    }
    
    private func setupViews() {
        view.addSubview(dataButton)
        dataButton.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(offset)
            make.top.equalToSuperview().offset(offset)
        }
        
        view.addSubview(brandBindButton)
        brandBindButton.snp.makeConstraints { (make) in
            make.leading.equalTo(dataButton.snp.trailing).offset(offset)
            make.top.equalToSuperview().offset(offset)
        }
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(dataButton.snp.bottom).offset(offset)
            make.leading.bottom.trailing.equalToSuperview()
        }
    
        let frame = CGRect(origin: .zero, size: CGSize(width: width, height: 44.0))
        
        LLMemberViewModel().getViewData().enumerated().forEach { (index, element) in
            let view = LLMemberView(frame: frame, data: element)
            scrollView.addSubview(view)
            view.snp.makeConstraints({ (make) in
                make.width.equalTo(width)
                make.centerX.equalToSuperview()
                make.top.equalToSuperview().offset(index * (44 + Int(offset)))
                make.height.equalTo((44.0))
            })
        }
        
        let lastView = scrollView.subviews.last!
        scrollView.addSubview(logoutButton)
        logoutButton.snp.makeConstraints { (make) in       
            make.centerX.equalToSuperview()
            make.top.greaterThanOrEqualTo(lastView.snp.bottom).offset(offset * 4)
            make.width.equalTo(ALScreen.width * 0.8)
            make.height.equalTo(44.0)
            make.bottom.lessThanOrEqualTo(self.view).offset(-offset).priority(100.0)
        }
    }
    
    private func setupEvents() {
        _ = dataButton.reactive.controlEvents(.touchUpInside)
            .observeNext { [unowned self] in
           
        }
        
        _ = brandBindButton.reactive.controlEvents(.touchUpInside)
            .observeNext { [unowned self] in
        }
        
        _ = logoutButton.reactive.controlEvents(.touchUpInside)
            .observeNext { [unowned self] in
            LLUserManager.share.logout()
            self.navigationController?.viewControllers = [LLLoginViewController()]
        }
    }
    
    private func setupBindings() {
        
    }
}


