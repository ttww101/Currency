//
//  VersionWorker.swift
//  CURRENCY
//
//  Created by Stan Liu on 21/03/2018.
//  Copyright © 2018 Stan Liu. All rights reserved.
//

import Foundation

struct AppKit {

  static var versions: (String, String)? {
    guard
      let info = Bundle.main.infoDictionary,
      let version = info["CFBundleShortVersionString"] as? String,
      let build = info["CFBundleVersion"] as? String
      else { return nil }
    return (version, build)
  }

  static var shortVersion: String {
    guard let versions = AppKit.versions else { return "" }
    return "\(versions.0)"
  }

  static var longVersion: String {
    guard let versions = AppKit.versions else { return "" }
    return "\(versions.0).\(versions.1)"
  }
}

import AssistantKit

struct DeviceKit {
  static let version = Device.version
  static let versionCode = Device.versionCode
  static let osVersion = Device.osVersion
}
