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
    open var ynDelegate: YNTableViewDelegate?
    
    public override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
        self.delegate = self
        self.dataSource = self
        self.initView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func registerCellsWith(nibNames: [String], and reuseIdentifiers: [String]) {
        self.checkValueIsSame(first: nibNames, second: reuseIdentifiers)
        
        for i in 0..<nibNames.count {
            self.register(UINib(nibName: nibNames[i], bundle: nil), forCellReuseIdentifier: reuseIdentifiers[i])
        }
    }
    
    public func registerCellsWith(cells: [AnyClass], and reuseIdentifiers: [String]) {
        self.checkValueIsSame(first: cells, second: reuseIdentifiers)
        
        for i in 0..<cells.count {
            self.register(cells[i], forCellReuseIdentifier: reuseIdentifiers[i])
        }
    }
    
    
    
    public func initData() {
        
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        guard let delegate = self.ynDelegate else { return Int () }
        return delegate.tableView(self, numberOfRowsInSection: section)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        return UITableViewCell()
    }
    
    private func checkValueIsSame(first: [Any], second: [Any]) {
        if first.count != second.count {
            fatalError("Must be same count")
        }
    }
    
    internal func initView() {
    }
    

}
