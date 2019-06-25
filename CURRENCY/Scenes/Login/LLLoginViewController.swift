//
//  LLLoginViewController.swift
//  LaJoin
//
//  Created by stephen on 2019/4/21.
//  Copyright © 2019 lafresh. All rights reserved.
//

import Bond
import UIKit
import SnapKit
import ReactiveKit

extension LLLoginViewController: LLHeaderViewProtocol {}
extension LLLoginViewController: Loadable {}

/// LLLoginViewController
final class LLLoginViewController: LLViewController {

    private let viewModel = LLLoginViewModel()
    
    private lazy var scrollView: LLScrollView = {
        let sv = LLScrollView()
        sv.delegate = self
        return sv
    }()
    
    private let width = ALScreen.width * 0.8
    
    private lazy var accountView: LLLoginFormView = {
        let frame = CGRect(origin: .zero, size: CGSize(width: width, height: 88.0))
        let data = LLLoginFormModel(imageName: nil, title: "帳號",
                                    placeholder: "輸入您的手機號碼", returnType: .done)
        return LLLoginFormView(frame: frame, data: data)
    }()
    
    private lazy var passwordView: LLLoginFormView = {
        let frame = CGRect(origin: .zero, size: CGSize(width: width, height: 88.0))
        let data = LLLoginFormModel(imageName: nil, title: "密碼",
                                    placeholder: "請輸入密碼", returnType: .done)
        return LLLoginFormView(frame: frame, data: data)
    }()
    
    private lazy var confirmButton: LLButton = {
        return LLButton(title: "登入", imageName: "icon_key")
    }()
    
    private lazy var forgetBtn: UIButton = {
        let btn = UIButton()
        btn.setAttributedTitle(attributedTitle(title: "忘記密碼"), for: .normal)
        return btn
    }()
    
    private lazy var registerBtn: UIButton = {
        let btn = UIButton()
        btn.setAttributedTitle(attributedTitle(title: "會員申請"), for: .normal)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "會員專區"
        setupViews()
        setupEvents()
        setupBindings()
        
        self.isHeroEnabled = true
        self.navigationController?.isHeroEnabled = true
        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .never
        }
    }
    


    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.updateContentView()
    }
    
    // cf: https://github.com/andreatoso/UIScrollView-Programmatically/blob/master/UIScrollView%20Programmatically/ViewController.swift
    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.leading.bottom.trailing.top.equalToSuperview()
        }

        let headerView = getHeaderView(CGRect(x: 0, y: 0,
                                              width: ALScreen.width, height: ALScreen.width * 3 / 4),
                                       title: "會員登入",
                                       imageName: "member_header")
        scrollView.addSubview(headerView)
        
        scrollView.addSubview(accountView)
        accountView.snp.makeConstraints { (make) in
            make.width.equalTo(width)
            make.centerX.equalToSuperview()
            make.top.equalTo(headerView.snp.bottom).offset(offset)
            make.height.equalTo((74.0))
        }
        
        scrollView.addSubview(passwordView)
        passwordView.isEnableSecureTextEntry(sender: true)
        passwordView.snp.makeConstraints { (make) in
            make.width.equalTo(width)
            make.centerX.equalToSuperview()
            make.top.equalTo(accountView.snp.bottom).offset(offset)
            make.height.equalTo((74.0))
        }
        
        scrollView.addSubview(confirmButton)
        confirmButton.snp.makeConstraints { (make) in
            make.width.equalTo(width)
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordView.snp.bottom).offset(offset * 2)
            make.height.equalTo(44.0)
        }
        
        scrollView.addSubview(forgetBtn)
        forgetBtn.snp.makeConstraints { (make) in
            make.width.equalTo(88.0)
            make.trailing.equalTo(confirmButton.snp.centerX).offset(-offset)
            make.top.equalTo(confirmButton.snp.bottom).offset(offset)
            make.height.equalTo(22.0)
        }

        scrollView.addSubview(registerBtn)
        registerBtn.snp.makeConstraints { (make) in
            make.width.equalTo(88.0)
            make.leading.equalTo(confirmButton.snp.centerX).offset(offset)
            make.top.equalTo(confirmButton.snp.bottom).offset(offset)
            make.height.equalTo(22.0)
        }
    }
    
    private func setupEvents() {
        accountView.beginEditing { [weak self] in
            self?.scrollView.updateConstraints(offset: -48.0)
        }
        
        accountView.finishEditing { [weak self] _ in
            self?.passwordView.textfield.becomeFirstResponder()
        }
        
        passwordView.beginEditing { [weak self] in
            self?.scrollView.updateConstraints(offset: -88.0)
        }
        
        passwordView.finishEditing { [weak self] _ in
            self?.scrollView.updateConstraints(offset: 0.0)
            self?.prepareToMakeRequest()
        }
        
        _ = confirmButton.reactive.controlEvents(.touchUpInside)
            .observeNext { [weak self] in
            self?.prepareToMakeRequest()
        }
        
        _ = forgetBtn.reactive.controlEvents(.touchUpInside)
            .observeNext { [weak self] in
            let vc = LLForgetPasswordViewController()
            self?.navigationController?.pushViewController(vc, animated: true)
        }

        _ = registerBtn.reactive.controlEvents(.touchUpInside)
            .observeNext { [weak self] in
            let vc = LLPrivacyViewController()
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func setupBindings() {
        viewModel.account.bidirectionalBind(to: accountView.textfield.reactive.text)
        viewModel.password.bidirectionalBind(to: passwordView.textfield.reactive.text)
    }
    
    private func attributedTitle(title: String) -> NSAttributedString {
        return NSAttributedString(
            string: title,
            attributes:[
                NSAttributedString.Key.foregroundColor: UIColor.black,
                NSAttributedString.Key.underlineStyle: 1.0
            ])
    }
    
    private func prepareToMakeRequest() {
        if !viewModel.isEmpty() {
            startLoading(at: view.center, onTopOf: view)
            makeRequest()
        } else {
            showAlertView(Configuration.Context.title,
                           message: "請輸入帳號或者密碼",
                           confirm: Configuration.Context.confirm)
        }
    }
    
    private func makeRequest() -> Void {
        viewModel.requestAPI() { [weak self] (response) in
            self?.stopLoading()
            guard let self = self else { return }
            if let infos = response as? LLUserManager.Infos {
                LLUserManager.share.login(value: infos)
                self.navigationController?.viewControllers = [LLMemberViewController()]
            }
      
        }
    }
}

// ******************************************
//
// MARK: - UIScrollViewDelegate
//
// ******************************************
extension LLLoginViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentOffset.x = 0.0
    }
}

// ******************************************
//
// MARK: - UITouch Delegate
//
// ******************************************
extension LLLoginViewController {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /// cf. https://stackoverflow.com/questions/6906246/how-do-i-dismiss-the-ios-keyboard
        if !isEditing {
            view.endEditing(true)
            scrollView.updateConstraints(offset: 0.0)
        }
    }
}



