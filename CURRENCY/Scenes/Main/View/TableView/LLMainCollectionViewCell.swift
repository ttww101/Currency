//
//  LLMainCollectionViewCell.swift
//  FoodSearch
//
//  Created by jacky wang on 2019/2/6.
//  Copyright © 2019 Banset Timsry. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

final class LLMainCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var title: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        return lbl
    }()
    
    private let img: LLImageView = {
        let img = LLImageView()
        img.layer.cornerRadius = Configuration.UI.cornerRadius
        return img
    }()

    private lazy var iconFavorite: UIImageView = {
        let img = UIImageView(image: UIImage(named: "icon_love"))
        img.contentMode = UIView.ContentMode.scaleAspectFill
        return img
    }()
    
    private lazy var iconDistance: UIImageView = {
        let img = UIImageView(image: UIImage(named: "icon_location"))
        img.contentMode = UIView.ContentMode.scaleAspectFill
        return img
    }()
    
    private lazy var lblDistance: UILabel = {
        let lbl = UILabel()
        lbl.text = "325 k"
        lbl.textAlignment = .center
        return lbl
    }()
    
    private lazy var iconLikes: UIImageView = {
        let img = UIImageView(image: UIImage(named: "icon_star1"))
        img.contentMode = UIView.ContentMode.scaleAspectFill
        return img
    }()
    
    private lazy var lblLikes: UILabel = {
        let lbl = UILabel()
        lbl.text = "1.2"
        lbl.textAlignment = .center
        return lbl
    }()
    
    private func setupViews() {
        contentView.layer.borderColor = UIColor.gray.cgColor
        contentView.layer.borderWidth = 1.0
        contentView.layer.cornerRadius = Configuration.UI.cornerRadius
        
        contentView.addSubview(img)
        img.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(120.0)
        }
        
        contentView.addSubview(title)
        title.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(8.0)
            make.top.equalTo(img.snp.bottom).offset(8.0)
            make.height.equalTo(22.0)
        }
        
        contentView.addSubview(iconFavorite)
        iconFavorite.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-8.0)
            make.centerY.equalTo(title)
            make.height.width.equalTo(12.0)
        }
        
        contentView.addSubview(iconDistance)
        iconDistance.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(8.0)
            make.top.equalTo(title.snp.bottom).offset(8.0)
            make.height.width.equalTo(12.0)
        }
        
        contentView.addSubview(lblDistance)
        lblDistance.snp.makeConstraints { (make) in
            make.leading.equalTo(iconDistance.snp.trailing).offset(4.0)
            make.centerY.equalTo(iconDistance)
            make.height.equalTo(22.0)
        }
        
        contentView.addSubview(iconLikes)
        iconLikes.snp.makeConstraints { (make) in
            make.leading.equalTo(lblDistance.snp.trailing).offset(8.0)
            make.centerY.equalTo(iconDistance)
            make.height.width.equalTo(12.0)
        }
        
        contentView.addSubview(lblLikes)
        lblLikes.snp.makeConstraints { (make) in
            make.leading.equalTo(iconLikes.snp.trailing).offset(4.0)
            make.centerY.equalTo(iconDistance)
            make.height.equalTo(22.0)
        }
    }
    
    func setData(data: LLShop) {
        
        title.text = data.shopName
        
        guard let sourcePath = data.imgfile1 else {
            self.img.image = UIImage(named: "default_meal")
            return
        }
        
        self.img.load(with: Configuration.API.domain + sourcePath, placeholder: "default_food")
    }
}
