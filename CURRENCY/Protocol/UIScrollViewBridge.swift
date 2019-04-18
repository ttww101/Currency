//
//  UITableViewScrollViewBridge.swift
//  ExchangeHelper
//
//  Created by Meiliang Wen on 2018/4/9.
//  Copyright © 2018 Meiliang Wen. All rights reserved.
//

import UIKit

// Bridge ScrollView Delegate to seperate ScrollViewDelegate from UITableViewDelgate.
// Otherwise if just implement UITableViewDelegate and UIScrollViewDelegate at the same time UITableViewDelegate methods won't be called.
protocol UIScrollViewBridge: UIScrollViewDelegate { }
//protocol UIScrollViewBridge { }
//@objc protocol UIScrollViewBridge: class {
//  
//  @objc optional func scrollViewDidScroll(_ scrollView: UIScrollView)
//  @objc optional func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
//  @objc optional func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool)
//  @objc optional func scrollViewDidScrollToTop(_ scrollView: UIScrollView)
//}
