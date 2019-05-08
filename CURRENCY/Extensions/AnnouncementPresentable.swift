//
//  UITableView+NoDataPresented.swift
//  ExchangeHelper
//
//  Created by curry on 2019/04/28.
//  Copyright © 2018 Meiliang Wen. All rights reserved.
//

import UIKit

class AnnouncementView: UIView, XibLiveControl {

  var containerView: UIView?
  var nib: UIView? {
    return R.nib.announcementView.firstView(owner: self)
  }
  @IBOutlet weak var label: UILabel!
  @IBOutlet weak var button: UIButton!

  var text: String = "" {
    didSet {
      label.text = text
    }
  }

  var buttonPressHandler: (() -> Void)?

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    containerView = xibSetup()
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    containerView = xibSetup()
    configure()
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    configure()
  }

  override func prepareForInterfaceBuilder() {
    super.prepareForInterfaceBuilder()
    containerView = xibSetup()
    containerView?.prepareForInterfaceBuilder()
  }

  func configure() {
    label.textColor = KKConfiguration.Theme.mediumGray
    label.font = KKConfiguration.Font.letterFont.size(of: 20)
    label.backgroundColor = .clear
    label.textAlignment = NSTextAlignment.center

    let localizedReload = LanguageWorker.shared.localizedString(key: R.string.uI.reload.key,
                                                                table: .ui)
    button.setAttributedTitle(NSAttributedString(string: localizedReload,
                                                 attributes: [NSAttributedString.Key.foregroundColor: KKConfiguration.Theme.textColor,
                                                              NSAttributedString.Key.font: KKConfiguration.Font.letterFont]),
                              for: .normal)
    button.layer.cornerRadius = 5
    button.layer.borderColor = KKConfiguration.Theme.textColor.cgColor
    button.layer.borderWidth = 1.0
    button.addTarget(self,
                     action: #selector(buttonDidTap(sender:)),
                     for: .touchUpInside)
  }

  @objc func buttonDidTap(sender: Any) {
    buttonPressHandler?()
  }
}

protocol AnnouncementContainer: class {
  var announcementContainerView: UIView? { get set }
}

protocol AnnouncementPresentable {
  var announcementView: AnnouncementView? { get }
  var onView: AnnouncementContainer { get }
  func showAnnouncement(text: String, handler: (() -> Void)?)
  func dismissAnnouncement()
}

extension AnnouncementPresentable {
  var announcementView: AnnouncementView? {
    return AnnouncementView(frame: CGRect.zero)
  }
}

extension AnnouncementPresentable where Self: UIViewController {
  var onView: AnnouncementContainer {
    return view
  }
}

extension UIView: AnnouncementContainer {

  static let announcementContainerTag = 777
  var announcementContainerView: UIView? {
    get {
      return viewWithTag(UITableView.announcementContainerTag)
    }
    set {
      viewWithTag(UITableView.announcementContainerTag)?.removeFromSuperview()
      guard let view = newValue else { return }
      view.tag = UITableView.announcementContainerTag
      addSubview(view)
      view.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        view.topAnchor.constraint(equalTo: topAnchor),
        view.leftAnchor.constraint(equalTo: leftAnchor),
        view.rightAnchor.constraint(equalTo: rightAnchor),
        view.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
  }
}

extension AnnouncementPresentable where Self: UIViewController {

  var announcementView: AnnouncementView? {
    //return R.nib.announcementView.firstView(owner: self) as? AnnouncementView
    return AnnouncementView(frame: self.view.bounds)
  }

  func showAnnouncement(text: String, handler: (() -> Void)? = nil) {
    guard let av = announcementView else { return }
    av.text = text
    if let handler = handler {
      av.buttonPressHandler = handler
    } else {
      av.button.isHidden = true
    }
    onView.announcementContainerView = av
  }

  func dismissAnnouncement() {
    onView.announcementContainerView = nil
  }
}

extension UIViewController: AnnouncementPresentable { }
