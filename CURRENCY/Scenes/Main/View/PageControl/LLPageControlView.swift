//
//  LLPageControlView.swift
//  FoodSearch
//
//  Created by jacky wang on 2019/1/25.
//  Copyright © 2019 Banset Timsry. All rights reserved.
//

import UIKit
import SnapKit
import Aletheia

/// LLPageControlView
final class LLPageControlView: UIView {
    
    private lazy var scrollView: UIScrollView = {
        let sv = UIScrollView(frame: CGRect(x: 0, y: 0,
                                            width: frame.width,
                                            height: frame.height))
        sv.showsVerticalScrollIndicator = false
        sv.showsHorizontalScrollIndicator = false
        sv.isPagingEnabled = true
        sv.isDirectionalLockEnabled = true
        sv.delegate = self
        return sv
    }()
    
    private let pageControl: UIPageControl = {
        let page = UIPageControl()
        page.currentPageIndicatorTintColor = .white
        page.pageIndicatorTintColor = .gray
        page.tintColor = .black
        page.currentPage = 0
        return page
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
        self.setupEvents()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() -> Void {
        self.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.left.bottom.right.top.equalToSuperview()
        }
        
        scrollView.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
        
        self.addSubview(pageControl)
        pageControl.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(8.0)
        }
    }
    
    private func setupEvents() -> Void {
        pageControl.addTarget(self, action: #selector(pageControlTapped(sender:)), for: .valueChanged)
    }
    
    public func setupBanners(sources: [String]) {
        
        sources.forEach { element in
            let v = LLImageView(frame: frame)
            v.translatesAutoresizingMaskIntoConstraints = false
            v.load(with: element)
            stackView.addArrangedSubview(v)
            v.snp.makeConstraints { (make) in
                make.width.height.equalTo(self)
            }
        }
        
        pageControl.numberOfPages = sources.count
    }
    
    @objc func pageControlTapped(sender: UIPageControl) {
        let pageWidth = scrollView.bounds.width
        let offset = sender.currentPage * Int(pageWidth)
  
        UIView.animate(withDuration: 0.4, animations: { [weak self] in
            self?.scrollView.contentOffset.x = CGFloat(offset)
        })
    }
}

// ******************************************
//
// MARK: - UIScrollViewDelegate
//
// ******************************************

extension LLPageControlView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentOffset.y = 0.0
        
        let pageWidth = self.frame.width
        let pageFraction = scrollView.contentOffset.x / pageWidth

        if pageFraction >= 0 {
            pageControl.currentPage = Int((round(pageFraction)))
        }
    }
}



