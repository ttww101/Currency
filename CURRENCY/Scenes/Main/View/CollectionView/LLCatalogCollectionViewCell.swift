//
//  LLCatalogCollectionViewCell.swift
//  FoodSearch
//
//  Created by jacky wang on 2019/1/22.
//  Copyright © 2019 Banset Timsry. All rights reserved.
//

import UIKit

final class LLCatalogCollectionViewCell: UICollectionViewCell {
    
    public let img: UIImageView = {
        let img = UIImageView()
        img.contentMode = UIView.ContentMode.center
        return img
    }()
    
    public lazy var lblDescription: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(img)
        img.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.75)
        }
        
        contentView.addSubview(lblDescription)
        lblDescription.snp.makeConstraints { (make) in
            make.bottom.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.25)
        }
    }
}
