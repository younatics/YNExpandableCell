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
    open var ynDelegate: YNTableViewDelegate? {
        didSet {
            self.delegate = self
            self.dataSource = self

        }
    }
    
    private var expandedIndexPaths = [IndexPath]()
    private var expandableIndexPaths = [IndexPath]()
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        
        self.initView()
    }
    
    public override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
        self.initView()
    }
    
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
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
    
    internal func checkExpandRowIn(section: Int) -> Int {
        var openedCellCount = 0
        
        for expandedIndexPaths in self.expandedIndexPaths {
            if expandedIndexPaths.section == section {
                openedCellCount += 1
            }
        }
        
        return openedCellCount
    }
    
    //PRAGMA MARK: YNTableView Delegate
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        guard let delegate = self.ynDelegate else { return Int() }
        guard let numberOfSection = delegate.numberOfSections?(in: self) else { return Int() }
        return numberOfSection
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        guard let delegate = self.ynDelegate else { return Int() }
        
        return delegate.tableView(self, numberOfRowsInSection: section) + self.checkExpandRowIn(section: section)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let delegate = self.ynDelegate else { return UITableViewCell() }
        
        for expandedIndexPath in self.expandedIndexPaths {
            if expandedIndexPath == indexPath {
                let internalIndexPath = IndexPath(row: indexPath.row-1, section: indexPath.section)
                guard let cell = delegate.tableView(self, expandCellAt: internalIndexPath) else { return UITableViewCell() }
                return cell
            }
        }
        
    return delegate.tableView(self, cellForRowAt: indexPath)
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let delegate = self.ynDelegate else { return }
        
        let cell = delegate.tableView(self, expandCellAt: indexPath)
        if cell != nil {
            let insertIndexPath = IndexPath(row: indexPath.row + 1, section: indexPath.section)
            
            self.expandedIndexPaths.append(insertIndexPath)
            self.insertRows(at: [insertIndexPath], with: .top)
        }
    }
    
//    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
////        guard let delegate = self.ynDelegate else { return CGFloat() }
////        let cell = delegate.tableView(self, cellForRowAt: indexPath)
////        return cell.frame.size.height
//        
//        return UITableViewAutomaticDimension
//        
//    }
    
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let delegate = self.ynDelegate else { return CGFloat() }
        let cell = delegate.tableView(self, cellForRowAt: indexPath)
        
//        return cell.frame.size.height

        return UITableViewAutomaticDimension
    }
    
    private func checkValueIsSame(first: [Any], second: [Any]) {
        if first.count != second.count {
            fatalError("Make first and second value count same")
        }
    }
    
    internal func initView() {
    }
    

}
