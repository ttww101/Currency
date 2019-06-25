//
//  LLImageView.swift
//  LaJoin
//
//  Created by stephen on 2019/5/14.
//  Copyright © 2019 lafresh. All rights reserved.
//

import UIKit
import Kingfisher

/// LLImageView
public final class LLImageView: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init() {
        self.init(frame: .zero)
        self.contentMode = .scaleToFill
        self.clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Load online reosurce, if fails show placeholder instead
    ///
    /// - Parameters:
    ///   - aURL: image url source
    ///   - placeholder: placeholder name
    public func load(with aURL: String?, placeholder: String = "icon_logo") {
    
        let placeholderImage = UIImage(named: placeholder)
        
        guard let aURL = aURL else {
            self.image = placeholderImage
            return
        }
        
        /// Early return while given string is not a vaild url format
        if !aURL.al.isVaildURLString() {
            self.image = placeholderImage
            return
        }
        
        self.kf.setImage(with: URL(string: aURL),
                     placeholder: placeholderImage,
                     options: nil,
                     progressBlock: nil,
                     completionHandler: nil)
    }
}
