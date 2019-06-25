//
//  LLTitleImageView.swift
//  LaJoin
//
//  Created by stephen on 2019/4/27.
//  Copyright © 2019 lafresh. All rights reserved.
//

import UIKit

protocol LLHeaderViewProtocol {}

extension LLHeaderViewProtocol where Self: LLViewController {
    
    func getHeaderView(_ frame: CGRect, title: String, imageName: String) -> UIImageView  {

        let img = UIImageView(frame: frame)
        img.image = UIImage(named: imageName)
        img.contentMode = UIView.ContentMode.scaleAspectFill
        img.clipsToBounds = true
   
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        gradient.colors = [UIColor.white.cgColor, UIColor.black.cgColor]
        gradient.opacity = 0.5
        img.layer.addSublayer(gradient)
        
        let lbl = UILabel(frame: .zero)
        lbl.text = title
        lbl.textAlignment = .center
        lbl.textColor = .white
        img.addSubview(lbl)
        lbl.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-16.0)
        }
        
        return img
    }
}
