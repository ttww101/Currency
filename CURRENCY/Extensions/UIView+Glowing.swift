//
//  UIView+Glow.swift
//
//  Translated by James Perlman on 9/7/16.
//
import UIKit
import ObjectiveC
import Dispatch

//private var glowingColor = Configuration.Theme.lightYellow
var glowingColor = UIColor.yellow

protocol GlowingContainer: class {
  var glowContainerView: UIView? { get set }
}

protocol GlowingControl {
  var glowView: UIView? { get }
  var glowContainer: GlowingContainer { get }
  func startGlowing(_ color: UIColor?)
  func stopGlowing()
}

extension UIView: GlowingContainer {
  static let GlowViewTag = 999
  var glowContainerView: UIView? {
    get {
      return viewWithTag(UILabel.GlowViewTag)
    }
    set {
      viewWithTag(UILabel.GlowViewTag)?.removeFromSuperview()

      guard let view = newValue else { return }

      view.tag = UILabel.GlowViewTag
      addSubview(view)
      view.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        view.centerXAnchor.constraint(equalTo: centerXAnchor),
        view.centerYAnchor.constraint(equalTo: centerYAnchor),
        view.leadingAnchor.constraint(greaterThanOrEqualTo: readableContentGuide.leadingAnchor),
        view.trailingAnchor.constraint(lessThanOrEqualTo: readableContentGuide.trailingAnchor),
        view.topAnchor.constraint(greaterThanOrEqualTo: topAnchor),
        view.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor)
        ])
    }
  }
}

extension UIView: GlowingControl {
  var glowView: UIView? {
    var image: UIImage?
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale); do {
      guard let context = UIGraphicsGetCurrentContext() else { return nil }
      self.layer.render(in: context)
      let path = UIBezierPath(rect: self.bounds)
      glowingColor.setFill()
      path.fill(with: .sourceAtop, alpha: 1.0)
      image = UIGraphicsGetImageFromCurrentImageContext()
    }
    UIGraphicsEndImageContext()
    // Make the glowing view itself, and position it at the same
    // point as ourself. Overlay it over ourself.
    let glowView = UIImageView(image: image)
    glowView.tag = UILabel.GlowViewTag
    glowView.center = self.center
    self.superview?.insertSubview(glowView, aboveSubview: self)

    // We don't want to show the image, but rather a shadow created by
    // Core Animation. By setting the shadow to white and the shadow radius to
    // something large, we get a pleasing glow.
    glowView.alpha = 0
    // Finally, keep a reference to this around so it can be removed later
    // If we're already glowing, don't bother
    // The glow image is taken from the current view's appearance.
    // As a side effect, if the view's content, size or shape changes,
    // the glow won't update.
    glowView.layer.shadowColor = glowingColor.cgColor
    glowView.layer.shadowOffset = CGSize.zero
    glowView.layer.shadowRadius = 10
    glowView.layer.shadowOpacity = 1.0
    return glowView
  }
}

extension GlowingControl where Self: UIView {
  var glowContainer: GlowingContainer {
    return self
  }

  func startGlowingWithColor(intensity: CGFloat) {
    startGlowingWithColor(fromIntensity: 0.1,
                          toIntensity: intensity,
                          repeat: true)
  }

  func startGlowingWithColor(fromIntensity: CGFloat,
                             toIntensity: CGFloat,
                             repeat shouldRepeat: Bool) {

    guard let glowView = self.glowView else { return }
    // Create an animation that slowly fades the glow view in and out forever.
    let animation = CABasicAnimation(keyPath: "opacity")
    animation.fromValue = fromIntensity
    animation.toValue = toIntensity
    // Thanks http://stackoverflow.com/questions/7082578/cabasicanimation-unlimited-repeat-without-huge-valf
    animation.repeatCount = shouldRepeat ? .infinity : 0 // HUGE_VAL = .infinity
    animation.duration = 1.0
    animation.autoreverses = true
    animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
    glowView.layer.add(animation, forKey: "pulse")
  }

//  func glowOnceAtLocation(point: CGPoint, inView view: UIView) {
//    self.startGlowingWithColor(color: glowingColor, fromIntensity: 0, toIntensity: 0.6, repeat: false)
//
//    guard let glowView = self.glowView else { return }
//    glowView.center = point
//    view.addSubview(glowView)
//
//    let delay: Double = 2 * Double(Int64(NSEC_PER_SEC))
//    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay) {
//      self.stopGlowing()
//    }
//  }
//
//  func glowOnce() {
//    self.startGlowing()
//
//    let delay: Double = 2 * Double(Int64(NSEC_PER_SEC))
//    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay) {
//      self.stopGlowing()
//    }
//  }

  // Create a pulsing, glowing view based on this one.
  func startGlowing(_ color: UIColor? = nil) {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.init(uptimeNanoseconds: UInt64(0.5))) {
      guard let glowView = self.glowView else { return }
      self.glowContainer.glowContainerView = glowView
      glowingColor = color ?? glowingColor // really change color
      self.startGlowingWithColor(intensity: 0.6)
    }
  }

  // Stop glowing by removing the glowing view from the superview
  // and removing the association between it and this object.
  func stopGlowing() {
    glowContainer.glowContainerView = nil
  }
}
//
//extension UIView {
//  var glowView: UIView? {
//    get {
//      return objc_getAssociatedObject(self, &GLOWVIEW_KEY) as? UIView
//    }
//    set(newGlowView) {
//      guard let glowingView = newGlowView else { return }
//      objc_setAssociatedObject(self, &GLOWVIEW_KEY, glowingView, .OBJC_ASSOCIATION_RETAIN)
//    }
//  }
//
//  func startGlowingWithColor(color: UIColor, intensity: CGFloat) {
//    self.startGlowingWithColor(color: color, fromIntensity: 0.1, toIntensity: intensity, repeat: true)
//  }
//
//  func startGlowingWithColor(color: UIColor, fromIntensity: CGFloat, toIntensity: CGFloat, repeat shouldRepeat: Bool) {
//    // If we're already glowing, don't bother
//    if self.glowView != nil {
//      return
//    }
//
//    // The glow image is taken from the current view's appearance.
//    // As a side effect, if the view's content, size or shape changes,
//    // the glow won't update.
//    var image: UIImage?
//
//    UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale); do {
//      guard let context = UIGraphicsGetCurrentContext() else { return }
//      self.layer.render(in: context)
//
//      let path = UIBezierPath(rect: self.bounds)
//
//      color.setFill()
//
//      path.fill(with: .sourceAtop, alpha: 1.0)
//
//      image = UIGraphicsGetImageFromCurrentImageContext()
//    }
//
//    UIGraphicsEndImageContext()
//
//    guard let glowImage = image else { return }
//
//    // Make the glowing view itself, and position it at the same
//    // point as ourself. Overlay it over ourself.
//    let glowView = UIImageView(image: glowImage)
//    glowView.center = self.center
//    self.superview?.insertSubview(glowView, aboveSubview: self)
//
//    // We don't want to show the image, but rather a shadow created by
//    // Core Animation. By setting the shadow to white and the shadow radius to
//    // something large, we get a pleasing glow.
//    glowView.alpha = 0
//    glowView.layer.shadowColor = color.cgColor
//    glowView.layer.shadowOffset = CGSize.zero
//    glowView.layer.shadowRadius = 10
//    glowView.layer.shadowOpacity = 1.0
//
//    // Create an animation that slowly fades the glow view in and out forever.
//    let animation = CABasicAnimation(keyPath: "opacity")
//    animation.fromValue = fromIntensity
//    animation.toValue = toIntensity
//
//    // Thanks http://stackoverflow.com/questions/7082578/cabasicanimation-unlimited-repeat-without-huge-valf
//    animation.repeatCount = shouldRepeat ? .infinity : 0 // HUGE_VAL = .infinity
//
//    animation.duration = 1.0
//    animation.autoreverses = true
//    animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
//
//    glowView.layer.add(animation, forKey: "pulse")
//
//    // Finally, keep a reference to this around so it can be removed later
//    self.glowView = glowView
//  }
//
//  func glowOnceAtLocation(point: CGPoint, inView view: UIView) {
//    self.startGlowingWithColor(color: glowingColor, fromIntensity: 0, toIntensity: 0.6, repeat: false)
//
//    guard let glowView = self.glowView else { return }
//    glowView.center = point
//    view.addSubview(glowView)
//
//    let delay: Double = 2 * Double(Int64(NSEC_PER_SEC))
//    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay) {
//      self.stopGlowing()
//    }
//  }
//
//  func glowOnce() {
//    self.startGlowing()
//
//    let delay: Double = 2 * Double(Int64(NSEC_PER_SEC))
//    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay) {
//      self.stopGlowing()
//    }
//
//  }
//
//  // Create a pulsing, glowing view based on this one.
//  func startGlowing() {
//    self.startGlowingWithColor(color: glowingColor, intensity: 0.6)
//  }
//
//  // Stop glowing by removing the glowing view from the superview
//  // and removing the association between it and this object.
//  func stopGlowing() {
//    self.glowView?.removeFromSuperview()
//    self.glowView = nil
//  }
//
//}
