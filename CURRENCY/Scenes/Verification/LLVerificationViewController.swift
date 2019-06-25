//
//  LLVerificationViewController.swift
//  FoodSearch
//
//  Created by jacky wang on 2019/2/12.
//  Copyright © 2019 Banset Timsry. All rights reserved.
//

import UIKit


extension LLVerificationViewController: LLHeaderViewProtocol {}

final class LLVerificationViewController: LLViewController {
    
    private var mobile: String!
    
    private let viewModel = LLVerificationViewModel()
    
    private let tfEnterCode: LLTextfiled = {
        let tf = LLTextfiled(type: .done)
        tf.placeholder = Configuration.Context.enterCode
        tf.keyboardType = .numberPad
        return tf
    }()
    
    private lazy var scrollView: LLScrollView = {
        let sv = LLScrollView()
        sv.delegate = self
        return sv
    }()
    
    private let btnVerify: LLButton = {
        return LLButton(title: Configuration.Context.verificationCode,
                        imageName: "icon_phone")
    }()
    
    private let img: UIImageView = {
        let img = UIImageView(image: UIImage(named: "icon_phone"))
        img.sizeToFit()
        return img
    }()
    
    private lazy var lblVerify: UILabel = {
        let v = UILabel(frame: .zero)
        v.text = "驗證手機"
        v.textAlignment = .center
        return v
    }()
    
    private lazy var lblCounting: UILabel = {
        let v = UILabel(frame: .zero)
        v.textAlignment = .center
        return v
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(mobile: String) {
        self.init(nibName: nil, bundle: nil)
        self.mobile = mobile
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "驗證手機"
        self.setupViews()
        self.setupEvents()
        self.setupBindings()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.scrollView.updateContentView()
    }
    
    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.leading.bottom.trailing.top.equalToSuperview()
        }
        
        let headerView = getHeaderView(CGRect(x: 0, y: 0, width: ALScreen.width, height: ALScreen.width * 3 / 4), title: "修改密碼", imageName: "member_header")
        scrollView.addSubview(headerView)
        
        scrollView.addSubview(img)
        img.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(headerView.snp.bottom).offset(offset)
            make.width.equalTo(50.0)
            make.height.equalTo(70.0)
        }
        
        scrollView.addSubview(lblVerify)
        lblVerify.snp.makeConstraints { (make) in
            make.top.equalTo(img.snp.bottom).offset(offset)
            make.centerX.equalToSuperview()
        }
        
        scrollView.addSubview(tfEnterCode)
        tfEnterCode.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(lblVerify.snp.bottom).offset(offset)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(44.0)
        }
        
        scrollView.addSubview(lblCounting)
        lblCounting.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(tfEnterCode.snp.bottom).offset(offset)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(44.0)
        }
        
        scrollView.addSubview(btnVerify)
        btnVerify.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.greaterThanOrEqualTo(lblCounting.snp.bottom).offset(offset * 2)
            make.width.equalTo(ALScreen.width * 0.8)
            make.height.equalTo(44.0)
            make.bottom.lessThanOrEqualTo(self.view).offset(-offset).priority(100.0)
        }
    }
    
    private func setupEvents() -> Void {
        tfEnterCode.beginEditing = {
            self.scrollView.updateConstraints(offset: -44.0)
        }
        
        tfEnterCode.finishEditing = {
            self.scrollView.updateConstraints(offset: 0.0)
            self.prepareToMakeRequest()
        }
        
        _ = btnVerify.reactive.controlEvents(.touchUpInside)
            .observeNext { [unowned self] in
            self.prepareToMakeRequest()
        }
        
        viewModel.setupTimer()
    }
    
    private func setupBindings() {
        viewModel.code.bidirectionalBind(to:
            tfEnterCode.reactive.text)
        viewModel.resend.bind(to: lblCounting.reactive.text)
    }
    
    private func prepareToMakeRequest() {
        viewModel.isCodeEmpty()
            ? showAlertView(Configuration.Context.title,
                             message: Configuration.Context.enterCode,
                             confirm: Configuration.Context.confirm)
            : makeRequest()
    }
    
    private func makeRequest() -> Void {
        viewModel.requestAPI(mobile: self.mobile) { (response) in
            if let model = response as? LLVerificationModel {
//                self.showAlertView(Configuration.Context.title,
//                                    message: model,
//                                    confirm: Configuration.Context.confirm)
            }
            
            if let error = response as? APIError {
                self.showAlertView(Configuration.Context.title,
                                    message: error.message ?? "",
                                    confirm: Configuration.Context.confirm)
            }
        }
    }
}

// ******************************************
//
// MARK: - UIScrollViewDelegate
//
// ******************************************
extension LLVerificationViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentOffset.x = 0.0
    }
}

// ******************************************
//
// MARK: - UITouch Delegate
//
// ******************************************
extension LLVerificationViewController {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /// cf. https://stackoverflow.com/questions/6906246/how-do-i-dismiss-the-ios-keyboard
        if !self.isEditing {
            self.view.endEditing(true)
            self.scrollView.updateConstraints(offset: 0.0)
        }
    }
}


