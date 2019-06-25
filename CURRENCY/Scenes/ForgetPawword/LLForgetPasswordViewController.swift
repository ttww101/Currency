//
//  ForgetPawwordViewController.swift
//  FoodSearch
//
//  Created by jacky wang on 2019/1/25.
//  Copyright © 2019 Banset Timsry. All rights reserved.
//

import UIKit


extension LLForgetPasswordViewController: LLHeaderViewProtocol {}

final class LLForgetPasswordViewController: LLViewController {
        
    private let viewModel = LLForgetPasswordViewModel()
    
    private let tfForget: LLTextfiled = {
        let tf = LLTextfiled(type: .done)
        tf.placeholder = Configuration.Context.enterPhone
        tf.keyboardType = .numberPad
        return tf
    }()
    
    private lazy var scrollView: LLScrollView = {
        let sv = LLScrollView()
        sv.delegate = self
        return sv
    }()
    
    private let confirmButton: LLButton = {
        return LLButton(title: Configuration.Context.verificationCode,
                        imageName: "icon_phone_small")
    }()
    
    private lazy var img: UIImageView = {
        let img = UIImageView(image: UIImage(named: "icon_phone"))
        img.sizeToFit()
        return img
    }()
    
    private lazy var lblVerification: UILabel = {
        let v = UILabel(frame: .zero)
        v.text = "驗證手機"
        v.textAlignment = .center
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "忘記密碼"
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
    
        let headerView = getHeaderView(CGRect(x: 0, y: 0, width: ALScreen.width, height: ALScreen.width * 3 / 4), title: "資料填寫", imageName: "member_header")
        scrollView.addSubview(headerView)
        
        scrollView.addSubview(img)
        let intrinsic = img.intrinsicContentSize
        img.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(headerView.snp.bottom).offset(offset)
            make.width.equalTo(intrinsic.width)
            make.height.equalTo(intrinsic.height)
        }
        
        scrollView.addSubview(lblVerification)
        lblVerification.snp.makeConstraints { (make) in
            make.top.equalTo(img.snp.bottom).offset(offset)
            make.centerX.equalToSuperview()
        }
        
        scrollView.addSubview(tfForget)
        tfForget.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(lblVerification.snp.bottom).offset(offset)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(44.0)
        }
        
        scrollView.addSubview(confirmButton)
        confirmButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.greaterThanOrEqualTo(tfForget.snp.bottom).offset(offset * 2)
            make.width.equalTo(ALScreen.width * 0.8)
            make.height.equalTo(44.0)
            make.bottom.lessThanOrEqualTo(self.view).offset(-offset).priority(100.0)
        }
    }
    
    private func setupEvents() -> Void {
        tfForget.beginEditing = {
            self.scrollView.updateConstraints(offset: -44.0)
        }
      
        tfForget.finishEditing = {
            self.scrollView.updateConstraints(offset: 0.0)
            self.prepareToMakeRequest()
        }
        
        _ = confirmButton.reactive.controlEvents(.touchUpInside)
            .observeNext { [unowned self] in
            self.prepareToMakeRequest()
        }
    }
    
    private func setupBindings() {
        viewModel.phone.bidirectionalBind(to:
            tfForget.reactive.text)
    }
    
    private func prepareToMakeRequest() {
        viewModel.isPasswordEmpty()
            ? showAlertView(Configuration.Context.title,
                             message: Configuration.Context.enterPhone,
                             confirm: Configuration.Context.confirm)
            : makeRequest()
    }
    
    
    private func makeRequest() -> Void {
        viewModel.requestAPI() { (response) in
            if let model = response as? LLForgetPasswordModel {
                let vc = LLVerificationViewController(mobile: model.mobile)
                self.navigationController?.pushViewController(vc, animated: true)
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
extension LLForgetPasswordViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentOffset.x = 0.0
    }
}

// ******************************************
//
// MARK: - UITouch Delegate
//
// ******************************************
extension LLForgetPasswordViewController {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /// cf. https://stackoverflow.com/questions/6906246/how-do-i-dismiss-the-ios-keyboard
        if !self.isEditing {
            self.view.endEditing(true)
            self.scrollView.updateConstraints(offset: 0.0)
        }
    }
}
