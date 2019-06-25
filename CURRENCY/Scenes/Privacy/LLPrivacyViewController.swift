//
//  LLPrivacyViewController.swift
//  FoodSearch
//
//  Created by jacky wang on 2019/2/14.
//  Copyright © 2019 Banset Timsry. All rights reserved.
//

import UIKit
import WebKit


extension LLPrivacyViewController: Loadable {}
extension LLPrivacyViewController: LLHeaderViewProtocol {}

/// LLPrivacyViewController
final class LLPrivacyViewController: LLViewController {
    
    private let viewModel = LLPrivacyViewModel()

    private let width = ALScreen.width * 0.8
    
    private let btnAgree: LLButton = {
        return LLButton(title: "同意", imageName: "icon_confirm")
    }()
    
    private let btnDisagree: LLButton = {
        return LLButton(title: "不同意", imageName: "icon_error")
    }()
    
    private let webView: WKWebView = {
        let v = WKWebView(frame: .zero, configuration: WKWebViewConfiguration())
        v.layer.borderColor = UIColor.black.cgColor
        v.layer.borderWidth = 1.0
        v.layer.cornerRadius = Configuration.UI.cornerRadius
        return v
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "加入會員"
        setupViews()
        setupEvents()
        setupBindings()
        prepareToMakeRequest()
    }
}

extension LLPrivacyViewController {
 
    /// Setup views with layout
    private func setupViews() {
        let headerView = getHeaderView(CGRect(x: 0, y: 0, width: ALScreen.width, height: ALScreen.width * 3 / 4), title: "會員權益", imageName: "member_header")
        view.addSubview(headerView)
        
        let btnWidth = (width - 8.0) / 2
        view.addSubview(btnAgree)
        btnAgree.snp.makeConstraints { (make) in
            make.width.equalTo(btnWidth)
            make.left.equalTo(view.snp.centerX).offset(4.0)
            make.bottom.equalToSuperview().offset(-4.0)
            make.height.equalTo(44.0)
        }
        
        view.addSubview(btnDisagree)
        btnDisagree.snp.makeConstraints { (make) in
            make.width.equalTo(btnWidth)
            make.right.equalTo(view.snp.centerX).offset(-4.0)
            make.bottom.equalToSuperview().offset(-4.0)
            make.height.equalTo(44.0)
        }
        
        view.addSubview(webView)
        webView.snp.makeConstraints { (make) in
            make.width.equalTo(width)
            make.centerX.equalToSuperview()
            make.top.equalTo(headerView.snp.bottom).offset(offset)
            make.bottom.equalTo(btnDisagree.snp.top).offset(-offset)
        }
    }

    /// All views with events
    private func setupEvents() {
        _ = btnDisagree.reactive.controlEvents(.touchUpInside)
            .observeNext { [weak self] in
                self?.navigationController?.popToRootViewController(animated: true)
        }
        
        _ = btnAgree.reactive.controlEvents(.touchUpInside)
            .observeNext { [weak self] in
                let vc = LLRegisterViewController()
                self?.navigationController?.pushViewController(vc, animated: true)
        }
        
        let aURL = URL(string: "https://www.privacypolicies.com/terms/view/ec255f8350be2c2a35f22b2e3f96259b")!
        self.webView.load(URLRequest(url: aURL))
        
    }
    
    /// Bindings data with UIElements
    private func setupBindings() {
        /// FIXME:  當還沒回傳的時候顏色會變暗
        viewModel.isEnable.bind(to: btnAgree.reactive.isUserInteractionEnabled)
    }

    /// Prepare everything before make request
    private func prepareToMakeRequest() {
        startLoading(at: view.center, onTopOf: view)
        makeRequest()
    }
    
    /// Make reqeust
    private func makeRequest() {
        viewModel.requestAPI{ [weak self] (response) in
            self?.stopLoading()
            if let error = response as? APIError {
                self?.showAlertView(Configuration.Context.title,
                                    message: error.message ?? "",
                                    confirm: Configuration.Context.confirm)
            }
        }
    }
}


