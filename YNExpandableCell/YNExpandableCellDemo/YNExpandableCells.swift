//
//  YNExpandableCells.swift
//  YNExpandableCell
//
//  Created by YiSeungyoun on 2017. 3. 14..
//  Copyright © 2017년 SeungyounYi. All rights reserved.
//

import Foundation
import UIKit

class YNExpandableFirstCell: YNExpandableCell {
    static let ID = "YNExpandableFirstCell"

    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}

class YNExpandableSecondCell: UITableViewCell {
    static let ID = "YNExpandableSecondCell"
    
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

class YNExpandableThirdCell: UITableViewCell {
    static let ID = "YNExpandableThirdCell"
    
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
