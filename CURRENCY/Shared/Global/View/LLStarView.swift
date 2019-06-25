//
//  LLStarView.swift
//  LaJoin
//
//  Created by stephen on 2019/5/10.
//  Copyright © 2019 lafresh. All rights reserved.
//

import UIKit

/// LLStarRateView
final class LLStarRateView: UIView {
    
    // MARK: - Properties
    var imageViews = [UIImageView]()
    
    var rating: Double = 0.0
    
    var maxRating: Double = 5.0
    
    var fillImage = UIImage(named: "icon_review_star_fill")
    
    var emptyImage = UIImage(named: "icon_review_star")
    
    var halfFillImage = UIImage(named: "icon_star_half")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(rating: Double) {
        self.init(frame: .zero)
        self.rating = rating
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MAKR: - View
    func setup() {
        
        var count: Double = 0.0
        while count < maxRating {
            
            let determine = (rating - count)
            let imageView: UIImageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            
            if determine >= 1 {
                imageView.image = fillImage
            } else if determine < 1 && determine > 0 {
                imageView.image = halfFillImage
            } else {
                imageView.image = emptyImage
            }
            
            imageViews.append(imageView)
            count += 1
        }
        
        // Create UIStackView
        let stackView = UIStackView(arrangedSubviews: imageViews)
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 1.0
        addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalToSuperview()
        }
    }
}
