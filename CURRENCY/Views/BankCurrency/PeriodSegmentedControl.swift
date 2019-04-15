//
//  PeriodSegmentedControl.swift
//  CURRENCY
//
//  Created by Stan Liu on 30/03/2018.
//  Copyright © 2018 Stan Liu. All rights reserved.
//

import SJFluidSegmentedControl

protocol PeriodSegmentedControlDelegate: class {
  func segmentedControl(_ segmentedControl: PeriodSegmentedControl,
                        didChangeFromSegmentAtIndex fromIndex: Int,
                        toSegmentAtIndex toIndex: Int)
  func segmentedControl(_ segmentedControl: PeriodSegmentedControl,
                        willChangeFromSegment fromSegment: Int)
}

class PeriodSegmentedControl: UIView,
  SJFluidSegmentedControlDataSource,
  SJFluidSegmentedControlDelegate {

  let titles = Period.all.map { $0.shortTitle }
  weak var delegate: PeriodSegmentedControlDelegate?

  lazy var segmentedControl: SJFluidSegmentedControl = {
    [unowned self] in
    // Setup the frame per your needs
    let _segmentedControl = SJFluidSegmentedControl(frame: CGRect.zero)
    _segmentedControl.delegate = self
    _segmentedControl.dataSource = self
    _segmentedControl.textFont = Configuration.Font.letterFont
    _segmentedControl.textColor = Configuration.Theme.lightGray
    _segmentedControl.selectedSegmentTextColor = .white
    _segmentedControl.selectorViewColor = Configuration.Theme.darkBlue
    _segmentedControl.applyCornerRadiusToSelectorView = false
    _segmentedControl.shapeStyle = .liquid
    _segmentedControl.transitionStyle = .fade
    _segmentedControl.shadowsEnabled = false
    _segmentedControl.cornerRadius = 0

    return _segmentedControl
    }()

  var currentIndex: Int {
    return segmentedControl.currentSegment
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    configureSegmentedControl()
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    configureSegmentedControl()
  }

  func configureSegmentedControl() {
    addSubview(segmentedControl)
    backgroundColor = .clear
    segmentedControl.translatesAutoresizingMaskIntoConstraints = false
    segmentedControl.topAnchor.constraint(equalTo: topAnchor).isActive = true
    segmentedControl.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
    segmentedControl.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    segmentedControl.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    segmentedControl.setCurrentSegmentIndex(Period.defaultValue.index, animated: false)
  }

  func setCurrentSegmentIndex(_ index: Int, animated: Bool) {
    segmentedControl.setCurrentSegmentIndex(index, animated: animated)
  }

  // MARK: DataSource

  func numberOfSegmentsInSegmentedControl(_ segmentedControl: SJFluidSegmentedControl) -> Int {
    return 5
  }
  func segmentedControl(_ segmentedControl: SJFluidSegmentedControl, titleForSegmentAtIndex index: Int) -> String? {
    let title = titles[index]
    return title
  }

  // MARK: Delegate

  // This be called when you rapid drag and loose segmentedControl
  func segmentedControl(_ segmentedControl: SJFluidSegmentedControl, willChangeFromSegment fromSegment: Int) {
    delegate?.segmentedControl(self, willChangeFromSegment: fromSegment)
  }

  func segmentedControl(_ segmentedControl: SJFluidSegmentedControl, didChangeFromSegmentAtIndex fromIndex: Int, toSegmentAtIndex toIndex: Int) {
    delegate?.segmentedControl(self, didChangeFromSegmentAtIndex: fromIndex, toSegmentAtIndex: toIndex)
  }
}
