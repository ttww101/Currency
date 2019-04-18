//
//  XibLoadable.swift
//  ExchangeHelper
//
//  Created by Meiliang Wen on 16/11/2017.
//  Copyright © 2017 Meiliang Wen. All rights reserved.
//


import UIKit
/**
 Use this protocol on a subclass of the class you implement in a .xib file.
 The subclass should be @IBDesignable have ONLY three declarations in it:
 * A specified **SuperClass** (i.e. `typealias SuperClass = MyCustomXibView`)
 * Override **awakeAfter(using aDecoder: NSCoder)** and return `loadNib()`
 * Override **prepareForInterfaceBuilder()** and call `prepareForInterfaceBuilder()`
 * Optionally, specify **nibName** if the .xib file has a different filename than the associated class name.
   (i.e. don't specify if `MyCustomClass.xib` contains a view of type `MyCustomClass`)
 */
protocol XibLoadable where Self: UIView {
  /**
   See `UnXib` description.
   */
  associatedtype SuperClass: UIView
  var nibName: String { get }
  func loadNib() -> Any?
  func prepareForInterfaceBuilder()

}

extension XibLoadable {
  /**
   If your .xib file is not the same name as its corresponding class, then override this variable to return the correct file name.
   */
  var nibName: String {
    let superClassName = String(describing: SuperClass.self)
    return superClassName
  }

  /**
   Return this method in `awakeAfter(using aDecoder: NSCoder)` to switch the dummy subclass's view with the superclass's nib
   */
  func loadNib() -> Any? {
    let bundle = Bundle(for: SuperClass.self)
    return bundle.loadNibNamed(nibName, owner: nil, options: nil)?.first(where: { $0 is SuperClass })
  }

  /**
   Makes it so your .xib file is drawn in storyboards that use it.
   Call this method in `prepareForInterfaceBuilder()` to draw the view in Storyboards.
   NOTE: Make sure the class that uses this method has `@IBDesignable` before the class declaration.
   */
  func prepareSubclassForInterfaceBuilder() {
    guard let view = loadNib() as? SuperClass else { return }
    view.frame = self.bounds
    view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    addSubview(view)
  }
}
