//
//  YNTableViewCell.swift
//  YNExpandableCell
//
//  Created by YiSeungyoun on 2017. 3. 11..
//  Copyright © 2017년 SeungyounYi. All rights reserved.
//

import UIKit

/// Inherit YNExpandableCell when you want to use custom accessory type
open class YNExpandableCell: UITableViewCell {
    
    /// Normal Custom Accessory Type change UIImage
    open var normalCustomAccessoryType: UIImageView!
    
    /// Selected Custom Accessory Type change UIImage
    open var selectedCustomAccessoryType: UIImageView!
    
    /// Basic Init method
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.initView()
    }
    
    /// Basic Coder method
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /// Basic awakeFromNib method
    open override func awakeFromNib() {
        super.awakeFromNib()
        
        self.initView()
    }
    
    /// Init method. override this method whatever you like. Mainly about Custom Accessory Type
    open func initView() {
        let width = UIScreen.main.bounds.size.width
        let height = self.frame.size.height
        
        self.normalCustomAccessoryType = UIImageView(frame: CGRect(x: width - 46, y: (height-26)/2, width: 26, height: 26))
        let yn_nor = UIImage(named: "yn_nor", in: Bundle(for: YNExpandableCell.self), compatibleWith: nil)
        self.normalCustomAccessoryType.image = yn_nor
        self.selectedCustomAccessoryType = UIImageView(frame: CGRect(x: width - 46, y: (height-26)/2, width: 26, height: 26))
        let yn_sel = UIImage(named: "yn_sel", in: Bundle(for: YNExpandableCell.self), compatibleWith: nil)
        self.selectedCustomAccessoryType.image = yn_sel
        self.selectedCustomAccessoryType.isHidden = true

        self.contentView.addSubview(self.normalCustomAccessoryType)
        self.contentView.addSubview(self.selectedCustomAccessoryType)
        
        self.selectionStyle = .none
    }
    
    /// Normal function when cell is unclicked
    open func normal() {
        self.selectedCustomAccessoryType.isHidden = true
        self.normalCustomAccessoryType.isHidden = false

        self.rotateAnimationFrom(selectedCustomAccessoryType, toItem: normalCustomAccessoryType, duration: 0.3)
    }
    
    /// Selected function when cell is clicked
    open func selected() {
        self.selectedCustomAccessoryType.isHidden = false
        self.normalCustomAccessoryType.isHidden = true

        self.rotateAnimationFrom(normalCustomAccessoryType, toItem: selectedCustomAccessoryType, duration: 0.3)
    }
    
    fileprivate func rotateAnimationFrom(_ fromItem: UIImageView, toItem: UIImageView, duration: Double) {
        
        let fromRotate  = animationFrom(0, to: Double.pi, key: "transform.rotation", duration: duration)
        let fromOpacity = animationFrom(1, to: 0, key: "opacity", duration: duration)
        
        let toRotate    = animationFrom(-Double.pi, to: 0, key: "transform.rotation", duration: duration)
        let toOpacity   = animationFrom(0, to: 1, key: "opacity", duration: duration)
        
        fromItem.layer.add(fromRotate, forKey: nil)
        fromItem.layer.add(fromOpacity, forKey: nil)
        
        toItem.layer.add(toRotate, forKey: nil)
        toItem.layer.add(toOpacity, forKey: nil)
    }
    
    fileprivate func Init<Type>(_ value : Type, block: (_ object: Type) -> Void) -> Type
    {
        block(value)
        return value
    }
    
    fileprivate func animationFrom(_ from: Double, to: Double, key: String, duration: Double) -> CABasicAnimation {
        return Init(CABasicAnimation(keyPath: key)) {
            $0.duration            = duration
            $0.fromValue           = from
            $0.toValue             = to
            $0.fillMode            = kCAFillModeForwards
            $0.isRemovedOnCompletion = false
        }
    }

}
