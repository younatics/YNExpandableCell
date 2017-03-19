//
//  YNTableViewCell.swift
//  YNExpandableCell
//
//  Created by YiSeungyoun on 2017. 3. 11..
//  Copyright © 2017년 SeungyounYi. All rights reserved.
//

import UIKit

public class YNExpandableCell: UITableViewCell {
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
        let customAccessoryType = UIImageView(frame: CGRect(x: 0, y: 0, width: 26, height: 26))
        customAccessoryType.image = UIImage(named: "yn_nor")
        self.selectionStyle = .none
        self.accessoryView = customAccessoryType
    }
}
