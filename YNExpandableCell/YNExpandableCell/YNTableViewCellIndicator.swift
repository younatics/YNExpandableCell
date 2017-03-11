//
//  YNTableViewCellIndicator.swift
//  YNExpandableCell
//
//  Created by YiSeungyoun on 2017. 3. 11..
//  Copyright © 2017년 SeungyounYi. All rights reserved.
//

import Foundation
import UIKit

class YNTableViewCellIndicator: UIView {
    var indicatorColor = UIColor()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setIndicator(color: UIColor) {
        self.indicatorColor = color
    }
    
    
        
}
