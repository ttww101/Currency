//
//  Aletheia.swift
//  Aletheia
//
//  Created by stephen on 2019/4/11.
//  Copyright © 2019 stephenchen. All rights reserved.
//
import UIKit
import Foundation

/// Wrapper for Aletheia compatible types. This type provides an extension point for
/// connivence methods in Aletheia.
public struct AletheiaWrapper<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

/// Represents an object type that is compatible with Aletheia. You can use `al` property to get a
/// value in the namespace of Aletheia.
public protocol AletheiaCompatible: AnyObject { }

extension AletheiaCompatible {
    /// Gets a namespace holder for Aletheia compatible types.
    public var al: AletheiaWrapper<Self> {
        get { return AletheiaWrapper(self) }
        set { }
    }
}

/// Represents a value type that is compatible with Aletheia. You can use `al` property to get a
/// value in the namespace of Aletheia.
public protocol AletheiaCompatibleValue {}

extension AletheiaCompatibleValue {
    /// Gets a namespace holder for Aletheia compatible types.
    public var al: AletheiaWrapper<Self> {
        get { return AletheiaWrapper(self) }
        set { }
    }
}

/// Represents a reference type that is compatible with Aletheia. You can use `al` property to get a
/// value in the namespace of Aletheia.
public protocol AletheiaCompatibleReference {}

extension AletheiaCompatibleReference {
    /// Gets a namespace holder for Aletheia compatible types.
    public var al: AletheiaWrapper<Self> {
        get { return AletheiaWrapper(self) }
        set { }
    }
}


extension AletheiaWrapper where Base: UIView {
    
    func convertToWindowCoordinate() -> CGRect {
        return base.convert(base.bounds, to: UIApplication.shared.keyWindow)
    }
}


extension UIScrollView {
    
    func updateContentView() {
        contentSize.height = subviews.sorted(by: { $0.frame.maxY < $1.frame.maxY }).last?.frame.maxY ?? contentSize.height
    }
    
    func updateContentViewWidth() {
        contentSize.width = subviews.sorted(by: { $0.frame.maxX < $1.frame.maxX }).last?.frame.maxX ?? contentSize.width
    }
}

extension UIViewController {
    
    public func present(with presentedViewController: UIViewController) {
        presentedViewController.providesPresentationContextTransitionStyle = true
        presentedViewController.definesPresentationContext = true
        presentedViewController.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        presentedViewController.view.backgroundColor = UIColor.init(white: 0.4, alpha: 0.8)
        self.present(presentedViewController, animated: false, completion: nil)
    }
}


/// NSObject haa been conform to protocol 'AletheiaCompatible',
/// so 'Data' can benefit from it
extension AletheiaWrapper where Base == Data {
    
    public func jsonErrorType<T: Decodable>(type: T.Type, decoder: JSONDecoder? = nil) -> T? {
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        guard let result = try? decoder.decode(T.self, from: base) else {
            return nil
        }
        
        return result
    }
    
    /// 已經加到 Aletheia
    public func utf8() -> String {
        return String(bytes: base, encoding: .utf8) ?? "Data 轉 字串失敗"
    }
}

/// NSObject haa been conform to protocol 'AletheiaCompatible',
/// so 'Data' can benefit from it
extension AletheiaWrapper where Base == String {
    
    /// Check if given string is a vaild Email format ( 已經加到 Aletheia )
    ///
    /// - Returns: Bool
    public func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: base)
    }
    
    /// Check if given string is a vaild URL format
    ///
    /// - Returns: Bool
    public func isVaildURLString() -> Bool {
        if let url = URL(string: base) {
            return UIApplication.shared.canOpenURL(url)
        }
        return false
    }
    
    /// Cut decimal for those price-like strings. For example from 1000.000 to 1000
    ///
    /// - Returns: no decimal string
    public func withoutDecimal() -> String? {
        if let subString = base.split(separator: ".").first {
            return String(subString)
        }
        return nil
    }
    
    
    var htmlToAttributedString: NSAttributedString? {
        guard
            let data = base.data(using: .utf8)
            else { return nil }
        do {
            return try NSAttributedString(data: data, options: [
                NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html,
                NSAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf8.rawValue
                ], documentAttributes: nil)
        } catch let error as NSError {
            print(error.localizedDescription)
            return  nil
        }
    }
    
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}

/// FIXME: 把所有的 tableview id 都換成這個
protocol Describable {
    var typeName: String { get }
    static var typeName: String { get }
}

extension Describable {
    var typeName: String {
        return String(describing: self)
    }
    
    static var typeName: String {
        return String(describing: self)
    }
}

extension Describable where Self: NSObjectProtocol {
    var typeName: String {
        return String(describing: type(of: self))
    }
}

struct ResponseTuples<T: Decodable, E: Decodable> {
    let success: T
    let error: E
}


extension UIApplication {
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
}


extension AletheiaWrapper {
    
    func jsonType2<T, E>(types: (T.Type, E.Type), decoder: JSONDecoder? = nil) -> (T?, E?) where T : Decodable, E : Decodable {
        
        var success: T? = nil
        var error: E? = nil
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        try? success = decoder.decode(T.self, from: Data(base64Encoded: "a")!)
        try? error = decoder.decode(E.self, from: Data(base64Encoded: "a")!)
        
        return (success, error)
    }
    
}
