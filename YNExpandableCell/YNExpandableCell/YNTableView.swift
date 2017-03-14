//
//  YNTableView.swift
//  YNExpandableCell
//
//  Created by YiSeungyoun on 2017. 3. 11..
//  Copyright © 2017년 SeungyounYi. All rights reserved.
//

import Foundation
import UIKit

open class YNTableView: UITableView, UITableViewDataSource, UITableViewDelegate {
    internal static let isExpanded = "isExpanded"
    internal static let kSubrowsKey = "subrowsCount"
    internal static let kDefaultCellHeight: CGFloat = 44.0
    
    var yNDelegate: YNTableViewDelegate?
    var shouldExpandOnlyOneCell = false
    var expandableCells: NSMutableDictionary?

    public override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
        self.initView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func initView() {
        
    }
    

}
