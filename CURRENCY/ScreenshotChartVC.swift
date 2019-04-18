//
//  TestCameraVC.swift
//  ExchangeHelper
//
//  Created by Meiliang Wen on 28/03/2018.
//  Copyright © 2018 Meiliang Wen. All rights reserved.
//

import UIKit

class ScreenshotChartVC: UIViewController {

  @IBOutlet weak var chart: LineChart!

  lazy var imageView: UIImageView = {
    return UIImageView()
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    //configureTestImageView()
    view.backgroundColor = .clear
  }

  func configureTestImageView() {
    view.addSubview(imageView)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    imageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    imageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    view.layoutIfNeeded()
    imageView.image = R.image.currency()
  }
}
