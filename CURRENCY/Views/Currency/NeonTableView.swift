//
//  NeonTableView.swift
//  ExchangeHelper
//
//  Created by smith on 2019/04/23.
//  Copyright © 2018 Meiliang Wen. All rights reserved.
//

import UIKit

// bridge of delegate
protocol NeonTableViewDelegate: class {
  func neonTableView(_ neonTableView: NeonTableView, heightForRow index: Int) -> CGFloat
  func neonTableView(_ neonTableView: NeonTableView, didSelectAt index: Int)
  func textAlignment(_ neonTableView: NeonTableView) -> NSTextAlignment
}

// bridge of dataSource
protocol NeonTableViewDataSource: class {
  func numberOfRows(_ neonTableView: NeonTableView) -> Int
  func neonTableView(_ neonTableView: NeonTableView, valueOfRows row: Int) -> String
}

// to define which side will be rounded
enum RoundingSide {
  case all, left, right
}

class NeonTableView: UITableView {

  weak var neonDelegate: NeonTableViewDelegate?
  weak var neonDataSource: NeonTableViewDataSource?

  var roundingSide: RoundingSide = .all
  var currentIndex: Int = 0

  init(frame: CGRect) {
    super.init(frame: frame, style: .plain)
    setup()
  }

  override init(frame: CGRect, style: UITableView.Style) {
    super.init(frame: frame, style: style)
    setup()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }

  func setup() {
    delegate = self
    dataSource = self
    isScrollEnabled = false
    separatorStyle = .none
    backgroundColor = .clear

    register(NeonCell.self, forCellReuseIdentifier: String(describing: NeonCell.self))
  }

  func selectRow(at row: Int, animated: Bool) {
    currentIndex = row
    // also need to call TableViewDelegate, to show user what it really shows
    selectRow(at: IndexPath(row: currentIndex, section: 0), animated: animated, scrollPosition: .none)
    // Calling above method does not cause the delegate to receive a tableView(_:willSelectRowAt:) or
    // tableView(_:didSelectRowAt:) message, nor does it send UITableViewSelectionDidChange notifications to observers.
    // call NeonTableViewDelegate, to let which conform its' delegate to do following things
    neonDelegate?.neonTableView(self, didSelectAt: row)
  }

  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesMoved(touches, with: event)
    guard let touch = touches.first else { return }
    // get finger touch location
    let locationY = touch.location(in: self).y
    guard
      let numberOfRows = neonDataSource?.numberOfRows(self),
      numberOfRows != 0
      else { return }
    // calculate index by depend finger in which cell area
    let position = Int(locationY / (contentSize.height / CGFloat(numberOfRows)))
    // set minimum and maximun of index to prevent index out of range
    currentIndex = min(numberOfRows, max(0, position))
    // select row to has effect
    selectRow(at: IndexPath(row: currentIndex, section: 0), animated: true, scrollPosition: .none)
  }
}

extension NeonTableView: UITableViewDelegate {

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return neonDelegate?.neonTableView(self, heightForRow: indexPath.row) ?? 10
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    neonDelegate?.neonTableView(self, didSelectAt: indexPath.row)
  }
}

extension NeonTableView: UITableViewDataSource {

  func numberOfSections(in tableView: UITableView) -> Int { return 1 }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return neonDataSource?.numberOfRows(self) ?? 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NeonCell.self)) as? NeonCell else {
      return NeonCell()
    }
    cell.label.text = neonDataSource?.neonTableView(self, valueOfRows: indexPath.row)
    cell.label.textAlignment = neonDelegate?.textAlignment(self) ?? .center
    cell.roundingSide = roundingSide

    return cell
  }

}
