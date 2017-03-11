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
    static let kIsExpandedKey = "isExpanded"
    static let kSubrowsKey = "subrowsCount"
    static let kDefaultCellHeight: CGFloat = 44.0
    
    var yNDelegate: YNTableViewDelegate?
    var shouldExpandOnlyOneCell = false
    var _expandableCells = NSMutableDictionary()

    public override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
        self.initView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setYNTableViewDelegate(delegate: YNTableViewDelegate?) {
        
        guard let delegate = delegate else { return }
        self.yNDelegate = delegate
        
    }
    
    func initView() {
        self.delegate = self
        self.dataSource = self
  
    }
    
    // MARK: UITableViewDataSource
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let yNDelegate = self.yNDelegate else { return Int() }

        return yNDelegate.tableView(tableView, numberOfRowsInSection: section)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell()
    }
    
    // MARK: YNTableViewUtils

}
