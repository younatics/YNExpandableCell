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
    }
    
    public func ynSelected() {
        self.customAccessoryType.image = UIImage(named: "yn_sel")
        self.layoutIfNeeded()

        UIView.animate(withDuration: 0.5, animations: {
//            self.customAccessoryType.removeFromSuperview()
//            self.customAccessoryType.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))
        }) { (completed) in
            
        }

    }
}
