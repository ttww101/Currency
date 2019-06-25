//
//  LLDropdown.swift
//  LaJoin
//
//  Created by stephen on 2019/6/3.
//  Copyright © 2019 lafresh. All rights reserved.
//

import UIKit

final class LLDropdown: UITextField {
    
    var arrow: Arrow!
    var table: UITableView!
    var shadow: UIView!
    var selectedIndex: Int?
    
    var rowHeight: CGFloat = 30
    
    var rowBackgroundColor: UIColor = .white
    
    var selectedRowColor: UIColor = .lightGray
    
    var hideOptionsWhenSelect = true
    
    var listHeight: CGFloat = 150
    
    var didSelectCompletion: (String, Int) -> () = {selectedText, index in }
    
    //Variables
    fileprivate var tableheightX: CGFloat = 100
    fileprivate var dataArray = [String]()
    fileprivate var parentController:UIViewController?
    fileprivate var pointToParent = CGPoint(x: 0, y: 0)
    fileprivate var backgroundView = UIView()
    
    public var optionArray = [String]() {
        didSet{
            self.dataArray = self.optionArray
        }
    }

    public var optionIds : [Int]?
    
    public var arrowSize: CGFloat = 15 {
        didSet{
            let center =  arrow.superview!.center
            arrow.frame = CGRect(x: center.x - arrowSize, y: center.y - arrowSize/2, width: arrowSize, height: arrowSize)
        }
    }
    
    // Init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        addGesture()
        delegate = self
    }
    
    public required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI () {
        /// Setup right arrow view
        let size = self.frame.height
        self.rightView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: size, height: size))
        self.rightViewMode = .always
        let arrowContainerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: size, height: size))
        self.rightView?.addSubview(arrowContainerView)
        let center = arrowContainerView.center
        arrow = Arrow(origin: CGPoint(x: center.x - arrowSize,
                                      y: center.y - arrowSize / 2), size: arrowSize)
        arrowContainerView.addSubview(arrow)
        
        self.backgroundView = UIView(frame: .zero)
        self.backgroundView.backgroundColor = .clear

        /// Setup UITextFiled self
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 6.0
        placeholder = "請選擇取餐方式"
    }
    
    fileprivate func addGesture() {
        let gesture =  UITapGestureRecognizer(target: self, action:  #selector(touchAction))
        self.addGestureRecognizer(gesture)
        
        let gesture2 =  UITapGestureRecognizer(target: self, action:  #selector(touchAction))
        self.backgroundView.addGestureRecognizer(gesture2)
    }
    
    func getConvertedPoint(_ targetView: UIView, baseView: UIView?) -> CGPoint {
        var pnt = targetView.frame.origin
        if nil == targetView.superview {
            return pnt
        }
        var superView = targetView.superview
        while superView != baseView {
            pnt = superView!.convert(pnt, to: superView!.superview)
            if nil == superView!.superview {
                break
            } else {
                superView = superView!.superview
            }
        }
        return superView!.convert(pnt, to: baseView)
    }
    
    public func showList() {
        if parentController == nil {
            parentController = self.parentViewController
            backgroundView.frame = parentController?.view.frame ?? backgroundView.frame
            pointToParent = getConvertedPoint(self, baseView: parentController?.view)
        }
        parentController?.view.insertSubview(backgroundView, aboveSubview: self)

        if listHeight > rowHeight * CGFloat( dataArray.count) {
            self.tableheightX = rowHeight * CGFloat(dataArray.count)
        }else{
            self.tableheightX = listHeight
        }
        table = UITableView(frame: CGRect(x: pointToParent.x ,
                                          y: pointToParent.y + self.frame.height ,
                                          width: self.frame.width,
                                          height: self.frame.height))
        shadow = UIView(frame: table.frame)
        shadow.backgroundColor = .clear
        
        table.dataSource = self
        table.delegate = self
        table.alpha = 0
        table.separatorStyle = .none
        table.layer.cornerRadius = 3
        table.backgroundColor = rowBackgroundColor
        table.rowHeight = rowHeight
        parentController?.view.addSubview(shadow)
        parentController?.view.addSubview(table)
        self.isSelected = true
        UIView.animate(withDuration: 0.9,
                       delay: 0,
                       usingSpringWithDamping: 0.4,
                       initialSpringVelocity: 0.1,
                       options: .curveEaseInOut,
                       animations: { () -> Void in
                        
                        self.table.frame = CGRect(x: self.pointToParent.x,
                                                  y: self.pointToParent.y+self.frame.height+5,
                                                  width: self.frame.width,
                                                  height: self.tableheightX)
                        self.table.alpha = 1
                        self.shadow.frame = self.table.frame
                        self.shadow.dropShadow()
                        self.arrow.position = .up
                        
        },
                       completion: { (finish) -> Void in
                        
        })
    }
    
    public func hideList() {
        UIView.animate(withDuration: 1.0,
                       delay: 0.0,
                       usingSpringWithDamping: 0.9,
                       initialSpringVelocity: 0.1,
                       options: .curveEaseInOut,
                       animations: { () -> Void in
                        self.table.frame = CGRect(x: self.pointToParent.x,
                                                  y: self.pointToParent.y + self.frame.height,
                                                  width: self.frame.width,
                                                  height: 0)
                        self.shadow.alpha = 0
                        self.shadow.frame = self.table.frame
                        self.arrow.position = .down
        },
                       completion: { (didFinish) -> Void in
                        
                        self.shadow.removeFromSuperview()
                        self.table.removeFromSuperview()
                        self.backgroundView.removeFromSuperview()
                        self.isSelected = false
        })
    }
    
    @objc public func touchAction() {
        isSelected ? hideList() : showList()
    }
    
    func reSizeTable() {
        if listHeight > rowHeight * CGFloat( dataArray.count) {
            self.tableheightX = rowHeight * CGFloat(dataArray.count)
        }else{
            self.tableheightX = listHeight
        }
        UIView.animate(withDuration: 0.2,
                       delay: 0.1,
                       usingSpringWithDamping: 0.9,
                       initialSpringVelocity: 0.1,
                       options: .curveEaseInOut,
                       animations: { () -> Void in
                        self.table.frame = CGRect(x: self.pointToParent.x,
                                                  y: self.pointToParent.y+self.frame.height+5,
                                                  width: self.frame.width,
                                                  height: self.tableheightX)
                        
                        
        },
                       completion: { (didFinish) -> Void in
                        self.shadow.layer.shadowPath = UIBezierPath(rect: self.table.bounds).cgPath
                        
        })
    }
}

// ******************************************
//
// MARK: - UITextFieldDelegate
//
// ******************************************
extension LLDropdown: UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        superview?.endEditing(true)
        return false
    }
}

// ******************************************
//
// MARK: - UITableViewDataSource
//
// ******************************************
extension LLDropdown: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "DropDownCell"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        }
        
        if indexPath.row != selectedIndex {
            cell!.backgroundColor = rowBackgroundColor
        }else {
            cell?.backgroundColor = selectedRowColor
        }
        
        cell!.textLabel!.text = "\(dataArray[indexPath.row])"
        cell!.accessoryType = indexPath.row == selectedIndex ? .checkmark : .none
        cell!.selectionStyle = .none
        cell?.textLabel?.font = self.font
        cell?.textLabel?.textAlignment = self.textAlignment
        return cell!
    }
}

// ******************************************
//
// MARK: - UITableViewDelegate
//
// ******************************************
extension LLDropdown: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = (indexPath as NSIndexPath).row
        let selectedText = self.dataArray[self.selectedIndex!]
        tableView.cellForRow(at: indexPath)?.alpha = 0
        UIView.animate(withDuration: 0.5,
                       animations: { () -> Void in
                        tableView.cellForRow(at: indexPath)?.alpha = 1.0
                        tableView.cellForRow(at: indexPath)?.backgroundColor = self.selectedRowColor
        } ,
                       completion: { (didFinish) -> Void in
                        self.text = "\(selectedText)"
                        
                        tableView.reloadData()
        })
        
        if hideOptionsWhenSelect {
            touchAction()
            endEditing(true)
        }
        
        if let selected = optionArray.firstIndex(where: {$0 == selectedText}) {
            didSelectCompletion(selectedText, selected)
        }
    }
}

//MARK: Arrow
enum Position {
    case left
    case down
    case right
    case up
}

class Arrow: UIView {
    
    var position: Position = .down {
        didSet{
            switch position {
            case .left:
                self.transform = CGAffineTransform(rotationAngle: -CGFloat.pi/2)
                break
                
            case .down:
                self.transform = CGAffineTransform(rotationAngle: CGFloat.pi*2)
                break
                
            case .right:
                self.transform = CGAffineTransform(rotationAngle: CGFloat.pi/2)
                break
                
            case .up:
                self.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
                break
            }
        }
    }
    
    init(origin: CGPoint, size: CGFloat) {
        super.init(frame: CGRect(x: origin.x, y: origin.y, width: size, height: size))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        
        // Get size
        let size = self.layer.frame.width
        
        // Create path
        let bezierPath = UIBezierPath()
        
        // Draw points
        let qSize = size/4
        
        bezierPath.move(to: CGPoint(x: 0, y: qSize))
        bezierPath.addLine(to: CGPoint(x: size, y: qSize))
        bezierPath.addLine(to: CGPoint(x: size/2, y: qSize*3))
        bezierPath.addLine(to: CGPoint(x: 0, y: qSize))
        bezierPath.close()
        
        // Mask to path
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = bezierPath.cgPath
        if #available(iOS 12.0, *) {
            self.layer.addSublayer (shapeLayer)
        } else {
            self.layer.mask = shapeLayer
        }
    }
}

extension UIView {
    
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowRadius = 2
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    
}

extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}


