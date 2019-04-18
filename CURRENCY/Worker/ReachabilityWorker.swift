//
//  ReachabilityWorker.swift
//  ExchangeHelper
//
//  Created by Meiliang Wen on 07/02/2018.
//  Copyright © 2018 Meiliang Wen. All rights reserved.
//

import Foundation
import Reachability

class ReachabilityWorker {

  static let shared = ReachabilityWorker()

  init() {
    start()
  }

  deinit {
    stop()
    NotificationCenter.default.removeObserver(self)
  }

  lazy var reachability: Reachability? = {
    return Reachability()
  }()

  var isReachable: Bool {
    guard let reachability = reachability else {
      // TODOs: Need to test if this case ever happen!
      return false
    }
    return reachability.connection != .none
  }

  var whenReachable: ((Reachability) -> Void)? {
    didSet {
      reachability?.whenReachable = self.whenReachable
    }
  }

  var whenUnreachable: ((Reachability) -> Void)? {
    didSet {
      reachability?.whenUnreachable = self.whenUnreachable
    }
  }

  func start() {
    do {
      NotificationCenter.default.addObserver(self,
                                             selector: #selector(reachabilityChanged(notification:)),
                                             name: .reachabilityChanged,
                                             object: reachability)
      print("Reachability is starting!")
      guard let reachability = reachability else {
        print("Reachability is nil")
        return
      }
      try reachability.startNotifier()
      print("Reachability start successfully!")
    } catch {
      print("Unable to start a notifier")
    }
  }

  func stop() {
    print("Reachability is stoping!")
    guard let reachability = reachability else {
      print("Reachability is nil")
      return
    }
    reachability.stopNotifier()
    print("Reachability start successfully!")
  }

  @objc func reachabilityChanged(notification: Notification) {
    guard let reachability = notification.object as? Reachability else { return }
    switch reachability.connection {
    case .wifi, .cellular:
      () // connected internet
    case .none:
      () // disconnect internet
    }
  }
}
