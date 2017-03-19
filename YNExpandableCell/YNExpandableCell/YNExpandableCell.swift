//
//  YNTableViewCell.swift
//  YNExpandableCell
//
//  Created by YiSeungyoun on 2017. 3. 11..
//  Copyright © 2017년 SeungyounYi. All rights reserved.
//

import UIKit

public class YNExpandableCell: UITableViewCell {    
    public var customAccessoryType: UIImageView!
    
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.initView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        self.initView()
    }
    
    public func initView() {
        let width = UIScreen.main.bounds.size.width
        let height = self.frame.size.height
        
        self.customAccessoryType = UIImageView(frame: CGRect(x: width - 46, y: (height-26)/2, width: 26, height: 26))
        self.customAccessoryType.image = UIImage(named: "yn_nor")
        self.contentView.addSubview(self.customAccessoryType)
        
        self.selectionStyle = .none

//        self.customAccessoryType = UIImageView(frame: CGRect(x: 0, y: 0, width: 26, height: 26))
//        self.customAccessoryType.image = UIImage(named: "yn_nor")
//        
//        self.accessoryView = customAccessoryType
}
    
    public func selected() {
//        self.customAccessoryType.alpha = 1
        UIView.animate(withDuration: 0.5, animations: {
//            self.customAccessoryType.alpha = 0
//            self.customAccessoryType.image = UIImage(named: "yn_sel")
            self.accessoryView?.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))
        }) { (completed) in
            
        }

    }
}
