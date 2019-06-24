//
//  LLMainTableView.swift
//  FoodSearch
//
//  Created by jacky wang on 2019/2/6.
//  Copyright © 2019 Banset Timsry. All rights reserved.
//

import UIKit
import Aletheia

final class LLMainTableView: UITableView {
    
    private var contents: [LLShopModel] = []

    private let identifier: String = "Identifier"
    
    public var onClick: ((_ model: LLShop) -> ())?

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        register(LLMainTableViewCell.self, forCellReuseIdentifier: identifier)
        
        delegate = self
        dataSource = self
        
        separatorStyle = .none
        backgroundColor = .clear
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
    }
    
    public func setupContent(contents: [LLShopModel]) {
        self.contents = contents
        reloadData()
    }
}

// ******************************************
//
// MARK: - UITableViewDelegate
//
// ******************************************
extension LLMainTableView: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        /// FIXME: heightForHeaderInSection 第一個會有高度問題，也可以嘗試自己創一個新的 view
        return 33.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 188.0
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        (view as! UITableViewHeaderFooterView).backgroundView?.backgroundColor = UIColor.clear
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return contents[section].name
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return contents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! LLMainTableViewCell
        cell.update(content: contents[indexPath.section])
        cell.onClick = { [unowned self] shop in
            self.onClick?(shop)
        }
        return cell
    }
}

// ******************************************
//
// MARK: - UIScrollViewDelegate
//
// ******************************************
extension LLMainTableView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {


    }
}
