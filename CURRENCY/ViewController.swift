//
//  ViewController.swift
//  ExchangeHelper
//
//  Created by Meiliang Wen on 07/11/2017.
//  Copyright © 2017 Meiliang Wen. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UIGestureRecognizerDelegate {

  var gestureRecognizer: UIGestureRecognizer!

  override func viewDidLoad() {
    super.viewDidLoad()
    gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(wasDragged(gestureRecognizer:)))
    gestureRecognizer.delegate = self

    let v = UIView(frame: CGRect(x: 30, y: 30, width: 30, height: 30))
    v.backgroundColor = .red
    v.tag = 0
    v.isUserInteractionEnabled = true
    v.addGestureRecognizer(gestureRecognizer)
    view.addSubview(v)
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
     request()
  }

  @objc func wasDragged(gestureRecognizer: UIPanGestureRecognizer) {
    if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
      let translation = gestureRecognizer.translation(in: self.view)
      guard let touchView = gestureRecognizer.view else {
        return
      }
      let touchedViewCenter = touchView.center
      touchView.center = CGPoint(x: touchedViewCenter.x + translation.x, y: touchedViewCenter.y + translation.y)
      gestureRecognizer.setTranslation(CGPoint(x: 0, y: 0), in: self.view)
    }
  }

  func request() {
    Alamofire.request("https://tw.rter.info/capi.php", method: .get).responseJSON { (response) in

      print("Request: \(String(describing: response.request))")   // original url request
      print("Response: \(String(describing: response.response))") // http url response
      print("Result: \(response.result)")                         // response serialization result

      if let json = response.result.value {
        print("JSON: \(json)") // serialized json response
      }

      if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
        print("Data: \(utf8Text)") // original server data as UTF8 string
      }
    }
  }

}
