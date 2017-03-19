//
//  YNExpandableCells.swift
//  YNExpandableCell
//
//  Created by YiSeungyoun on 2017. 3. 14..
//  Copyright © 2017년 SeungyounYi. All rights reserved.
//

import Foundation
import UIKit

class YNExpandableCellEx: YNExpandableCell {

    static let ID = "YNExpandableCellEx"
    
    @IBOutlet var titleLabel: UILabel!

    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    public override func selected() {
        self.customAccessoryType.alpha = 1
        UIView.animate(withDuration: 0.5, animations: {
                        self.customAccessoryType.alpha = 0
//                        self.customAccessoryType.image = UIImage(named: "yn_sel")
        }) { (completed) in
            
        }
        
    }
    

}

class YNSliderCell: UITableViewCell {
    static let ID = "YNSliderCell"
    
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
    }

    
}

class YNSegmentCell: UITableViewCell {
    static let ID = "YNSegmentCell"
    
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
    }

}
