//
//  Debug.swift
//  CURRENCY
//
//  Created by Stan Liu on 2018/4/21.
//  Copyright © 2018 Stan Liu. All rights reserved.
//

import Foundation

struct Debug {

  private static let dateFormatter: DateFormatter = {
    let _formatter = DateFormatter()
    _formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
    return _formatter
  }()

  static func print(_ items: Any...,
                    separator: String = " ",
                    terminator: String = "\n",
                    file: String = #file,
                    function: String = #function,
                    line: Int = #line) {
    #if DEBUG
    let prefix = dateFormatter.string(from: Date()) + " \(file.typeName).\(function):[\(line)]"
    let content = items.map { "\($0)" } .joined(separator: separator)
    Swift.print("\(prefix) \(content)\n", terminator: terminator)
    #endif
  }
}

extension String {
  var typeName: String {
    return lastPathComponent.stringByDeletingPathExtension
  }

  private var lastPathComponent: String {
    return (self as NSString).lastPathComponent
  }

  private var stringByDeletingPathExtension: String {
    return (self as NSString).deletingPathExtension
  }
}
