//
//  LJMainViewController.swift
//  FoodSearch
//
//  Created by jacky wang on 2019/1/21.
//  Copyright © 2019 Banset Timsry. All rights reserved.
//

import UIKit
import SnapKit
import Aletheia

// LLMainViewController
final class LLMainViewController: LLViewController, Loadable {
    
    private let viewModel = LLMainViewModel()
    
    private let cellWidth = UIScreen.main.bounds.width / 5
    
    private let pageControl: LLPageControlView = {
        return LLPageControlView(frame: .zero)
    }()
    
    private var tableView: LLMainTableView = {
        return LLMainTableView(frame: .zero, style: .grouped)
    }()
    
    private var isLoading: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupEvents()
        prepareToMakeRequest()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    func setupViews() -> Void {
        view.addSubview(pageControl)
        pageControl.snp.makeConstraints { (make) in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(ALScreen.height * 0.2)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.trailing.leading.bottom.equalToSuperview()
            make.top.equalTo(pageControl.snp.bottom).offset(offset)
        }
    }
    
    func setupEvents() -> Void {
        
        /// FIXME: 如果 tableview 沒資料，show 沒資料的圖
        _ = viewModel.contents.observeNext { (shops) in
            if shops.source.array.count == 0 { return }
            /// Returns an array containing the non-nil results of calling the given transformation with each element of this sequence.
            let source = shops.source.array.compactMap{ $0 }
            self.tableView.setupContent(contents: source)
            self.tableView.onClick = { [unowned self] shop in
                let vc = LLShopViewController(shop: shop)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
        _ = viewModel.banners.observeNext { (banners) in
            if banners.source.array.count == 0 { return }
            self.pageControl.setupBanners(sources: banners.source.array)
        }
    }
    
    private func prepareToMakeRequest() {
        startLoading(at: view.center, onTopOf: view)
        makeRequest()
    }
    
    private func makeRequest() {
        viewModel.requestAPI { [weak self] (response) in
            self?.stopLoading()
            guard let self = self else { return }
        
            if let error = response as? APIError {
                self.setupAlertView(Configuration.Context.title,
                                    message: error.message ?? "",
                                    confirm: Configuration.Context.confirm)
            }
        }
        viewModel.requestBannerAPI()
    }
}

//// ******************************************
////
//// MARK: - UIScrollViewDelegate
////
//// ******************************************
//extension LLMainViewController: UIScrollViewDelegate {
//
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
////        scrollView.contentOffset.x = 0.0
//    }
//}

